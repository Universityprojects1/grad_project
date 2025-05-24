import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:final_proj/feature/auth/data_source/data/auth_remote.dart';
import 'package:final_proj/feature/auth/data_source/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/api/endpoints.dart';
import '../../../../core/cache/storage_token.dart';
import '../../../../core/di/service_locator.dart';

class AuthRemoteImpl extends AuthRemote {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<String, String>> signUp(AuthModel authModel) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: authModel.email!,
        password: authModel.password!,
      );
      await sl<StorageToken>().setToken(credential.user?.uid ?? "");
      await firestore
          .collection(EndPoints.users)
          .doc(credential.user?.uid)
          .set(authModel.toJson());

      return const Right("User registered successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return const Left('The account already exists for that email.');
      } else {
        return Left('FirebaseAuthException: ${e.message}');
      }
    } catch (e) {
      return Left('Something went wrong: $e');
    }
  }

  @override
  Future<Either<String, String>> signIn(AuthModel authModel) async {
    try {
      final credential =  await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authModel.email!,
        password: authModel.password!,
      );
      await sl<StorageToken>().setToken(credential.user?.uid ?? "");
      return const Right("User logged in successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for that user.');
      } else {
        return Left('FirebaseAuthException: ${e.message}');
      }
    } catch (e) {
      return Left('Something went wrong: $e');
    }
  }

  @override
  Future<Either<String, String>> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right("Password reset email has been sent.");
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "An error occurred.");
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }
}

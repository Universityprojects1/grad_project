import 'package:either_dart/either.dart';
import 'package:final_proj/feature/auth/data_source/model/auth_model.dart';

abstract class SignInRemote {
  Future<Either<String,String>> signIn(AuthModel authModel);
  Future<Either<String,String>> signUp(AuthModel authModel);
  Future<Either<String, String>> resetPassword(String email);
}

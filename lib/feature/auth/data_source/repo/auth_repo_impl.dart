import 'package:either_dart/either.dart';
import 'package:final_proj/feature/auth/data_source/data/auth_remote.dart';
import 'package:final_proj/feature/auth/data_source/model/auth_model.dart';
import 'package:final_proj/feature/auth/data_source/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo{
  AuthRemote authRemote ;

  AuthRepoImpl({required this.authRemote});

  @override
  Future<Either<String, String>> resetPassword(String email) async{
   return await authRemote.resetPassword(email);
  }

  @override
  Future<Either<String, String>> signIn(AuthModel authModel) async{
    return await authRemote.signIn(authModel);
  }

  @override
  Future<Either<String, String>> signUp(AuthModel authModel) async{
    return await authRemote.signUp(authModel);
  }
}
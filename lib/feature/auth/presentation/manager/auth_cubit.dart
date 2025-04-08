import 'package:bloc/bloc.dart';
import 'package:final_proj/feature/auth/data_source/data/auth_remote_impl.dart';
import 'package:final_proj/feature/auth/data_source/model/auth_model.dart';
import 'package:final_proj/feature/auth/data_source/repo/auth_repo.dart';
import 'package:final_proj/feature/auth/data_source/repo/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthRepo authRepo = AuthRepoImpl(authRemote: AuthRemoteImpl());
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  signIn() async {
    emit(AuthSignInLoading());
    var res = await authRepo.signIn(AuthModel(
        email: email.text,
        name: name.text,
        password: password.text,
        phone: phone.text));
    res.fold(
      (left) => emit(AuthSignInFailure(left)),
      (right) => emit(AuthSignInSuccess(right)),
    );
  }

  signUp() async {
    emit(AuthSignUpLoading());
    var res = await authRepo.signUp(AuthModel(
        email: email.text,
        name: name.text,
        password: password.text,
        phone: phone.text));
    res.fold(
      (left) => emit(AuthSignUpFailure(left)),
      (right) => emit(AuthSignUpSuccess(right)),
    );
  }

  resetPassword() async {
    emit(AuthResetPasswordLoading());
    var res = await authRepo.resetPassword(email.text);
    res.fold(
      (left) => emit(AuthResetPasswordFailure(left)),
      (right) => emit(AuthResetPasswordSuccess(right)),
    );
  }
}

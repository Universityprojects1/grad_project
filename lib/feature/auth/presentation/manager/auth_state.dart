part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSignInLoading extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthResetPasswordLoading extends AuthState {}

final class AuthSignInFailure extends AuthState {
  final String error;

  AuthSignInFailure(this.error);
}

final class AuthSignUpFailure extends AuthState {
  final String error;

  AuthSignUpFailure(this.error);
}

final class AuthResetPasswordFailure extends AuthState {
  final String error;

  AuthResetPasswordFailure(this.error);
}

final class AuthSignInSuccess extends AuthState {
  final String res;

  AuthSignInSuccess(this.res);
}

final class AuthSignUpSuccess extends AuthState {
  final String res;

  AuthSignUpSuccess(this.res);
}

final class AuthResetPasswordSuccess extends AuthState {
  final String res;

  AuthResetPasswordSuccess(this.res);
}

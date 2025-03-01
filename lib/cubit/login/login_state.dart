part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User? user;
  final String message;
  LoginSuccess(this.user, this.message);
}

class LoginFailed extends LoginState {
  final String message;
  LoginFailed(this.message);
}

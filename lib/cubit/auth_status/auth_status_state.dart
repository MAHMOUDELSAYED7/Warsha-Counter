part of 'auth_status_cubit.dart';

@immutable
abstract class AuthStatusState {}

class AuthStatusInitial extends AuthStatusState {}

class AuthStatusLoading extends AuthStatusState {}

class AuthStatusSignedIn extends AuthStatusState {
  // final User user;

  // AuthStatusSignedIn(this.user);
}

class AuthStatusSignedOut extends AuthStatusState {}

class AuthStatusError extends AuthStatusState {
  final String message;

  AuthStatusError(this.message);
}

class OpenApp extends AuthStatusState {}

class CloseApp extends AuthStatusState {}

class OldVersion extends AuthStatusState {}

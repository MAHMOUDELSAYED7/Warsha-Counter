part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User? user;
  final String message;
  RegisterSuccess(this.user, this.message);
}

class RegisterFailed extends RegisterState {
  final String message;
  RegisterFailed(this.message);
}

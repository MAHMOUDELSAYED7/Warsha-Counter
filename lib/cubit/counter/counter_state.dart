part of 'counter_cubit.dart';

@immutable
abstract class CounterState {
  const CounterState();
}

class CounterInitial extends CounterState {
  const CounterInitial();
}

class CounterLoading extends CounterState {
  const CounterLoading();
}

class CounterLoaded extends CounterState {
  final List<UserModel> users;
  const CounterLoaded(this.users);
}

class CounterError extends CounterState {
  final String message;
  const CounterError(this.message);
}
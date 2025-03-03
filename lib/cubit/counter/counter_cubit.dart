import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../core/model/user_model.dart';
import '../../firebase/firestore_service.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final FirestoreService _firestoreService;
  StreamSubscription? _subscription;

  CounterCubit(this._firestoreService) : super(const CounterInitial()) {
    _init();
  }

  void _init() {
    emit(const CounterLoading());
    try {
      _subscription =
          _firestoreService.getVerifiedUsersWithEmail().listen((users) {
        emit(CounterLoaded(users));
      }, onError: (error) {
        emit(CounterError('Failed to load users: $error'));
      });
    } catch (e) {
      emit(CounterError('An error occurred: $e'));
    }
  }

  Future<void> updateInsultsById(String userId, int delta) async {
    if (state is CounterLoaded) {
      try {
        await _firestoreService.updateInsultsById(userId, delta);
      } catch (e) {
        emit(CounterError('Failed to update insults: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

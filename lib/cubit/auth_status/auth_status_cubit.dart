import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_status_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  AuthStatusCubit() : super(AuthStatusInitial());
  void checkAuthStatus() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (isClosed) return;
        if (user == null) {
          emit(AuthStatusSignedOut());
        } else {
          emit(AuthStatusSignedIn());
        }
      });
    } on FirebaseAuthException catch (err) {
      if (!isClosed) emit(AuthStatusError(err.message.toString()));
    } catch (err) {
      if (!isClosed) emit(AuthStatusError(err.toString()));
    }
  }

}

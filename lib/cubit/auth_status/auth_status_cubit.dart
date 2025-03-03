import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../firebase/premisions.dart';

part 'auth_status_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  AuthStatusCubit() : super(AuthStatusInitial());
  final FirebasePermissionService _permission = FirebasePermissionService();
  Future<void> checkIfClosed() async {
    try {
      bool? res = await _permission.isAppClosed();
      int? version = await _permission.getAppVersion();
      if (res == true) {
        emit(CloseApp());
        return;
      }  if (version != 1) {
        emit(OldVersion());
        return;
      }
      emit(OpenApp());
      _checkAuthStatus();
    } on FirebaseException catch (err) {
      emit(AuthStatusError(
          err.message ?? "There was an error, Try again later"));
    }
  }

  void _checkAuthStatus() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (isClosed) return;
        if (user == null || !user.emailVerified) {
          emit(AuthStatusSignedOut());
        } else {
          if (user.emailVerified) {
            emit(AuthStatusSignedIn());
          }
        }
      });
    } on FirebaseAuthException catch (err) {
      if (!isClosed) emit(AuthStatusError(err.message.toString()));
    } catch (err) {
      if (!isClosed) emit(AuthStatusError(err.toString()));
    }
  }
}

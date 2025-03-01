import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../firebase/auth_service.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final userCredential = await AuthService().login(email, password);
      emit(LoginSuccess(userCredential.user, 'تم تسجيل الدخول بنجاح'));
    } on FirebaseAuthException catch (err) {
      emit(LoginFailed('فشل تسجيل الدخول'));
      log(err.toString());
    }
  }
}

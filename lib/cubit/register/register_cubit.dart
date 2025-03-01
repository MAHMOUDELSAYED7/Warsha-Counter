import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../firebase/auth_service.dart';

part 'register_state.dart';
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> signUp(String fullName, String email, String password) async {
    if (isClosed) return;
    emit(RegisterLoading());
    try {
      final userCredential = await AuthService().signUp(fullName, email, password);
      if (!isClosed) {
        emit(RegisterSuccess(
          userCredential.user,
          'تحقق من بريدك الإلكتروني لتأكيد الحساب، وسجل الدخول',
        ));
      }
    } on FirebaseAuthException catch (err) {
      if (!isClosed) {
        emit(RegisterFailed('فشل التسجيل'));
      }
      log(err.toString());
    }
  }
}

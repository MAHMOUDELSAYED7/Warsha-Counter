import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../firebase/auth_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> signUp(String fullName, String email, String password) async {
    emit(RegisterLoading());
    try {
      final userCredential =
          await AuthService().signUp(fullName, email, password);
      emit(RegisterSuccess(userCredential.user,
          'تحقق من بريدك الإلكتروني لتأكيد الحساب، وسجل الدخول'));
    } on FirebaseAuthException catch (err) {
      emit(RegisterFailed('فشل التسجيل'));
      log(err.toString());
    }
  }
}

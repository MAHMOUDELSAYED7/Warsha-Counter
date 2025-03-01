import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase/auth_service.dart';


part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoading());
    try {
      await AuthService().sendPasswordResetEmail(email);
      emit(ResetPasswordSuccess(
          'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني'));
    } catch (err) {
      emit(ResetPasswordFailed('فشل إرسال رابط إعادة تعيين كلمة المرور'));
      log(err.toString());
    }
  }
}

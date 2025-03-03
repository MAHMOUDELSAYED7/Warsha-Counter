import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';

import '../core/utils/themes/colors.dart';
import '../core/widgets/elevated_button.dart';
import '../core/widgets/text_form_field.dart';
import '../cubit/reset_password/reset_password_cubit.dart';

class ForgetPasswordBottomSheetWidget extends StatefulWidget {
  const ForgetPasswordBottomSheetWidget({super.key});

  @override
  State<ForgetPasswordBottomSheetWidget> createState() =>
      _ForgetPasswordBottomSheetWidgetState();
}

class _ForgetPasswordBottomSheetWidgetState
    extends State<ForgetPasswordBottomSheetWidget> {
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  late GlobalKey<FormState> _formKey;
  String? _email;
  bool _isLoading = false;
  void _resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      context.cubit<ResetPasswordCubit>().resetPassword(_email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: context.viewInsetsBottom + 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              'نسيت كلمة المرور',
              style: context.textTheme.bodyLarge?.copyWith(
                  color: ColorManager.blue, fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'من فضلك أدخل بريدك الإلكتروني، وسنرسل لك رابط تأكيد لإعادة تعيين كلمة المرور.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(height: 40.h),
          Form(
            key: _formKey,
            child: TextFormFieldWidget(
              label: 'البريد الإلكتروني',
              onSaved: (value) => _email = value,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 25.h),
          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordLoading) {
                _isLoading = true;
              } else {
                _isLoading = false;
              }
              if (state is ResetPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                context.back();
              } else if (state is ResetPasswordFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButtonWidget(
                onPressed: _resetPassword,
                loadingStatus: _isLoading,
                title: 'إرسال الرابط',
              );
            },
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}

void showForgetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    enableDrag: true,
    barrierLabel: 'Forget Password',
    elevation: 10,
    backgroundColor: ColorManager.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => ResetPasswordCubit(),
        child: const ForgetPasswordBottomSheetWidget(),
      );
    },
  );
}

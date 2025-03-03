import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';
import 'package:warsha_counter/view/forget_password.dart';

import '../core/utils/routes.dart';
import '../core/utils/themes/colors.dart';
import '../core/widgets/elevated_button.dart';
import '../core/widgets/text_form_field.dart';
import '../cubit/login/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  late GlobalKey<FormState> _formKey;
  String? _email;
  String? _password;
  bool _isLoading = false;
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      context.cubit<LoginCubit>().login(_email!, _password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 55.h),
            RichText(
              text: TextSpan(
                text: "مرحبًا ",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 32.sp,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "بعودتك",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 32.sp,
                      color: ColorManager.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              "نحن في انتظارك في تطبيقنا سجل الان",
              style: context.textTheme.bodyMedium,
            ),
            SizedBox(height: 40.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    label: "البريد الإلكتروني",
                    onSaved: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 25.h),
                  TextFormFieldWidget(
                    onSaved: (value) => _password = value,
                    label: "كلمة المرور",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "نسيت كلمة السر؟",
                style: context.textTheme.bodySmall?.copyWith(
                  color: ColorManager.blue,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorManager.blue,
                ),
              ).onTap(
                () => showForgetPasswordBottomSheet(context),
              ),
            ),
            SizedBox(height: 32.h),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginLoading) {
                  _isLoading = true;
                }
                if (state is LoginSuccess) {
                  _isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  context.popAndPushNamed(RoutesManager.home);
                }
                if (state is LoginFailed) {
                  _isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButtonWidget(
                  onPressed: _login,
                  title: "تسجيل الدخول",
                  loadingStatus: _isLoading,
                );
              },
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ليس لديك حساب',
                  style: context.textTheme.bodySmall,
                ),
                const SizedBox(width: 2),
                Row(
                  children: [
                    Text(
                      'أنشئ حساب جديد',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: ColorManager.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_outward,
                        color: ColorManager.blue,
                      ),
                    ),
                  ],
                ).onPressed(
                  () => context.pushNamed(RoutesManager.register),
                ),
              ],
            ),
          ],
        ).withAllPadding(16.w),
      ),
    );
  }
}

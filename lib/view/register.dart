import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';

import '../core/utils/themes/colors.dart';
import '../core/widgets/elevated_button.dart';
import '../core/widgets/text_form_field.dart';
import '../cubit/register/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    _formKey = _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    super.initState();
  }

  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;
  String? _fullName;
  String? _email;
  String? _password;
  bool _isLoading = false;
  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      context.cubit<RegisterCubit>().signUp(_fullName!, _email!, _password!);
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
                    text: "بك",
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
              "نحن سعداء بانضمامك إلينا، سجل الآن",
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: ColorManager.blue),
            ),
            SizedBox(height: 40.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    onSaved: (value) => _fullName = value,
                    label: "الاسم الكامل",
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 25.h),
                  TextFormFieldWidget(
                    onSaved: (value) => _email = value,
                    label: "البريد الإلكتروني",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 25.h),
                  TextFormFieldWidget(
                    controller: _passwordController,
                    onSaved: (value) => _password = value,
                    label: "كلمة المرور",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 25.h),
                  TextFormFieldWidget(
                    onSaved: (value) {
                      if (value != _passwordController.text) {
                        _formKey.currentState?.validate();
                      }
                    },
                    label: "تأكيد كلمة المرور",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى تأكيد كلمة المرور';
                      }
                      if (value != _passwordController.text) {
                        return 'كلمات المرور غير متطابقة';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoading) {
                  _isLoading = true;
                } else {
                  _isLoading = false;
                }
                if (state is RegisterSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  context.back();
                } else if (state is RegisterFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButtonWidget(
                  loadingStatus: _isLoading,
                  onPressed: _signUp,
                  title: "إنشاء حساب",
                );
              },
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'لديك حساب بالفعل؟',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorManager.blue,
                  ),
                ),
                const SizedBox(width: 2),
                Row(
                  children: [
                    Text(
                      'تسجيل الدخول',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: ColorManager.blue,
                        fontWeight: FontWeight.w500,
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
                  () => context.back(),
                ),
              ],
            ),
          ],
        ).withAllPadding(16.w),
      ),
    );
  }
}

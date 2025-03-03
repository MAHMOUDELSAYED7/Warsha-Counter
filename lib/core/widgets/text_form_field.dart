import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';

import '../utils/themes/colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.hintText,
    this.label,
    this.onSaved,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
    this.keyboardType,
    this.icon,
    this.title,
    this.obscureText,
    this.initialValue,
    this.onChanged,
  });
  final String? hintText;
  final String? label;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? icon;
  final String? title;
  final bool? obscureText;

  final String? initialValue;
  final void Function(String)? onChanged;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      style: context.textTheme.bodyMedium,
      cursorColor: ColorManager.blue,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: (widget.obscureText == true ? isObscure : false),
      validator: widget.validator ??
          (value) {
            if (value!.isEmpty) {
              return widget.label?.isNotEmpty ?? false
                  ? "${widget.label} لا يمكن أن يكون فارغًا"
                  : "لا يمكن أن يكون الحقل فارغًا";
            } else {
              return null;
            }
          },
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        errorStyle: context.textTheme.bodySmall?.copyWith(
          color: Colors.red,
        ),
        isCollapsed: true,
        isDense: true,
        suffixIcon: widget.obscureText == true
            ? _buildSuffixIcon(Icons.visibility_off, Icons.visibility)
            : null,
        hintText: widget.hintText,
        label: Text(widget.label ?? ""),
        enabledBorder: context.inputDecorationTheme.enabledBorder,
        focusedBorder: context.inputDecorationTheme.focusedBorder,
        errorBorder: context.inputDecorationTheme.errorBorder,
        focusedErrorBorder: context.inputDecorationTheme.focusedErrorBorder,
      ),
    );
  }

  Widget _buildSuffixIcon(IconData icon1, IconData icon2) {
    return IconButton(
      onPressed: () {
        isObscure = !isObscure;
        setState(() {});
      },
      icon: Icon(isObscure == true ? icon1 : icon2),
      color: isObscure == true
          ? ColorManager.black.withValues(alpha: 0.5)
          : ColorManager.black,
      iconSize: 25.r,
    );
  }
}

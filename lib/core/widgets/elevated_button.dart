import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:warsha_counter/core/utils/extensions/extensions.dart';

import '../utils/themes/colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    this.title,
    this.onPressed,
    this.loadingStatus,
    this.size,
    this.fontSize,
    this.backgroundColor,
  });
  final String? title;
  final VoidCallback? onPressed;
  final Size? size;
  final bool? loadingStatus;
  final double? fontSize;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: context.elevatedButtonTheme.style?.copyWith(
          fixedSize: WidgetStatePropertyAll(
            size ?? Size(context.width, 48.h),
          ),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          overlayColor: WidgetStatePropertyAll(backgroundColor),
        ),
        onPressed: onPressed,
        child: loadingStatus == true
            ? const LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [
                  ColorManager.white,
                ],
              )
            : Text(
                title ?? "",
              ));
  }
}

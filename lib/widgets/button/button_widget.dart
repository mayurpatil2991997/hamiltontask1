import 'package:flutter/material.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';


class ButtonWidget extends StatelessWidget {
  final String? text;
  final bool showShadow;
  final Function()? onTap;
  final Color? tColor, bColor,borderColor;
  final TextStyle? textStyle;
  final double? height, width, borderRadius;

  const ButtonWidget({
    Key? key,
    required this.text,
    this.tColor,
    this.bColor,
    this.borderColor,
    this.height,
    this.width,
    this.textStyle,
    this.showShadow = false,
    this.borderRadius,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 6.h,
        width: width ?? 85.w,
        decoration: BoxDecoration(
          color: bColor ?? AppColor.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          border: Border.all(color: borderColor ?? Colors.transparent),
          boxShadow: showShadow
              ? <BoxShadow>[
            const BoxShadow(
              // color: AppColor.appBgColor,
              blurRadius: 60,
              offset: Offset(20, 20),
            ),
          ]
              : [],
        ),
        child: Text(
          text!,
          style: textStyle ??
              AppTextStyle.medium,
        ),
      ),
    );
  }
}

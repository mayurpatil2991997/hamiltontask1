import 'package:flutter/material.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/core/theme/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Widget? backButton;
  final List<Widget> actions;

  CustomAppBar({
    required this.title,
    required this.backgroundColor,
    this.backButton,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
          title,
        style: AppTextStyle.bold.copyWith(
          color: AppColor.whiteColor,
        ),
      ),
      centerTitle: true,
      leading: backButton,
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

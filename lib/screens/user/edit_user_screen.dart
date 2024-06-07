import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/controllers/user/user_controller.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/core/theme/app_text_style.dart';
import 'package:hamilton1/model/user/user_model.dart';
import 'package:hamilton1/utils/validator.dart';
import 'package:hamilton1/widgets/appBar/appBar.dart';
import 'package:hamilton1/widgets/button/button_widget.dart';
import 'package:hamilton1/widgets/text_field/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class EditUserScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final UserListModel user;

  EditUserScreen({required this.user, Key? key}) : super(key: key) {
    userController.nameController.text = user.name ?? "";
    userController.userNameController.text = user.username ?? "";
    userController.emailController.text = user.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: editUser,
        backgroundColor: AppColor.primaryColor,
        actions: [],
        backButton: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: userController.formKey,
          child: Column(
            children: [
              CustomTextField(
                // hintText: enterName,
                controller: userController.nameController,
                validator: (String? value) =>
                    Validators.validateText(value!.trim(), enterName),
                keyboardType: null,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextField(
                // hintText: enterUserName,
                controller: userController.userNameController,
                validator: (String? value) =>
                    Validators.validateText(value!.trim(), enterUserName),
                keyboardType: null,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextField(
                // hintText: enterEmail,
                controller: userController.emailController,
                validator: (String? value) =>
                    Validators.validateEmail(value!.trim()),
                keyboardType: null,
              ),
              SizedBox(
                height: 7.h,
              ),
              ButtonWidget(
                text: update,
                textStyle: AppTextStyle.medium.copyWith(
                  color: AppColor.whiteColor,
                  fontSize: 18
                ),
                onTap: () {
                  if (userController.formKey.currentState!.validate()) {
                    userController.updateUser(
                      user.id!,
                      userController.nameController.text,
                      userController.userNameController.text,
                      userController.emailController.text,
                    );
                    Get.back();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

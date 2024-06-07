import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/controllers/user/user_controller.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/screens/album/album_screen.dart';
import 'package:hamilton1/screens/user/edit_user_screen.dart';
import 'package:hamilton1/utils/validator.dart';
import 'package:hamilton1/widgets/appBar/appBar.dart';
import 'package:hamilton1/widgets/container/container_widget.dart';
import 'package:hamilton1/widgets/text_field/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: user,
        backgroundColor: AppColor.primaryColor,
        actions: [
          InkWell(
            onTap: () {
              addUserWidget();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: const Icon(
                Icons.add,
                size: 32,
                color: AppColor.whiteColor,
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ));
        } else if (userController.userListModel.isEmpty) {
          return const Center(child: Text("No users found"));
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: userController.userListModel.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              final user = userController.userListModel[index];
              return ContainerWidget(
                name: user.name ?? "N/A",
                userName: user.username ?? "N/A",
                phone: user.phone ?? "N/A",
                companyName: user.company?.name ?? "N/A",
                email: user.email ?? "N/A",
                website: user.website ?? "N/A",
                showEditIcon: true,
                showDeleteIcon: true,
                onTapEdit: () {
                  Get.to(() => EditUserScreen(user: user));
                },
                onTapDelete: () {
                  userController.deleteUser(user.id!);
                },
                onTap: () {
                  Get.to(() => AlbumScreen(
                        userId: user.id!,
                      ));
                },
              );
            },
          );
        }
      }),
    );
  }

  Future addUserWidget() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(addUserDetails),
          content: Form(
            key: userController.formKey,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                      hintText: enterName,
                      controller: userController.nameController,
                      validator: (String? value) =>
                          Validators.validateText(value!.trim(),enterName),
                      keyboardType: null),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                      hintText: enterUserName,
                      controller: userController.userNameController,
                      validator: (String? value) =>
                          Validators.validateText(value!.trim(),enterUserName),
                      keyboardType: null),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                      hintText: enterEmail,
                      controller: userController.emailController,
                      validator: (String? value) =>
                          Validators.validateEmail(value!.trim()),
                      keyboardType: null),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if (userController.formKey.currentState!.validate()) {
                  userController.addUser(
                    userController.nameController.text,
                    userController.userNameController.text,
                    userController.emailController.text,
                  );
                  Get.back();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/controllers/user/user_controller.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/screens/album/album_screen.dart';
import 'package:hamilton1/widgets/appBar/appBar.dart';
import 'package:hamilton1/widgets/container/container_widget.dart';

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
        actions: const [],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(
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
                onTap: () {
                  Get.to(() => AlbumScreen(userId: user.id!,));
                },
              );
            },
          );
        }
      }),
    );
  }
}

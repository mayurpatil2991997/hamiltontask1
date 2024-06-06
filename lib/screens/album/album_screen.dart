import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/controllers/album/album_controller.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/screens/photo/photo_screen.dart';
import 'package:hamilton1/widgets/appBar/appBar.dart';
import 'package:hamilton1/widgets/container/container_widget.dart';

class AlbumScreen extends StatefulWidget {
  final int userId;

  const AlbumScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final AlbumController albumController = Get.put(AlbumController());

  @override
  void initState() {
    super.initState();
    albumController.getAlbumsByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: album,
        backgroundColor: AppColor.primaryColor,
        backButton: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.whiteColor,
          ),
        ),
        actions: const [],
      ),
      body: Obx(() {
        if (albumController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ));
        } else if (albumController.albumListModel.isEmpty) {
          return const Center(child: Text("No albums found"));
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: albumController.albumListModel.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              final album = albumController.albumListModel[index];
              return ContainerWidget(
                title: album.title ?? "N/A",
                userId: album.userId.toString() ?? "N/A",
                onTap: () {
                  Get.to(() => PhotoScreen());
                },
              );
            },
          );
        }
      }),
    );
  }
}

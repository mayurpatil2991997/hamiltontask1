import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/controllers/photo/photo_controller.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/widgets/appBar/appBar.dart';
import 'package:hamilton1/widgets/container/container_widget.dart';

class PhotoScreen extends StatefulWidget {
  final int albumId;

  const PhotoScreen({Key? key, required this.albumId}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  final PhotoController photoController = Get.put(PhotoController());

  @override
  void initState() {
    super.initState();
    photoController.getPhotosByAlbumId(widget.albumId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: photo,
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
        if (photoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ));
        } else if (photoController.photoListModel.isEmpty) {
          return const Center(child: Text("No albums found"));
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: photoController.photoListModel.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              final album = photoController.photoListModel[index];
              return ContainerWidget(
                title: album.title ?? "N/A",
                albumId: album.albumId.toString() ?? "N/A",
                photoId: album.id.toString() ?? "N/A",
                image: album.thumbnailUrl,
                onTap: () {},
              );
            },
          );
        }
      }),
    );
  }
}

import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hamilton1/controllers/photo/photo_controller.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/widgets/appBar/appBar.dart';
import 'package:hamilton1/widgets/container/container_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class PhotoScreen extends StatefulWidget {
  final int albumId;

  const PhotoScreen({Key? key, required this.albumId}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  final PhotoController photoController = Get.put(PhotoController());

  // File? _image;
  // final ImagePicker _picker = ImagePicker();

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
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.whiteColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              photoController.pickImage();
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
        if (photoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ));
        } else if (photoController.photoListModel.isEmpty) {
          return const Center(child: Text("No albums found"));
        } else {
          return Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              photoController.image == null
                  ? const SizedBox()
                  : Image.file(
                photoController.image!,
                width: 40.w,
                height: 20.h,
                fit: BoxFit.cover,
              ),
              photoController.image != null ? Padding(
                padding: EdgeInsets.only(
                  right: 3.w
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      photoController.deleteImage();
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 28,
                      color: AppColor.redColor,
                    ),
                  ),
                ),
              ) : const SizedBox(),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: photoController.photoListModel.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, int index) {
                    final photo = photoController.photoListModel[index];
                    return ContainerWidget(
                      title: photo.title ?? "N/A",
                      albumId: photo.albumId.toString() ?? "N/A",
                      photoId: photo.id.toString() ?? "N/A",
                      image: photo.thumbnailUrl,
                      uploadImage: photoController.image,
                      showEditIcon: false,
                      showDeleteIcon: false,
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

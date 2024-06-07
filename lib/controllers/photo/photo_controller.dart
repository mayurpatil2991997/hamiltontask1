import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/dio_services/api_service.dart';
import 'package:hamilton1/dio_services/api_url_constant.dart';
import 'package:hamilton1/model/photo/photo_model.dart';
import 'package:image_picker/image_picker.dart';

class PhotoController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<PhotoListModel> photoListModel = <PhotoListModel>[].obs;

  final ApiService _apiService = ApiService();

  var _image = Rx<File?>(null);
  final picker = ImagePicker();

  File? get image => _image.value;

  void setImage(File? image) {
    _image.value = image;
  }

  Future<void> getPhotosByAlbumId(int albumId) async {
    try {
      isLoading.value = true;
      final url = AppConstant.getPhotoDataByAlbumId(albumId);

      final response = await _apiService.getDataWithForm(url,{});


      if (response.data is List) {
        List<dynamic> jsonList = response.data;

        if (jsonList.isNotEmpty) {
          photoListModel.addAll(jsonList.map((album) => PhotoListModel.fromJson(album)).toList());
        } else {
          Get.snackbar(
            'Oops!',
            'No Albums Found',
            backgroundColor: AppColor.primaryColor,
            colorText: AppColor.whiteColor,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      Get.snackbar(
        'Oops!',
        "Something went wrong. Please try again later.",
        backgroundColor: AppColor.primaryColor,
        colorText: AppColor.whiteColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image.value = File(pickedFile.path);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image from gallery.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void deleteImage() {
    _image.value = null;
  }
}

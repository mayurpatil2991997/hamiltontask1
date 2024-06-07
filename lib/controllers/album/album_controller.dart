import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/dio_services/api_service.dart';
import 'package:hamilton1/dio_services/api_url_constant.dart';
import 'package:hamilton1/model/album/album_model.dart';

class AlbumController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<AlbumListModel> albumListModel = <AlbumListModel>[].obs;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  final Dio _dio = Dio();

  final ApiService _apiService = ApiService();

  Future<void> getAlbumsByUserId(int userId) async {
    try {
      isLoading.value = true;
      final url = AppConstant.getAlbumDataByUserId(userId);

      final response = await _apiService.getDataWithForm(url,{});

      if (response.data is List) {
        List<dynamic> jsonList = response.data;

        if (jsonList.isNotEmpty) {
          albumListModel.addAll(jsonList.map((album) => AlbumListModel.fromJson(album)).toList());
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

  Future<void> addAlbum(String title) async {
    try {
      isLoading.value = true;

      var formData = {
        'title': title,
      };

      String url = '${AppConstant.baseUrl}${AppConstant.getAlbum}';
      print("Request URL: $url");
      print("Request Data: $formData");

      final response = await _dio.post(url, data: formData);

      print("Response data: ${response.data}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;

        AlbumListModel addedUser = AlbumListModel.fromJson(jsonResponse);

        if (addedUser.id != null) {
          Get.snackbar(
            'Yehh!',
            'Album Added Successfully',
            backgroundColor: AppColor.primaryColor,
            colorText: AppColor.whiteColor,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          titleController.clear();
        } else {
          Get.snackbar(
            'Oops!',
            'Failed to add Album',
            backgroundColor: AppColor.primaryColor,
            colorText: AppColor.whiteColor,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioError) {
        print("DioError: ${e.response?.statusCode} - ${e.message}");
      } else {
        print("Unexpected Error: $e");
      }
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

  Future<void> updateAlbum(int userId, String title,) async {
    try {
      isLoading.value = true;

      var formData = {
        'title': title,
      };

      String url = '${AppConstant.baseUrl}albums/$userId';
      print("Request URL: $url");
      print("Request Data: $formData");

      final response = await _dio.put(url, data: formData);

      print("Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar(
          'Success!',
          'Album Updated Successfully',
          backgroundColor: AppColor.primaryColor,
          colorText: AppColor.whiteColor,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioError) {
        print("DioError: ${e.response?.statusCode} - ${e.message}");
      } else {
        print("Unexpected Error: $e");
      }
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

  Future<void> deleteAlbum(int albumId) async {
    try {
      isLoading.value = true;

      final response = await _apiService.deleteDataWithForm(
          '${AppConstant.getAlbum}/$albumId',
          {}
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        albumListModel.removeWhere((album) => album.id == albumId);
        Get.snackbar(
          'Yehh!',
          'Album Deleted Successfully',
          backgroundColor: AppColor.primaryColor,
          colorText: AppColor.whiteColor,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioError) {
        print("DioError: ${e.response?.statusCode} - ${e.message}");
      } else {
        print("Unexpected Error: $e");
      }
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

}

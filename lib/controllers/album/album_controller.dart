import 'dart:convert';
import 'package:get/get.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/dio_services/api_service.dart';
import 'package:hamilton1/dio_services/api_url_constant.dart';
import 'package:hamilton1/model/album/album_model.dart';

class AlbumController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<AlbumListModel> albumListModel = <AlbumListModel>[].obs;

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
}

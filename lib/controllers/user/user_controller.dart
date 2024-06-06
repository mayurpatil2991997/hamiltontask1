import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/dio_services/api_service.dart';
import 'package:hamilton1/dio_services/api_url_constant.dart';
import 'package:hamilton1/model/user/user_model.dart';

class UserController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<UserListModel> userListModel = <UserListModel>[].obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;

      final response = await _apiService.getDataWithForm(
        AppConstant.getUser,
        {},
      );

      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;  // Directly cast to List
        print("Raw Response Data Type: ${jsonList.runtimeType}");
        print("Parsed JSON List: $jsonList");

        if (jsonList.isNotEmpty) {
          print("UserListSuccess - Length: ${jsonList.length}");
          userListModel.addAll(jsonList.map((user) => UserListModel.fromJson(user)).toList());
        } else {
          Get.snackbar(
            'Oops!',
            'No Users Found',
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


}

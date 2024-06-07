import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/dio_services/api_service.dart';
import 'package:hamilton1/dio_services/api_url_constant.dart';
import 'package:hamilton1/model/user/add_user_model.dart';
import 'package:hamilton1/model/user/user_model.dart';

class UserController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<UserListModel> userListModel = <UserListModel>[].obs;
  final RxList<AddUserModel> addUserModel = <AddUserModel>[].obs;

  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final Dio _dio = Dio();


  final formKey = GlobalKey<FormState>();

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
        List<dynamic> jsonList = response.data; // Directly cast to List
        print("Raw Response Data Type: ${jsonList.runtimeType}");
        print("Parsed JSON List: $jsonList");

        if (jsonList.isNotEmpty) {
          print("UserListSuccess - Length: ${jsonList.length}");
          userListModel.addAll(
              jsonList.map((user) => UserListModel.fromJson(user)).toList());
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

  Future<void> addUser(
      String name,
      String userName,
      String email,
      ) async {
    try {
      isLoading.value = true;

      var formData = {
        'name': name,
        'username': userName,
        'email': email,
      };

      String url = '${AppConstant.baseUrl}${AppConstant.getUser}';
      print("Request URL: $url");
      print("Request Data: $formData");

      final response = await _dio.post(url, data: formData);

      print("Response data: ${response.data}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;

        AddUserModel addedUser = AddUserModel.fromJson(jsonResponse);

        if (addedUser.id != null) {
          Get.snackbar(
            'Yehh!',
            'User Added Successfully',
            backgroundColor: AppColor.primaryColor,
            colorText: AppColor.whiteColor,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          nameController.clear();
          userNameController.clear();
          emailController.clear();
          // Get.back();
        } else {
          Get.snackbar(
            'Oops!',
            'Failed to add user',
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

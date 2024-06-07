import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton1/controllers/album/album_controller.dart';
import 'package:hamilton1/controllers/user/user_controller.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/core/theme/app_text_style.dart';
import 'package:hamilton1/model/album/album_model.dart';
import 'package:hamilton1/model/user/user_model.dart';
import 'package:hamilton1/utils/validator.dart';
import 'package:hamilton1/widgets/appBar/appBar.dart';
import 'package:hamilton1/widgets/button/button_widget.dart';
import 'package:hamilton1/widgets/text_field/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class EditAlbumScreen extends StatelessWidget {
  final AlbumController albumController = Get.put(AlbumController());
  final AlbumListModel album;

  EditAlbumScreen({required this.album, Key? key}) : super(key: key) {
    albumController.titleController.text = album.title ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: editAlbum,
        backgroundColor: AppColor.primaryColor,
        actions: [],
        backButton: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: albumController.formKey,
          child: Column(
            children: [
              CustomTextField(
                // hintText: enterName,
                controller: albumController.titleController,
                validator: (String? value) =>
                    Validators.validateText(value!.trim(), enterName),
                keyboardType: null,
              ),
              SizedBox(
                height: 7.h,
              ),
              ButtonWidget(
                text: update,
                textStyle: AppTextStyle.medium.copyWith(
                  color: AppColor.whiteColor,
                  fontSize: 18
                ),
                onTap: () {
                  if (albumController.formKey.currentState!.validate()) {
                    albumController.updateAlbum(
                      album.id!,
                      albumController.titleController.text,
                    );
                    Get.back();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

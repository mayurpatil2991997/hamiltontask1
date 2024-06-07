import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hamilton1/core/strings.dart';
import 'package:hamilton1/core/theme/app_color.dart';
import 'package:hamilton1/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class ContainerWidget extends StatelessWidget {
  final String? name;
  final String? userName;
  final String? title;
  final String? email;
  final String? phone;
  final String? website;
  final String? companyName;
  final String? userId;
  final String? albumId;
  final String? photoId;
  final String? image;
  final bool? showEditIcon;
  final Function()? onTap;
  final Function()? onTapEdit;
  final Function()? onTapDelete;

  const ContainerWidget(
      {this.name,
      this.userName,
      this.title,
      this.email,
      this.phone,
      this.website,
      this.companyName,
      this.userId,
      this.albumId,
      this.photoId,
      this.image,
      this.showEditIcon = false,
      this.onTap,
      this.onTapEdit,
      this.onTapDelete,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              // margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: AppColor.greyColor, //New
                      blurRadius: 25.0,
                      offset: Offset(0, 1))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "$nameText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                name ?? "",
                                style: AppTextStyle.semiBold.copyWith(
                                    color: AppColor.greyColor.withOpacity(0.9),
                                    fontSize: 16),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                  if (title != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$titleText : ",
                          style: AppTextStyle.medium.copyWith(
                              color: AppColor.blackColor, fontSize: 16),
                        ),
                        Expanded(
                          child: Text(
                            title ?? "",
                            style: AppTextStyle.semiBold.copyWith(
                                color: AppColor.greyColor.withOpacity(0.9),
                                fontSize: 16),
                          ),
                        )
                      ],
                    )
                  else
                    const SizedBox(),
                  userName != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  userName != null
                      ? Row(
                          children: [
                            Text(
                              "$userNameText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Text(
                              userName ?? "",
                              style: AppTextStyle.semiBold.copyWith(
                                  color: AppColor.greyColor.withOpacity(0.9),
                                  fontSize: 16),
                            )
                          ],
                        )
                      : const SizedBox(),
                  email != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  if (email != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$emailText : ",
                          style: AppTextStyle.medium.copyWith(
                              color: AppColor.blackColor, fontSize: 16),
                        ),
                        Expanded(
                          child: Text(
                            email ?? "",
                            style: AppTextStyle.semiBold.copyWith(
                                color: AppColor.greyColor.withOpacity(0.9),
                                fontSize: 16),
                          ),
                        )
                      ],
                    )
                  else
                    const SizedBox(),
                  phone != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  phone != null
                      ? Row(
                          children: [
                            Text(
                              "$phoneText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Text(
                              phone ?? "",
                              style: AppTextStyle.semiBold.copyWith(
                                  color: AppColor.greyColor.withOpacity(0.9),
                                  fontSize: 16),
                            )
                          ],
                        )
                      : const SizedBox(),
                  website != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  website != null
                      ? Row(
                          children: [
                            Text(
                              "$websiteText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Text(
                              website ?? "",
                              style: AppTextStyle.semiBold.copyWith(
                                  color: AppColor.blueColor, fontSize: 16),
                            )
                          ],
                        )
                      : const SizedBox(),
                  companyName != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  companyName != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "$comNameText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                companyName ?? "",
                                style: AppTextStyle.semiBold.copyWith(
                                    color: AppColor.greyColor.withOpacity(0.9),
                                    fontSize: 16),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                  userId != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  userId != null
                      ? Row(
                          children: [
                            Text(
                              "$userIdText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Text(
                              userId ?? "",
                              style: AppTextStyle.semiBold.copyWith(
                                  color: AppColor.greyColor.withOpacity(0.9),
                                  fontSize: 16),
                            )
                          ],
                        )
                      : const SizedBox(),
                  photoId != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  photoId != null
                      ? Row(
                          children: [
                            Text(
                              "$photoIdText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Text(
                              photoId ?? "",
                              style: AppTextStyle.semiBold.copyWith(
                                  color: AppColor.greyColor.withOpacity(0.9),
                                  fontSize: 16),
                            )
                          ],
                        )
                      : const SizedBox(),
                  albumId != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  albumId != null
                      ? Row(
                          children: [
                            Text(
                              "$albumIdText : ",
                              style: AppTextStyle.medium.copyWith(
                                  color: AppColor.blackColor, fontSize: 16),
                            ),
                            Text(
                              albumId ?? "",
                              style: AppTextStyle.semiBold.copyWith(
                                  color: AppColor.greyColor.withOpacity(0.9),
                                  fontSize: 16),
                            )
                          ],
                        )
                      : const SizedBox(),
                  image != null
                      ? SizedBox(
                          height: 0.5.h,
                        )
                      : const SizedBox(),
                  image != null ? Image.network(image!) : const SizedBox(),
                  SizedBox(
                    height: 3.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        showEditIcon == true
                            ? InkWell(
                                onTap: onTapEdit,
                                child: const Icon(
                                  Icons.edit,
                                  size: 28,
                                ),
                              )
                            : const SizedBox(),
                        InkWell(
                          onTap: onTapDelete,
                          child: const Icon(
                            Icons.delete,
                            size: 28,
                            color: AppColor.redColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

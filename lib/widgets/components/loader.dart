
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/styling/app_color.dart';

showLoader() {
  Get.dialog(
      barrierDismissible: true,
      const AbsorbPointer(
          child: Center(
        child: CircularProgressIndicator(
          color: AppColor.blue,
          strokeWidth: 2,
        ),
      )));
}

hideLoader() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}

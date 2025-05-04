
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

showLoader() {
  Get.dialog(
      barrierDismissible: true,
      const AbsorbPointer(
          child: Center(
        child: CircularProgressIndicator(),
      )));
}

hideLoader() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}

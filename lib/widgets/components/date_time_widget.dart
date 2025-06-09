import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';

class DateTimeWidget extends StatelessWidget {
  String? title;
  Color? color;
  Color? textColor;
   DateTimeWidget({super.key,this.title,this.color,this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color:color?? AppColor.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title??''.tr,
        style: w400_8a(color: textColor??AppColor.c000000),
      ),
    );
  }
}

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
      //margin: EdgeInsets.only(top: 10, right: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color:color?? AppColor.cF6DBE2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title??''.tr,
        style: w500_7a(color: textColor??AppColor.cC31848),
      ),
    );
  }
}

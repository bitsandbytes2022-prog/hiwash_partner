import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';

class IsSelectButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  const IsSelectButton({super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: height??11,
      width:width?? 11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color:color?? AppColor.c1F9D70 ,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(1),
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color:  AppColor.c1F9D70 ,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          Assets.iconsIcCheck,

        ),
      ),
    );
  }
}

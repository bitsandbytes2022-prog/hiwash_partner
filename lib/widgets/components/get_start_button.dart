import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import 'image_view.dart';

class GetStartButton extends StatelessWidget {
  final Color? color;
  final void Function()? onTap;
  final String text;
  final double? width;
  final double? height;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final bool isLoading;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? boxShadowColor;
  final Color? textColor;
  final bool? isIconSuffix;

  const GetStartButton({
    super.key,
    this.padding,
    this.margin,
    this.color,
    this.textColor,
    this.borderColor,
    this.radius = 100,
    this.onTap,
    this.textStyle,
    this.height = 50,
    this.isLoading = false,
    required this.text,
    this.width,
    this.isIconSuffix = false, this.boxShadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        padding:padding??EdgeInsets.only(left: 29, right: 5,top: 5,bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color ??AppColor.blue,
          boxShadow: [
            BoxShadow(
              color: boxShadowColor??AppColor.blue.withOpacity(0.35),
              blurRadius: 15,
              spreadRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: isLoading
            ? Center(
          child: SizedBox(
            width: width,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: FittedBox(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                text.tr,
                style: textStyle ??
                    w600_16a(color: AppColor.white)
            ),
           19.widthSizeBox,
            Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(100),
                ),
                child:ImageView(path: Assets.iconsIcForward,

                  height: 14,width: 8,) // Example icon
            ),
          ],
        ),
      ),
    );
  }
}
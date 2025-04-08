/*
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pick_a_side/constants/color_constants.dart';
import 'package:pick_a_side/generated/assets.dart';

class CommonPopupWidget extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? marginCloseIcon;
  final Widget? icon;
  final String?image;

  const CommonPopupWidget(
      {super.key,
        this.child,
        this.margin,
        this.onTap,
        this.color,
        this.boxShadow,
        this.marginCloseIcon, this.icon, this.image,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: IntrinsicHeight(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    margin: margin ??
                        const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      color: color ?? ColorConstants.cFFFFFF,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: boxShadow ??
                          [
                            BoxShadow(
                              color: ColorConstants.c02A0FD.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                    ),
                    child: child),
                GestureDetector(
                    onTap: () {
                      Get.back();
                      */
/*   Navigator.pop(context);*//*

                      */
/*Future.delayed(Duration.zero, () {
                        Get.back(); // Delay the pop operation
                      });*//*

                    },
                    child:Container(
                        margin: marginCloseIcon ?? EdgeInsets.only(right: 18),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: color ?? ColorConstants.cFFFFFF,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: ColorConstants.cFFFFFF, width: 2),
                          */
/* boxShadow: boxShadow ?? [
                            BoxShadow(
                              color: ColorConstants.c02A0FD.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],*//*

                        ),
                        child: Image.asset(
                          image??Assets.imagesIcCloseRound,
                          height: 20,
                          width: 20,
                          color: ColorConstants.c000000,
                        )


                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

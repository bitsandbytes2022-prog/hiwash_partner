import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import '../../styling/app_font_poppins.dart';


class QrDialog extends StatelessWidget {
  const QrDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,

        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipPath(
              clipper: MultipleRoundedCurveClipper(),
              child: Container(
                margin: EdgeInsets.only(left: 21, right: 21, top: 30),
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),

                  boxShadow: [BoxShadow(
                    color: AppColor.c142293.withOpacity(0.25),
                    blurRadius: 25,
                    spreadRadius: 0,

                    offset: Offset(0, 5),
                  )]


                ),
                padding: EdgeInsets.symmetric(horizontal: 27),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    40.heightSizeBox,
                    Image.asset(Assets.iconsIcCrown, height: 25, width: 27),
                    7.heightSizeBox,
                    Text("Success!", style: w700_22a(color: AppColor.c2C2A2A)),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Your payment is complete, and your ",
                            style: w400_12p(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: "Unlimited Washes",
                            style: w500_12p(color: AppColor.c2C2A2A),
                          ),
                          TextSpan(
                            text: " plan is now activated.",
                            style: w400_12p(color: AppColor.c455A64),
                          ),
                        ],
                      ),
                    ),
                    15.heightSizeBox,
                    Image.asset(Assets.imagesDemo, height: 215, width: 215),
                    31.heightSizeBox,
                    Text(
                      "Congratulations!",
                      style: w600_14a(color: AppColor.c2C2A2A),
                    ),
                    9.heightSizeBox,
                    Text(
                      "Scan to unlock weekly washes,\nexclusive offers, and amazing deals!",
                      textAlign: TextAlign.center,
                      style: w400_12p(color: AppColor.c455A64),
                    ),
                    33.heightSizeBox,
                  ],
                ),
              ),
            ),
            Container(
              height: 59,
              width: 59,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.c1F9D70.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(7),

              child: Image.asset(Assets.iconsIcVerify, height: 49, width: 49),
            ),
          ],
        ),
      ),
    );
  }
}

class MultipleRoundedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 20;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos), radius: Radius.circular(5));
    }
    path.lineTo(size.width, 0);
    path.lineTo(0, 0); // Close the path
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

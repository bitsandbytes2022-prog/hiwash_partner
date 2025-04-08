import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../route/route_strings.dart';
import '../../../../styling/app_color.dart';
import '../../../../styling/app_font_anybody.dart';
import '../../../../widgets/components/image_view.dart';

class BgWidget extends StatelessWidget {
  String imagePath;

  BgWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Column(
        children: [
          Stack(
            children: [
              ImageView(path: imagePath),
              Positioned(
                top: 50,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    Get.offAllNamed(RouteStrings.loginScreen);
                  },
                  child: Text("skip", style: w400_16a(color: AppColor.white)),
                ),
              ),
            ],
          ),
          Container(
            width: Get.width,
            height: double.maxFinite,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

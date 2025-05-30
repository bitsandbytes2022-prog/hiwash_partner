import 'package:flutter/material.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';

import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_view.dart';

class RewardedCustomersScreen extends StatelessWidget {
  const RewardedCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( bottom: 40),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.c142293.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),

          shrinkWrap: true,

          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ProfileImageView(radiusStack: 4, radius: 17),
                  9.widthSizeBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ibrahim Bafqia",
                          style: w600_12a(color: AppColor.c2C2A2A),
                        ),
                        Text("Flat 30% off", style: w400_10a()),
                      ],
                    ),
                  ),
                  20.widthSizeBox,
                  Text("15-Oct-2025 / 09:15 AM", style: w400_10a()),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                10.heightSizeBox,
                DashedLineWidget(),
                10.heightSizeBox,
              ],
            );
          },
          itemCount: 20,
        ),
      ),



    );
  }
}

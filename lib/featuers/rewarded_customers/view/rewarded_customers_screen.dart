import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/featuers/reward/controller/reward_controller.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/components/data_formet.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';

import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_view.dart';

class RewardedCustomersScreen extends StatelessWidget {
   RewardedCustomersScreen({super.key});
RewardController rewardController = Get.put(RewardController());
  @override
  Widget build(BuildContext context) {
   // rewardController.getRewardedCustomersAll();
    return Padding(
      padding: EdgeInsets.only( bottom: 40,top: 15),
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

       child: Obx(() {
      return rewardController.getRewardedCustomersModel.value?.data?.isNotEmpty == true
    ? ListView.separated(
    padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            10.heightSizeBox,
            DashedLineWidget(),
            10.heightSizeBox,
          ],
        );
      },
      itemCount: rewardController.getRewardedCustomersModel.value!.data!.length,
      itemBuilder: (context, index) {
        var customerAllData = rewardController.getRewardedCustomersModel.value!.data![index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ProfileImageView(
                radiusStack: 4,
                radius: 17,
                imagePath: customerAllData.profilePicUrl ?? '',
              ),
              9.widthSizeBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerAllData.customerName ?? '',
                      style: w600_12a(color: AppColor.c2C2A2A),
                    ),
                    Text(customerAllData.offerTitle ?? '', style: w400_10a()),
                  ],
                ),
              ),
              20.widthSizeBox,
              Text(
                formatServerDate(customerAllData.redeemedAt.toString()),
                style: w400_10a(),
              ),
            ],
          ),
        );
      },
    )
        : Container(
    padding: const EdgeInsets.all(16),
    alignment: Alignment.center,
    child: Text(
    "No rewards available",
    ),
    );
  }),
      ),



    );
  }
}

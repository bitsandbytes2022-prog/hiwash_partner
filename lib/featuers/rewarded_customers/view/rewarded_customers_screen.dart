import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/featuers/reward/controller/reward_controller.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/components/data_formet.dart';
import 'package:hiwash_partner/widgets/components/doted_line.dart';
import 'package:hiwash_partner/widgets/components/profile_image_view.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../controller/rewarded_customer_controller.dart';

class RewardedCustomersScreen extends StatefulWidget {
  RewardedCustomersScreen({super.key});

  @override
  State<RewardedCustomersScreen> createState() => _RewardedCustomersScreenState();
}

class _RewardedCustomersScreenState extends State<RewardedCustomersScreen> {
  RewardedCustomerController rewardedCustomerController = Get.put(RewardedCustomerController());
@override
  void initState() {
rewardedCustomerController.getRewardedCustomersAll();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // rewardController.getRewardedCustomersAll();
    return Padding(
      padding: EdgeInsets.only(bottom: 40, top: 15),
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
          return rewardedCustomerController
                      .getRewardedCustomersModel
                      .value
                      ?.data
                      ?.isNotEmpty ==
                  true
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
                itemCount:
                rewardedCustomerController
                        .getRewardedCustomersModel
                        .value!
                        .data!
                        .length,
                itemBuilder: (context, index) {
                  var customerAllData =
                  rewardedCustomerController
                          .getRewardedCustomersModel
                          .value!
                          .data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        ProfileImageView(
                          radiusStack: 4,
                          radius: 17,
                          imagePath: customerAllData.profilePicUrl ?? '',
                          isVisibleStack: customerAllData.isPremium==0?false:true,
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
                              Text(
                                customerAllData.offerTitle ?? '',
                                style: w400_10a(),
                              ),
                            ],
                          ),
                        ),
                        20.widthSizeBox,
                        Text(
                          formatServerDate(
                            customerAllData.redeemedAt.toString(),
                          ),
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
                child: Text("No rewards available"),
              );
        }),
      ),
    );
  }
}

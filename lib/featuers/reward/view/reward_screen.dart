import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/components/hi_wash_button.dart';
import 'package:hiwash_partner/widgets/components/hi_wash_text_field.dart';

import 'package:hiwash_partner/widgets/components/image_view.dart'
    show ImageView;
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/custom_bottomsheet.dart';
import '../../../widgets/components/date_time_widget.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/is_select_button.dart';
import '../../../widgets/components/offers_grid_container.dart';
import '../../../widgets/components/profile_image_view.dart';
import '../controller/reward_controller.dart';

class RewardScreen extends StatelessWidget {
  RewardScreen({super.key});

  final RewardController rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AppDialog(
                  child: approveRewardDialog(),
                  padding: EdgeInsets.zero,
                );
              },
            );
          },
          child: Container(
            height: 95,
            decoration: BoxDecoration(
              color: AppColor.cC31848,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cC31848.withOpacity(0.30),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 14, top: 12),
                      child: Text(
                        "53",
                        style: w700_27a(color: AppColor.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 9),
                      child: Text(
                        "kTotalWashes".tr,
                        style: w500_12p(
                          color: AppColor.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                ImageView(
                  path: Assets.imagesRewardImage,
                  height: 59,
                  width: 107,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 14, top: 12),
                      child: Text(
                        "89",
                        style: w700_27a(color: AppColor.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 9),
                      child: Text(
                        "Rewarded\nCustomers",
                        style: w500_12p(
                          color: AppColor.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        21.heightSizeBox,
        Row(
          children: [
            Expanded(
              child: HiWashTextField(
                readOnly: true,
                hintStyle: w400_12p(color: AppColor.c2C2A2A),

                hintText: "All Offers",
                suffixIcon: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ImageView(
                    path: Assets.iconsIcDropDown,
                    height: 5,
                    width: 9,
                  ),
                ),
              ),
            ),
            8.widthSizeBox,
            Expanded(
              child: HiWashTextField(
                hintStyle: w400_12p(color: AppColor.c2C2A2A),
               // padding: EdgeInsets.only(left: 10,right: 10),
                readOnly: true,
                hintText: "Sort by Expiry",
                suffixIcon: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ImageView(
                    path: Assets.iconsIcDropDown,
                    height: 5,
                    width: 9,
                  ),
                ),
              ),
            ),
          ],
        ),
        19.heightSizeBox,
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 30),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          clipBehavior: Clip.hardEdge,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            //  mainAxisExtent: Get.height * 0.22,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

                showModalBottomSheet(
                  context: Get.context!,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return CustomBottomSheet(
                      child: viewOfferDetailBottomSheet(),
                    );
                  },
                );
              },
              child: OffersGridContainer(),
            );
          },
        ),

      ],
    );

  }

  Widget viewOfferDetailBottomSheet() {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<RewardController>(
          init: RewardController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              20.heightSizeBox,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ImageView(path: Assets.imagesImOffer),
                      ),
                      Positioned(
                        top: 35,
                        left: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DateTimeWidget(
                              title: "0:3 HRS - 34 MINS",
                              textColor: AppColor.c000000,
                              color: AppColor.white.withOpacity(0.5),
                            ),
                            SizedBox(height: 13),
                            Text(
                              "Special Offers\nFREE Accessories",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rumRaisin(
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                color: AppColor.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 17,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: ImageView(
                            path: Assets.imagesDemo,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DashedLineWidget(),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exclusive Products.",
                        style: w700_16a(color: AppColor.c2C2A2A),
                      ),
                      Text(
                        "Special Offers & FREE Coupons – Grab Yours Today!",
                        style: w400_12p(),
                      ),
                      13.heightSizeBox,

                      Align(
                        child: ImageView(
                          path: Assets.imagesTimeView,
                          height: 37,
                        ),
                      ),
                      18.heightSizeBox,
                      Obx(
                        () => Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColor.cF6F7FF,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColor.c5C6B72.withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    rewardController.isSelected.value = 1;
                                    rewardController.update();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          rewardController.isSelected.value == 1
                                              ? AppColor.c142293
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              rewardController
                                                          .isSelected
                                                          .value ==
                                                      1
                                                  ? AppColor.c142293
                                                      .withOpacity(0.25)
                                                  : Colors.transparent,
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      "Detail",
                                      style: w600_12a(
                                        color:
                                            rewardController.isSelected.value ==
                                                    1
                                                ? AppColor.white
                                                : AppColor.c455A64,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25),
                                GestureDetector(
                                  onTap: () {
                                    rewardController.isSelected.value = 2;
                                    rewardController.update();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          rewardController.isSelected.value == 2
                                              ? AppColor.c142293
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              rewardController
                                                          .isSelected
                                                          .value ==
                                                      2
                                                  ? AppColor.c142293
                                                      .withOpacity(0.25)
                                                  : Colors.transparent,
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      "Rewarded Customers",
                                      style: w600_12a(
                                        color:
                                            rewardController.isSelected.value ==
                                                    2
                                                ? AppColor.white
                                                : AppColor.c455A64,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      15.heightSizeBox,

                      if (rewardController.isSelected.value == 1) ...[
                        Text(
                          "Don't miss out on amazing deals! We’re offering exclusive products, special discounts, and FREE coupons just for you. This limited-time offer is your chance to grab exciting rewards before they’re gone.",
                        style: w400_12p(),),
                        10.heightSizeBox,
                        Text(
                          "Why You Shouldn’t Miss This",
                          style: w600_12p(),
                        ),
                        6.heightSizeBox,
                        for (var i = 0; i < 5; i++)
                          Text(
                            "✔ Exclusive products available for a limited time",
                            style: w400_10p(color: AppColor.c455A64),
                          ),
                        10.heightSizeBox,
                        Text(
                          "Claim your rewards today and make the most of these incredible deals! 🎉",
                          style: w400_12p(color: AppColor.c455A64),
                        ),
                      ],
                      if (rewardController.isSelected.value == 2) ...[
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),

                          shrinkWrap: true,

                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    ProfileImageView(
                                      radiusStack: 4,

                                      radius: 17,
                                    ),
                                    9.widthSizeBox,
                                    Expanded(
                                      child: Text(
                                        "Ibrahim Bafqia",
                                        style: w600_12a(
                                          color: AppColor.c2C2A2A,
                                        ),
                                      ),
                                    ),
                                    20.widthSizeBox,
                                    Text(
                                      "15-Oct-2025 / 09:15 AM",
                                      style: w400_10a(),
                                    ),
                                  ],
                                ),
                              ],
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
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget approveRewardDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              27.heightSizeBox,
              Text(
                "Approve Reward Sharing",
                style: w700_18a(color: AppColor.c2C2A2A),
              ),
              Text("Special Offers & FREE Coupons.", style: w400_12p()),
              6.heightSizeBox,
              Container(
                width: Get.width,

                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ImageView(path: Assets.imagesImOffer),
                    ),
                    Positioned(
                      top: 35,
                      left: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DateTimeWidget(
                            title: "0:3 HRS - 34 MINS",
                            textColor: AppColor.c000000,
                            color: AppColor.white.withOpacity(0.5),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Special Offers\nFREE Accessories",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rumRaisin(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 17,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: ImageView(
                          path: Assets.imagesDemo,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              21.heightSizeBox,
              ProfileImageView(radius: 24, radiusStack: 6),
              11.heightSizeBox,
              Text("CUSTOMER", style: w400_10a()),
              Text("Ibrahim Bafqia", style: w400_16a(color: AppColor.c2C2A2A)),
              11.heightSizeBox,
              ImageView(path: Assets.imagesTimeView, height: 25),
              22.heightSizeBox,
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cF6F7FF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              DashedLineWidget(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 21, bottom: 21),
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.cC31848),
                      ),
                      child: Text(
                        "Decline",
                        style: w500_14a(color: AppColor.cC31848),
                      ),
                    ),
                  ),
                  15.widthSizeBox,
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: Get.context!,
                        builder: (context) {
                          return AppDialog(
                            onTap: () {
                              Get.back();
                              Get.back();
                            },
                            child: successDialog(),
                            padding: EdgeInsets.zero,
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.c1F9D70,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.c1F9D70.withOpacity(0.30),
                            spreadRadius: 0,
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Text(
                        "Approve",
                        style: w500_14a(color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget successDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              30.heightSizeBox,
              Container(
                width: Get.width,

                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ImageView(
                        path: Assets.imagesImSussess,
                        width: Get.width,
                        height: 222,
                      ),
                    ),
                  ],
                ),
              ),
              21.heightSizeBox,
              Text("Success!", style: w700_22a(color: AppColor.c2C2A2A)),
              Text(
                "Reward Has Been\nSuccessfully Shared!",
                textAlign: TextAlign.center,
                style: w400_16p(),
              ),
              18.heightSizeBox,
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cF6F7FF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              DashedLineWidget(),

              Padding(
                padding: EdgeInsets.only(top: 23, left: 19, bottom: 23),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfileImageView(radius: 20, radiusStack: 4),
                    9.widthSizeBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ibrahim Bafqia",
                          style: w600_14a(color: AppColor.c2C2A2A),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IsSelectButton(),
                            5.widthSizeBox,
                            Text(
                              "09-May-2024",
                              style: w400_12a(color: AppColor.c455A64),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: DotedVerticalLine(height: 5),
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IsSelectButton(),
                            5.widthSizeBox,
                            Text(
                              "Buy 1 Get 1 Free ",
                              style: w400_10a(color: AppColor.c455A64),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

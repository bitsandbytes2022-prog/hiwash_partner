import 'package:cached_network_image/cached_network_image.dart';
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
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/date_time_widget.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/is_select_button.dart';
import '../../../widgets/components/loader.dart';
import '../../../widgets/components/offers_grid_container.dart';
import '../../../widgets/components/profile_image_view.dart';
import '../controller/reward_controller.dart';
import '../model/offer_response_model.dart';

class RewardScreen extends StatelessWidget {
  RewardScreen({super.key});

  final RewardController rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    // rewardController.getAllOffers();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => GestureDetector(
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
                          rewardController
                                  .offerResponseModel
                                  .value
                                  ?.data
                                  ?.summary
                                  ?.totalReward
                                  .toString() ??
                              '',
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
                          rewardController
                                  .offerResponseModel
                                  .value
                                  ?.data
                                  ?.summary
                                  ?.rewardedCustomers
                                  .toString() ??
                              '',
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
        ),
        21.heightSizeBox,
        Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          rewardController.getAllOffers();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            //color: AppColor.c5C6B72.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColor.c5C6B72.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "All offers",
                                style: w400_12p(color: AppColor.c2C2A2A),
                              ),

                              Spacer(),
                              ImageView(
                                path: Assets.iconsIcDropDown,
                                height: 5,
                                width: 9,
                                color: AppColor.c2C2A2A,
                              ),
                              //Icon(Icons.arrow_drop_down, size: 20),
                            ],
                          ),
                        ),
                      ) /*HiWashTextField(
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
                      ),*/,
                    ),
                    8.widthSizeBox,
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          rewardController.isVisible.value =
                              !rewardController.isVisible.value;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            //color: AppColor.c5C6B72.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColor.c5C6B72.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Obx(
                                () => Text(
                                  rewardController.sortByText.value,
                                  style: w400_12p(color: AppColor.c2C2A2A),
                                ),
                              ),

                              Spacer(),
                              ImageView(
                                path: Assets.iconsIcDropDown,
                                height: 5,
                                width: 9,
                                color: AppColor.c2C2A2A,
                              ),
                              //Icon(Icons.arrow_drop_down, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                19.heightSizeBox,
                Obx(() {
                  final List<Offers> data =
                      rewardController.offerResponseModel.value?.data?.offers ??
                      [];
                  return data.isNotEmpty
                      ? GridView.builder(
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
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {

                              showLoader();
                              await rewardController.getOffersById(data[index].id!,);
                              hideLoader();
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
                              ).then((_) {
                                rewardController.isSelected.value = 1;
                              });
                            },
                            child: OffersGridContainer(offer: data[index]),
                          );
                        },
                      )
                      : Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Data is not found',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      );
                  ;
                }),
              ],
            ),
            Obx(
              () =>
                  rewardController.isVisible.value
                      ? Positioned(
                        top: 50,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,

                          width: 180,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          //   color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  rewardController.toggleSortOrder();
                                  rewardController.update();
                                  rewardController.isVisible.value =
                                      false; // Hide popup
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text("Ascending order"),
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  rewardController.toggleSortOrder();
                                  rewardController.update();
                                  rewardController.isVisible.value =
                                      false; // Hide popup
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text("Descending order"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Container(),
            ),
          ],
        ),
      ],
    );
  }

  Widget viewOfferDetailBottomSheet() {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(() {
          var rewardDetail =
              rewardController.getOffersByIdModel.value?.data?.first;
          if (rewardDetail == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(

            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightSizeBox,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColor.c2C2A2A.withOpacity(0.2),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          height: 187,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          imageUrl:
                              rewardDetail.image?.isNotEmpty == true
                                  ? rewardDetail.image!
                                  : Assets.imagesImOffer,
                          placeholder:
                              (context, url) => Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Image.asset(
                                Assets.imagesImOffer,
                                height: 187,
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                              ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        left: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DateTimeWidget(
                              title: rewardController.timeUntilExpiry(
                                rewardDetail.expiryDate ?? "No Expiry",
                              ),
                            ),
                            13.heightSizeBox,
                            Text(
                              rewardDetail.title ?? "",
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
                          child: CachedNetworkImage(
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            imageUrl:
                                rewardDetail.qRCodeUrl?.isNotEmpty == true
                                    ? rewardDetail.qRCodeUrl!
                                    : Assets.imagesDemo,
                            placeholder:
                                (context, url) => Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Image.asset(
                                  Assets.imagesDemo,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DashedLineWidget(),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rewardDetail.title ?? '',
                        style: w700_16a(color: AppColor.c2C2A2A),
                      ),
                      Text(rewardDetail.offerDetails ?? '', style: w400_12p()),
                      13.heightSizeBox,
                      Align(
                        child: ImageView(
                          path: Assets.imagesTimeView,
                          height: 37,
                        ),
                      ),
                      18.heightSizeBox,
                      // Selection buttons
                      Obx(
                        () => Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.all(4),
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          rewardController.isSelected.value == 1
                                              ? AppColor.c142293
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow:
                                          rewardController.isSelected.value == 1
                                              ? [
                                                BoxShadow(
                                                  color: AppColor.c142293
                                                      .withOpacity(0.25),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 5),
                                                ),
                                              ]
                                              : [],
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
                                  onTap: () async {
                                    rewardController.isSelected.value = 2;
                                    await rewardController
                                        .getRewardedCustomersById(
                                          rewardDetail.id ?? 0,
                                        );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          rewardController.isSelected.value == 2
                                              ? AppColor.c142293
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow:
                                          rewardController.isSelected.value == 2
                                              ? [
                                                BoxShadow(
                                                  color: AppColor.c142293
                                                      .withOpacity(0.25),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 5),
                                                ),
                                              ]
                                              : [],
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
                      if (rewardController.isSelected.value == 1)
                        Text(rewardDetail.description ?? ''),
                      if (rewardController.isSelected.value == 2)
                        Obx(() {
                          final customers =
                              rewardController
                                  .getRewardedCustomersModel
                                  .value
                                  ?.data ??
                              [];
                          if (customers.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("No rewarded customers found."),
                            );
                          }
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: customers.length,
                            separatorBuilder:
                                (context, index) => Column(
                                  children: [
                                    10.heightSizeBox,
                                    DashedLineWidget(),
                                    10.heightSizeBox,
                                  ],
                                ),
                            itemBuilder: (context, index) {
                              var customer = customers[index];
                              return Row(
                                children: [
                                  ProfileImageView(
                                    radiusStack: 4,
                                    radius: 17,
                                    isVisibleStack: false,
                                    imagePath: customer.profilePicUrl ?? '',
                                  ),
                                  9.widthSizeBox,
                                  Expanded(
                                    child: Text(
                                      customer.customerName ?? '',
                                      style: w600_12a(color: AppColor.c2C2A2A),
                                    ),
                                  ),
                                  20.widthSizeBox,
                                  Text(
                                    formatServerDate(customer.redeemedAt ?? ''),
                                    style: w400_10a(),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
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

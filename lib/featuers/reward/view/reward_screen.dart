import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/components/countdown_else_full_date.dart';
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
import '../../../widgets/components/countdown_or_date_timer.dart';
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
        15.heightSizeBox,
        Obx(
          () => GestureDetector(
            onTap: () {},
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
                          "Total Reward",
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
                      Obx(() {
                        return Padding(
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
                        );
                      }),
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
                          rewardController.isVisibleAllOffer.value =
                              !rewardController.isVisibleAllOffer.value;
                          rewardController.getOfferCategories();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColor.c5C6B72.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Obx(() {
                                final categories =
                                    rewardController
                                        .getOfferCategoriesModel
                                        .value
                                        ?.offerCategory;
                                final selectedIndex =
                                    rewardController
                                        .selectedCategoryIndex
                                        .value;

                                // Compose a list with "All offers" at front + categories
                                final extendedCategories = [
                                  null, // Represents "All offers"
                                  ...?categories,
                                ];

                                final categoryName =
                                    selectedIndex == 0
                                        ? "All offers"
                                        : (selectedIndex > 0 &&
                                            selectedIndex <
                                                extendedCategories.length)
                                        ? extendedCategories[selectedIndex]
                                                ?.name ??
                                            'Unknown'
                                        : "All offers";

                                return Text(
                                  categoryName,
                                  style: w400_12p(color: AppColor.c2C2A2A),
                                );
                              }),
                              Spacer(),
                              ImageView(
                                path: Assets.iconsIcDropDown,
                                height: 5,
                                width: 9,
                                color: AppColor.c2C2A2A,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                19.heightSizeBox,
                Obx(() {
                  final List<Offers> allOffers = rewardController.offerResponseModel.value?.data?.offers ?? [];
                  final categories = rewardController.getOfferCategoriesModel.value?.offerCategory;
                  final selectedCategoryIndex = rewardController.selectedCategoryIndex.value;

                  final extendedCategories = [null, ...?categories];

                  if (selectedCategoryIndex == 0 || selectedCategoryIndex >= extendedCategories.length) {
                    return buildOffersGrid(allOffers);
                  }
                  final selectedCategoryName = extendedCategories[selectedCategoryIndex]?.name;

                  final filteredOffers = (selectedCategoryName == null)
                      ? allOffers
                      : allOffers
                      .where((offer) =>
                  offer.categoryName?.toLowerCase().trim() ==
                      selectedCategoryName.toLowerCase().trim())
                      .toList();
                  if (filteredOffers.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 200,
                        child: Text(
                          '',
                          style: w400_18p(color: AppColor.c2C2A2A),
                        ),
                      ),
                    );
                  }

                  return buildOffersGrid(filteredOffers);
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

                          width: 160,
                          height: 130,
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
            Obx(
              () =>
                  rewardController.isVisibleAllOffer.value
                      ? Positioned(
                        top: 50,
                        left: 0,
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: 160,
                          height: 180,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  rewardController.selectedCategoryIndex.value =
                                      0;
                                  rewardController.isVisibleAllOffer.value =
                                      false;
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "All offers",
                                    style: w400_14p(color: AppColor.c2C2A2A),
                                  ),
                                ),
                              ),
                              ...(rewardController
                                          .getOfferCategoriesModel
                                          .value
                                          ?.offerCategory ??
                                      [])
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => GestureDetector(
                                      onTap: () {
                                        rewardController
                                            .selectedCategoryIndex
                                            .value = entry.key + 1;
                                        rewardController
                                            .isVisibleAllOffer
                                            .value = false;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          entry.value.name ?? '',
                                          style: w400_14p(
                                            color: AppColor.c2C2A2A,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
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

  Widget buildOffersGrid(List<Offers> offers) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 30),
      clipBehavior: Clip.hardEdge,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: offers.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            showLoader();
            await rewardController.getOffersById(offers[index].id!);
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
                return CustomBottomSheet(child: viewOfferDetailBottomSheet());
              },
            ).then((_) {
              rewardController.isSelected.value = 1;
            });
          },
          child: OffersGridContainer(
            key: ValueKey(offers[index].expiryDate),
            offer: offers[index],
          ),
        );
      },
    );
  }

  Widget viewOfferDetailBottomSheet() {
    // rewardController.getRewardedCustomersModel.value=null;
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(() {
          var rewardDetail =
              rewardController.getOffersByIdModel.value?.offerDetailList?.first;
          if (rewardDetail == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightSizeBox,
                Container(
                  height: 187,
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
                          fit: BoxFit.cover,
                          imageUrl:
                              rewardDetail.bannerImageUrl?.isNotEmpty == true
                                  ? rewardDetail.bannerImageUrl!
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
                            DateTimeWidget(title: rewardDetail.businessName),
                         /*   13.heightSizeBox,
                            Text(
                              rewardDetail.title ?? "",
                              style: GoogleFonts.rumRaisin(
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                color: AppColor.white,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // DashedLineWidget(),
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
                      Center(
                        child: CountdownOrDateTimer(
                          expiryDateStr: rewardDetail.expiryDate ?? '',
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
                                    showLoader();
                                    await rewardController
                                        .getRewardedCustomersById(
                                          rewardDetail.id ?? 0,
                                        );
                                    hideLoader();
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
}

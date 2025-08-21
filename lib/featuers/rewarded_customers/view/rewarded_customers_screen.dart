import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/profile_image_view.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../reward/model/get_rewarded_customers_model.dart';
import '../controller/rewarded_customer_controller.dart';

class RewardedCustomersScreen extends StatelessWidget {
  RewardedCustomersScreen({super.key});

  final RewardedCustomerController controller = Get.put(
    RewardedCustomerController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final groupedLogs = groupLogsByDate(controller.allCustomers);
      final groupedKeys = groupedLogs.keys.toList();

      return SingleChildScrollView(
        controller: controller.scrollController,
        child: Stack(
          children: [
            Column(
              children: [
                15.heightSizeBox,
                GestureDetector(
                  onTap: () {
                    controller.isCalenderSelected.value =
                        !controller.isCalenderSelected.value;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDateRange(
                            controller.rangeStartDate.value,
                            controller.rangeEndDate.value,
                          ),
                          style: w500_14p(color: AppColor.c2C2A2A),
                        ),
                        ImageView(
                          path: Assets.iconsIcDropDown,
                          height: 6,
                          width: 8,
                          color: AppColor.c2C2A2A,
                        ),
                      ],
                    ),
                  ),
                ),
                15.heightSizeBox,

                if (groupedKeys.isEmpty && !controller.isLoading.value)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      "No rewarded customers found.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  )
                else
                  ListView.separated(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: groupedKeys.length,
                    separatorBuilder: (_, __) => 15.heightSizeBox,
                    itemBuilder: (context, index) {
                      final dateKey = groupedKeys[index];
                      final logs = groupedLogs[dateKey]!;

                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 14),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.c142293.withOpacity(0.15),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children:
                                  logs
                                      .map(
                                        (log) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: washLogRow(
                                           // ratingText: log.rating.toString(),
                                            log: log,
                                           /* onTap: () {
                                              controller.commentController
                                                  .clear();
                                              controller.userRating = 0;
                                              controller
                                                  .refreshSelectedDateData();
                                              controller
                                                  .selectedDate
                                                  .value = DateTime.parse(
                                                log.redeemedAt!,
                                              );
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return successDialog(log);

                                                },
                                              );
                                            },*/
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColor.c142293.withOpacity(0.10),
                              ),
                            ),
                            child: Text(
                              formatDate(logs[0].redeemedAt ?? ""),
                              style: w500_10p(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                if (controller.isLoading.value)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 2,
                    ),
                  ),
              ],
            ),

            if (controller.isCalenderSelected.value)
              Container(
                margin: const EdgeInsets.only(top: 60),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TableCalendar(
                  focusedDay: controller.focusedDay1,
                  firstDay: DateTime.utc(2025, 3, 4),
                  lastDay: DateTime.utc(2090, 3, 4),
                  selectedDayPredicate:
                      (day) => isSameDay(day, controller.selectedDay1),
                  calendarFormat: controller.calendarFormat,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  weekNumbersVisible: false,
                  rangeStartDay: controller.rangeStartDate.value,
                  rangeEndDay: controller.rangeEndDate.value,
                  rangeSelectionMode: RangeSelectionMode.toggledOn,
                  onRangeSelected: controller.onRangeSelected,
                  calendarStyle: const CalendarStyle(outsideDaysVisible: false),
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.update();
                  },
                  onFormatChanged: (format) {
                    if (controller.calendarFormat != format) {
                      controller.calendarFormat = format;
                      controller.update();
                    }
                  },
                  onPageChanged: (focusedDay) {
                    controller.focusedDay1 = focusedDay;
                  },
                ),
              ),
          ],
        ),
      );
    });
  }

  Map<String, List<GetRewardedCustomersData>> groupLogsByDate(
    List<GetRewardedCustomersData> logs,
  ) {
    Map<String, List<GetRewardedCustomersData>> grouped = {};

    for (var log in logs) {
      if (log.redeemedAt != null) {
        DateTime parsedDate = DateTime.parse(log.redeemedAt!);
        final dateKey = DateFormat('yyyy-MM-dd').format(parsedDate);
        grouped[dateKey] = grouped[dateKey] ?? [];
        grouped[dateKey]!.add(log);
      }
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return {for (var k in sortedKeys) k: grouped[k]!};
  }

  String _formatDateRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) {
      final defaultStart = DateTime.now().subtract(const Duration(days: 10));
      final defaultEnd = DateTime.now();
      return "${_formatDate(defaultStart)} – ${_formatDate(defaultEnd)}";
    }
    return "${_formatDate(start)} – ${_formatDate(end)}";
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} ${_getMonthName(date.month)} ${date.year}";
  }

  String _getMonthName(int month) {
    final months = [
      StringConstant.kJan.tr,
      StringConstant.kFev.tr,
      StringConstant.kMar.tr,
      StringConstant.kApr.tr,
      StringConstant.kMay.tr,
      StringConstant.kJun.tr,
      StringConstant.kJul.tr,
      StringConstant.kAug.tr,
      StringConstant.kSep.tr,
      StringConstant.kAct.tr,
      StringConstant.kNov.tr,
      StringConstant.kDec.tr,
    ];
    return months[month - 1];
  }

  Widget washLogRow({
    required GetRewardedCustomersData log,
    VoidCallback? onTap,
    String? ratingText
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          15.widthSizeBox,
          ProfileImageView(
            radius: 20,
            radiusStack: 4,
            imagePath: log.profilePicUrl,
            isVisibleStack: log.isPremium,
          ),
          11.widthSizeBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    log.customerName ?? "",
                    style: w600_12a(color: AppColor.c2C2A2A),
                  ),

                  3.widthSizeBox,
                  if (ratingText != null && ratingText != "0" && ratingText.isNotEmpty)
                    Text(
                      "(⭐$ratingText)",
                      style: w500_10a(color: AppColor.c455A64),
                    ),

                ],
              ),
              Text(
                log.offerTitle ?? "",
                style: w500_10a(color: AppColor.c455A64),
              ),
            ],
          ),
          Spacer(),
          Text(
            formatDate(log.redeemedAt),
            style: w400_12a(color: AppColor.c2C2A2A),
          ),
          16.widthSizeBox,
        ],
      ),
    );
  }

  Widget successDialog(GetRewardedCustomersData completedWashData) {
    return AppDialog(
      onTap: (){
        controller.commentController.clear();
        controller.userRating = 0;
        controller.fetchInitialCustomers();
        Get.back();
      },

      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Get.height/1.80,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  30.heightSizeBox,
                  Container(
                    color: Colors.transparent,
                    // width: Get.width,
                    child: ImageView(
                      path: Assets.imagesImSussess,
                      width: 100,
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
              
                  21.heightSizeBox,
                  Text(
                    StringConstant.kWashComplete.tr,
                    style: w700_22a(color: AppColor.c2C2A2A),
                  ),
                  Text(
                    StringConstant.kShareYourFeedback.tr,
                    textAlign: TextAlign.center,
                    style: w400_16p(),
                  ),
                  9.heightSizeBox,
                  GetBuilder<RewardedCustomerController>(

                    builder: (controller) {

                      return RatingStars(
                        value: controller.userRating.toDouble(),
                        onValueChanged: (v) {
                          controller.userRating = v.toInt();
                          controller.update();
                        },
                        starBuilder:
                            (index, color) => Icon(Icons.star, color: color, size: 28),
                        starCount: 5,
                        starSize: 28,
                        valueLabelVisibility: false,
                        starColor: AppColor.cFFC200,
                        starOffColor: Colors.grey,
                        animationDuration: Duration(milliseconds: 200),
                        starSpacing: 2,
                      );
                    },

                  ),
                  15.heightSizeBox,
              
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: controller.commentController,
                      maxLines: 3,
                      style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
                      decoration: InputDecoration(
                          fillColor: AppColor.white,
                          hintText: StringConstant.kEnterYourCommentHere.tr,
                          filled: true,
                          hintStyle: w400_14p(
                            color: AppColor.c2C2A2A.withOpacity(0.40),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.c5C6B72.withOpacity(0.10),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.blue,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                  ),
                  15.heightSizeBox,
              
                  GestureDetector(
                    onTap: () {
                      final comment = controller.commentController.text.trim();
                      final ratingString = controller.userRating.toString();
              
                      controller
                          .getRating(
                        ratingString,
                        completedWashData.customerId.toString(),
                        comment,
                      )
                          .then((value) {
                        if (value != null) {
                          controller.commentController.clear();
                          controller.userRating = 0;
                          controller.fetchInitialCustomers();
                          Get.back();
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColor.c142293,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.c142293.withOpacity(0.30),
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Text(
                        StringConstant.kSubmit.tr,
                        style: w500_14a(color: AppColor.white),
                      ),
                    ),
                  ),
                  35.heightSizeBox,
                ],
              ),
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
                DotedHorizontalLine(),
                Padding(
                  padding: EdgeInsets.only(top: 23, left: 16, bottom: 20),
                  child: Row(
                    children: [
                      ProfileImageView(
                        imagePath: completedWashData.profilePicUrl,
                        radius: 20,
                        radiusStack: 4,
                        isVisibleStack: false,
                      ),
                      9.widthSizeBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            completedWashData.customerName?? "",
                            style: w600_14a(color: AppColor.c2C2A2A),
                          ),
                          5.widthSizeBox,
                          Row(
                            children: [
                              /*    ImageView(
                                path: Assets.iconsIcPlaceMarker,
                                height: 18,
                                width: 18,
                              ),*/
                              Text(
                                completedWashData.offerTitle??"",
                                style: w400_12a(color: AppColor.c455A64),
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
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/image_view.dart';
import '../../reward/model/get_rewarded_customers_model.dart';
import '../controller/rewarded_customer_controller.dart';
class RewardedCustomersScreen extends StatelessWidget {
  RewardedCustomersScreen({super.key});

  final RewardedCustomerController controller =
  Get.put(RewardedCustomerController());

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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDateRange(controller.rangeStartDate.value,
                              controller.rangeEndDate.value),
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
                              children: logs
                                  .map((log) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8),
                                child: washLogRow(log: log),
                              ))
                                  .toList(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
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
                    child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),
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
                  selectedDayPredicate: (day) =>
                      isSameDay(day, controller.selectedDay1),
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
      List<GetRewardedCustomersData> logs) {
    Map<String, List<GetRewardedCustomersData>> grouped = {};

    for (var log in logs) {
      if (log.redeemedAt != null) {
        DateTime parsedDate = DateTime.parse(log.redeemedAt!);
        final dateKey = DateFormat('yyyy-MM-dd').format(parsedDate);
        grouped[dateKey] = grouped[dateKey] ?? [];
        grouped[dateKey]!.add(log);
      }
    }

    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    return {for (var k in sortedKeys) k: grouped[k]!};
  }

  String _formatDateRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) {
      final defaultStart = DateTime.now().subtract(const Duration(days: 10));
      final defaultEnd = DateTime.now();
      return _formatDate(defaultStart) + " – " + _formatDate(defaultEnd);
    }
    return _formatDate(start) + " – " + _formatDate(end);
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

  Widget washLogRow({required GetRewardedCustomersData log}) {
    return Row(
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
        Expanded(
          child: Text(
            log.customerName ?? "",
            style: w600_12a(color: AppColor.c2C2A2A),
          ),
        ),
        Text(
          formatDate(log.redeemedAt),
          style: w400_12a(color: AppColor.c2C2A2A),
        ),
        20.widthSizeBox,
        const Text(""),
      ],
    );
  }
}

/*

class RewardedCustomersScreen extends StatelessWidget {
  RewardedCustomersScreen({super.key});

  final RewardedCustomerController controller = Get.put(RewardedCustomerController());

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
                    controller.isCalenderSelected.value = !controller.isCalenderSelected.value;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                ListView.separated(
                  padding: EdgeInsets.only(top: 20, bottom: 30),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: groupedKeys.length,
                  separatorBuilder: (_, __) => 15.heightSizeBox,
                  itemBuilder: (context, index) {
                    print("groupedKeys-----> : ${groupedLogs.length}");
                    final dateKey = groupedKeys[index];
                    final logs = groupedLogs[dateKey]!;

                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 14),
                          padding: EdgeInsets.symmetric(vertical: 15),
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
                            children: logs
                                .map((log) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: washLogRow(log: log),
                            ))
                                .toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
            if (controller.isCalenderSelected.value)
              Container(
                margin: EdgeInsets.only(top: 60),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TableCalendar(
                  focusedDay: controller.focusedDay1,
                  firstDay: DateTime.utc(2025, 3, 4),
                  lastDay: DateTime.utc(2090, 3, 4),
                  selectedDayPredicate: (day) => isSameDay(day, controller.selectedDay1),
                  calendarFormat: controller.calendarFormat,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  weekNumbersVisible: false,
                  rangeStartDay: controller.rangeStartDate.value,
                  rangeEndDay: controller.rangeEndDate.value,
                  rangeSelectionMode: RangeSelectionMode.toggledOn,
                  onRangeSelected: controller.onRangeSelected,
                  calendarStyle: CalendarStyle(outsideDaysVisible: false),
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

  Map<String, List<GetRewardedCustomersData>> groupLogsByDate(List<GetRewardedCustomersData> logs) {
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
      final defaultStart = DateTime.now().subtract(Duration(days: 10));
      final defaultEnd = DateTime.now();
      return _formatDate(defaultStart) + " – " + _formatDate(defaultEnd);
    }
    return _formatDate(start) + " – " + _formatDate(end);
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

  Widget washLogRow({required GetRewardedCustomersData log}) {
    return Row(
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
        Expanded(
          child: Text(
            log.customerName ?? "",
            style: w600_12a(color: AppColor.c2C2A2A),
          ),
        ),
        Text(
          formatDate(log.redeemedAt),
          style: w400_12a(color: AppColor.c2C2A2A),
        ),
        20.widthSizeBox,
        Text(""),
      ],
    );
  }
}
*/

///--------------
/*class RewardedCustomersScreen extends StatelessWidget {
  RewardedCustomersScreen({super.key});

  final RewardedCustomerController rewardedCustomerController =
  Get.put(RewardedCustomerController());

  void _showTableCalendar(BuildContext context) {
    DateTime? tempSelected = rewardedCustomerController.selectedDate.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 500,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            // Clear Filter logic
                            rewardedCustomerController.clearDateFilter();
                            Navigator.of(context).pop();
                          },
                          child: Text("Clear Date"),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: TableCalendar(
                        firstDay: DateTime(2000),
                        lastDay: DateTime.now(),
                        focusedDay: tempSelected ?? DateTime.now(),
                        selectedDayPredicate: (day) => tempSelected != null && isSameDay(day, tempSelected),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            tempSelected = selectedDay;
                          });
                          rewardedCustomerController.setSelectedDate(selectedDay);
                          Navigator.of(context).pop();
                        },
                        calendarFormat: CalendarFormat.month,
                        headerStyle: HeaderStyle(formatButtonVisible: false),
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(() => GestureDetector(
                  onTap: () => _showTableCalendar(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(color: AppColor.c142293.withOpacity(0.15)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.c142293.withOpacity(0.15),
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      rewardedCustomerController.formatDateForTextField(
                        rewardedCustomerController.selectedDate.value,
                      ),
                      style: w600_12a(color: AppColor.c2C2A2A),
                    ),
                  ),
                )),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => rewardedCustomerController.refreshSelectedDateData(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(color: AppColor.c142293.withOpacity(0.15)),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c142293.withOpacity(0.15),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Expanded(
            child: Obx(() {
              final allCustomers = rewardedCustomerController.allCustomers;
              final selected = rewardedCustomerController.selectedDate.value;
              final isFilter = rewardedCustomerController.isDateFilterEnabled.value;
              final isLoading = rewardedCustomerController.isLoading.value;

              List<GetRewardedCustomersData> shownList;

              if (isFilter && selected != null) {
                final selectedDateStr = selected.toIso8601String().split("T")[0];
                shownList = allCustomers.where((customer) {
                  if (customer.redeemedAt == null) return false;
                  final dateOnly = customer.redeemedAt?.split("T")[0];
                  return dateOnly == selectedDateStr;
                }).toList();
              } else {
                shownList = allCustomers;
              }

              if (isLoading && shownList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (shownList.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("No rewards available"),
                  ),
                );
              }
              return ListView.separated(
                controller: rewardedCustomerController.scrollController,
                padding: const EdgeInsets.only(bottom: 70),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: shownList.length,
                separatorBuilder: (context, index) => Column(
                  children: const [
                    SizedBox(height: 10),
                    DashedLineWidget(),
                    SizedBox(height: 10),
                  ],
                ),
                itemBuilder: (context, index) {
                  final customer = shownList[index];
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return successDialog(
                              customerImage: customer.profilePicUrl??"",
                              customerName: customer.customerName??"",
                              customerOffer: customer.offerTitle??"",
                              redeemedAt: ''
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          ProfileImageView(
                            radiusStack: 4,
                            radius: 17,
                            imagePath: customer.profilePicUrl ?? '',
                            isVisibleStack: customer.isPremium == 1,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      customer.customerName ?? '',
                                      style: w600_12a(color: AppColor.c2C2A2A),
                                    ),
                                    3.widthSizeBox,
                                    Text("(",style: w400_12a(color: AppColor.c455A64.withOpacity(0.7))),
                                    ImageView(
                                      path: Assets.iconsIcStar,
                                      height: 10,
                                      width: 10,
                                    ),
                                    2.widthSizeBox,
                                    Text(
                                      "4",
                                      style: w400_10a(color: AppColor.c455A64),
                                    ),
                                    Text(")",style: w400_12a(color: AppColor.c455A64.withOpacity(0.7))),

                                  ],
                                ),
                                Text(
                                  customer.offerTitle ?? '',
                                  style: w400_10a(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              Text(
                                _formatDateWithTime(customer.redeemedAt.toString()),
                                style: w400_10a(),
                              ),
                              5.widthSizeBox,


                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
  String _formatDateWithTime(String rawDateTime) {
    try {
      final DateTime dt = DateTime.parse(rawDateTime).toLocal();
      return "${dt.day}/${dt.month}/${dt.year}";
    } catch (e) {
      return rawDateTime;
    }
  }
*/ /*  String _formatDateWithTime(String rawDateTime) {
    try {
      final DateTime dt = DateTime.parse(rawDateTime).toLocal();
      return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return rawDateTime;
    }
  }*/ /*
  Widget successDialog({
    required String customerImage,
    required String customerName,
    required String customerOffer,
    required String redeemedAt,
    void Function(int rating, String comment)? onSubmit,
  }) {
    final TextEditingController commentController = TextEditingController();
    int userRating = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        child: Image.asset(
                          Assets.imagesImSussess,
                          width: 100,
                          height: 100,

                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 21),
                      Text(
                        "Wash Completed",
                        style: w700_22a(color: AppColor.c2C2A2A),
                      ),
                      Text(
                        "Share your feedback",
                        textAlign: TextAlign.center,
                        style: w400_16p(),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < userRating ? Icons.star : Icons.star_border,
                              color: AppColor.cFFC200,
                              size: 28,
                            ),
                            onPressed: () {
                              setState(() {
                                userRating = index + 1;
                              });
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: commentController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter your comment here",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.c5C6B72.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          final comment = commentController.text.trim();
                          if (onSubmit != null) {
                            onSubmit(userRating, comment);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColor.c142293,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.c142293.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Text(
                            "Submit",
                            style: w500_14a(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.cF6F7FF,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      DotedHorizontalLine(),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 23, left: 19, bottom: 40),
                        child: Row(
                          children: [
                            ProfileImageView(
                              imagePath: customerImage,
                              radius: 20,
                              radiusStack: 4,
                              isVisibleStack: false,
                            ),
                            const SizedBox(width: 9),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customerName,
                                  style: w600_14a(color: AppColor.c2C2A2A),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  customerOffer,
                                  style: w400_12a(color: AppColor.c2C2A2A),
                                ),
                             */ /*   Row(
                                  children: [
                                    Image.asset(
                                      Assets.iconsIcPlaceMarker,
                                      height: 18,
                                      width: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      redeemedAt,
                                      style: w400_12a(color: AppColor.c455A64),
                                    ),
                                  ],
                                ),*/ /*
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
          ),
        );
      },
    );
  }


}*/

///---------------
/*class RewardedCustomersScreen extends StatelessWidget {
  RewardedCustomersScreen({super.key});

  final RewardedCustomerController rewardedCustomerController =
  Get.put(RewardedCustomerController());

  void _showTableCalendar(BuildContext context) {
    DateTime tempSelected = rewardedCustomerController.selectedDate.value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 500,
            child: Column(
              children: [
                Text(
                  'Select Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime.now(),
                    focusedDay: tempSelected,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, tempSelected),
                    onDaySelected: (selectedDay, focusedDay) {
                      tempSelected = selectedDay;
                    },
                    calendarFormat: CalendarFormat.month,
                    headerStyle: HeaderStyle(formatButtonVisible: false),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    rewardedCustomerController.setSelectedDate(tempSelected);
                    Get.back();
                  },
                  child: Text('Done'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80, top: 15),
      child: Column(
        children: [
          // Date Picker and Refresh
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showTableCalendar(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(color: AppColor.c142293.withOpacity(0.15)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.c142293.withOpacity(0.15),
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Obx(() => Text(
                      rewardedCustomerController.formatDateForTextField(
                        rewardedCustomerController.selectedDate.value,
                      ),
                      style: w600_12a(color: AppColor.c2C2A2A),
                    )),
                  ),
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () => rewardedCustomerController.refreshSelectedDateData(),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(color: AppColor.c142293.withOpacity(0.15)),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c142293.withOpacity(0.15),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // List of Customers
          Container(
            height: Get.height / 1.60,
            padding: const EdgeInsets.only(top: 14, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.c142293.withOpacity(0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Obx(() {
              final customers = rewardedCustomerController.allCustomers;

              return customers.isNotEmpty
                  ? ListView.separated(
                controller: rewardedCustomerController.scrollController,
                padding: EdgeInsets.only(bottom: 70),
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: customers.length +
                    (rewardedCustomerController.hasMore.value ? 1 : 0),
                separatorBuilder: (context, index) => Column(
                  children: [
                    SizedBox(height: 10),
                    DashedLineWidget(),
                    SizedBox(height: 10),
                  ],
                ),
                itemBuilder: (context, index) {
                  if (index < customers.length) {
                    var customer = customers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          ProfileImageView(
                            radiusStack: 4,
                            radius: 17,
                            imagePath: customer.profilePicUrl ?? '',
                            isVisibleStack: customer.isPremium == 1,
                          ),
                          SizedBox(width: 9),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer.customerName ?? '',
                                  style: w600_12a(color: AppColor.c2C2A2A),
                                ),
                                Text(
                                  customer.offerTitle ?? '',
                                  style: w400_10a(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            _formatDateWithTime(customer.redeemedAt.toString()),
                            style: w400_10a(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return rewardedCustomerController.isLoading.value
                        ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blue,
                        ),
                      ),
                    )
                        : SizedBox();
                  }
                },
              )
                  : Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "No rewards available",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _formatDateWithTime(String rawDateTime) {
    try {
      final DateTime dt = DateTime.parse(rawDateTime).toLocal();
      return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return rawDateTime;
    }
  }
}*/

///---------

/*
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/data_formet.dart';
import 'package:hiwash_partner/widgets/components/dashed_line_widget.dart';
import 'package:hiwash_partner/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_partner/widgets/components/profile_image_view.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../controller/rewarded_customer_controller.dart';

class RewardedCustomersScreen extends StatefulWidget {
  RewardedCustomersScreen({super.key});

  @override
  State<RewardedCustomersScreen> createState() =>
      _RewardedCustomersScreenState();
}

class _RewardedCustomersScreenState extends State<RewardedCustomersScreen> {
  final RewardedCustomerController rewardedCustomerController = Get.put(
    RewardedCustomerController(),
  );

  @override
  void initState() {
    super.initState();
    rewardedCustomerController.scrollController.addListener(
      rewardedCustomerController.onScroll,
    );
    rewardedCustomerController.fetchInitialCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80, top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: HiWashTextField(

                controller: rewardedCustomerController.searchController,
                hintText: "Choose date",fillColor: AppColor.white,),),
              5.widthSizeBox,
              Container(
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                   border: Border.all(color: AppColor.c142293.withOpacity(0.15)),
                   shape:BoxShape.circle,
                   // borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c142293.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 0),)
                    ]
                  ),
                  child: Icon(Icons.refresh)),
            ],
          ),
          10.heightSizeBox,
          Container(
            height: Get.height / 1.60,
            padding: const EdgeInsets.only(top: 14, bottom: 20),
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
              final customers = rewardedCustomerController.allCustomers;

              return customers.isNotEmpty
                  ? ListView.separated(
                    // shrinkWrap: true,
                    controller: rewardedCustomerController.scrollController,
                    padding: EdgeInsets.only(bottom: 70),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount:
                        customers.length +
                        (rewardedCustomerController.hasMore.value ? 1 : 0),
                    separatorBuilder:
                        (context, index) => Column(
                          children: [
                            10.heightSizeBox,
                            DashedLineWidget(),
                            10.heightSizeBox,
                          ],
                        ),
                    itemBuilder: (context, index) {
                      if (index < customers.length) {
                        var customer = customers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              ProfileImageView(
                                radiusStack: 4,
                                radius: 17,
                                imagePath: customer.profilePicUrl ?? '',
                                isVisibleStack: customer.isPremium == 1,
                              ),
                              9.widthSizeBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customer.customerName ?? '',
                                      style: w600_12a(color: AppColor.c2C2A2A),
                                    ),
                                    Text(
                                      customer.offerTitle ?? '',
                                      style: w400_10a(),
                                    ),
                                  ],
                                ),
                              ),
                              20.widthSizeBox,
                              Text(
                                formatServerDate(
                                  customer.redeemedAt.toString(),
                                ),
                                style: w400_10a(),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return rewardedCustomerController.isLoading.value
                            ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                            : SizedBox(); // No loader when finished
                      }
                    },
                  )
                  : Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        StringConstant.kNoAewardsAvailable.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
            }),
          ),
        ],
      ),
    );
  }
}
*/

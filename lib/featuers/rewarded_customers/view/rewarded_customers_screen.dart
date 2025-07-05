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
  final RewardedCustomerController rewardedCustomerController = Get.put(RewardedCustomerController());

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
      child: Container(
        padding: const EdgeInsets.only(top: 14,bottom: 60),
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Obx(() {

            final customers = rewardedCustomerController.allCustomers;
         /*   if (rewardedCustomerController.isLoading.value) {
              return  Center(child: CircularProgressIndicator());
            }*/
            return customers.isNotEmpty
                ? ListView.separated(

              controller: rewardedCustomerController.scrollController,
              padding: EdgeInsets.only(bottom: 70),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: customers.length +
                  (rewardedCustomerController.hasMore.value ? 1 : 0),
              separatorBuilder: (context, index) => Column(
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
                          formatServerDate(customer.redeemedAt.toString()),
                          style: w400_10a(),
                        ),
                      ],
                    ),
                  );
                } else {
                  return rewardedCustomerController.isLoading.value
                      ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: CircularProgressIndicator(   strokeWidth: 2,       color: Colors.blue,)),
                  )
                      : SizedBox(); // No loader when finished
                }
              },
            )
                : Center(
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Text(StringConstant.kNoAewardsAvailable.tr,style: TextStyle(color: Colors.white),),
              ),
            );
          }),
        ),
      ),
    );
  }
}

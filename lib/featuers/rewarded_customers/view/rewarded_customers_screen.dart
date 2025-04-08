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
    return Scaffold(
      body: AppHomeBg(
        iconLeft: SizedBox(),

        padding: EdgeInsets.zero,
        headingText: "Rewarded Customers",
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
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
        ),
      ),

      /*Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.c142293,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Text(
                      "Rewarded Customers",
                      style: w700_16a(color: AppColor.white),
                    ),
                    ImageView(
                      height: 23,
                      width: 23,
                      path: Assets.iconsIcMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
          //20.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.white,
                    boxShadow: [ BoxShadow(

                      color: AppColor.c142293.withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    )]
                  ),
                  child:  ListView.separated(
                    padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      return   Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            ProfileImageView(radiusStack: 4,


                              radius: 17,
                            ),
                            9.widthSizeBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ibrahim Bafqia",
                                    style: w600_12a(color: AppColor.c2C2A2A),
                                  ),
                                  Text("Flat 30% off",style: w400_10a(),)
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
                    }, itemCount: 20,),
                )
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../../../widgets/components/image_view.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: ImageView(
                        path: Assets.iconsIcArrow,

                        height: 15,
                        width: 15,
                      ),
                    ),
                    Text(
                      "My Account ",
                      style: w700_16a(color: AppColor.white),
                    ),
                    Text(""),
                  ],
                ),
              ),
            ],
          ),
          15.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(Assets.imagesDemoProfile),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColor.cC41949,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColor.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.cC41949.withOpacity(0.25),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),

                          child: ImageView(
                            path: Assets.iconsIcEdit,
                            height: 17,
                            width: 17,
                          ),
                        ),
                      ],
                    ),
                    11.heightSizeBox,
                    Text("Caltex Engine Oil",style: w700_16a(color: AppColor.c2C2A2A,)),
                    4.heightSizeBox,

                    31.heightSizeBox,
                    HiWashTextField(hintText: "Name", labelText: "Name"),
                    20.heightSizeBox,
                    HiWashTextField(hintText: "Email", labelText: "Email"),
                    20.heightSizeBox,
                    HiWashTextField(hintText: "Phone", labelText: "Phone"),
                    20.heightSizeBox,
                    Column(
                      children: [
                        Stack(
                          children: [
                            TextFormField(
                              maxLines: 3,
                              style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
                              decoration: InputDecoration(
                                fillColor: AppColor.cF6F7FF,
                                hintText: "Address",
                                labelText: "Address",
                                filled: true,
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelStyle: w400_13a(color: AppColor.c455A64),
                                hintStyle: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.40)),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.cEAE8E8.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.c5C6B72.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.c5C6B72.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.c5C6B72.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.c5C6B72.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.c5C6B72.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 9,
                              right: 8,
                              child:ImageView(

                                path: Assets.iconsMyLocation,
                                height: 18,
                                width: 18,

                              )
                            ),
                          ],
                        ),
                      ],
                    ),

                    20.heightSizeBox
,
                    20.heightSizeBox,
                    HiWashTextField(hintText: "Car Number", labelText: "Car Number"),

                    20.heightSizeBox,
                    HiWashButton(text: 'Save',),
                    60.heightSizeBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

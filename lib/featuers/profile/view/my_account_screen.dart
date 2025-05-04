import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_home_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../../../widgets/components/image_view.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controller/drawer_profile_controller.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({super.key});

  DashboardController dashboardController = Get.find();
  DrawerProfileController drawerProfileController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userData = dashboardController.getPartnerModel.value?.data?.first;

    drawerProfileController.businessNameController.text = userData?.businessName ?? '';
    drawerProfileController.emailController.text = userData?.email ?? '';
    drawerProfileController.addressController.text = userData?.address ?? '';

    return AppHomeBg(
      headingText: "My Account",
      iconRight: SizedBox(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              15.heightSizeBox,
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                    ),
                    child: Obx(() {
                      if (drawerProfileController.imageFile.value != null) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(
                            drawerProfileController.imageFile.value!,
                          ),
                        );
                      } else if ((userData?.profilePicUrl ?? '').isNotEmpty) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            userData!.profilePicUrl!,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(Assets.imagesDemoProfile),
                        );
                      }
                    }),
                    /* child: Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            drawerProfileController.imageFile.value != null
                                ? FileImage(
                                  drawerProfileController.imageFile.value!,
                                )
                                : AssetImage(Assets.imagesDemoProfile),
                      ),
                    ),*/
                  ),
                  GestureDetector(
                    onTap: () async {
                      await drawerProfileController.imagePicker();

                      await drawerProfileController.uploadProfileImage().then((
                          value,
                          ) {
                        dashboardController.getPartnerDataById(
                          dashboardController
                              .getPartnerModel
                              .value
                              ?.data
                              ?.first
                              .id ??
                              0,
                        );
                      });
                    },
                    child: Container(
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
                  ),
                ],
              ),
              11.heightSizeBox,
              Obx(() {
                // Use Obx to make the Text widget reactive
                final updatedUserData = dashboardController.getPartnerModel.value?.data?.first;
                return Text(
                  updatedUserData?.businessName ?? '',
                  style: w700_16a(color: AppColor.c2C2A2A),
                );
              }),


              31.heightSizeBox,
              HiWashTextField(
                controller: drawerProfileController.businessNameController,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                hintText: "Name",
                labelText: "Name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              20.heightSizeBox,
              HiWashTextField(
                controller: drawerProfileController.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                labelText: "Email",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),

              20.heightSizeBox,

              Column(
                children: [
                  Stack(
                    children: [
                      TextFormField(
                        maxLines: 3,
                        controller: drawerProfileController.addressController,
                        style: w400_14p(
                          color: AppColor.c2C2A2A.withOpacity(0.9),
                        ),
                        decoration: InputDecoration(
                          fillColor: AppColor.cF6F7FF,
                          hintText: "Address",
                          labelText: "Address",
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: w400_13a(color: AppColor.c455A64),
                          hintStyle: w400_14p(
                            color: AppColor.c2C2A2A.withOpacity(0.40),
                          ),
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
                        child: ImageView(
                          path: Assets.iconsMyLocation,
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              60.heightSizeBox,
              Obx(() {
                return HiWashButton(
                  isLoading: drawerProfileController.isLoading.value,
                  text: 'Save',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      drawerProfileController.uploadProfile(
                        drawerProfileController.businessNameController.text,
                        drawerProfileController.emailController.text,
                        drawerProfileController.addressController.text,
                      );

                    await  dashboardController.getPartnerDataById(
                        dashboardController
                            .getPartnerModel
                            .value
                            ?.data
                            ?.first
                            .id ??
                            0,

                      );
                    } else {
                      Get.snackbar(
                        'Invalid Input',
                        'Please fix the errors in the form',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                );
              }),

              30.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}

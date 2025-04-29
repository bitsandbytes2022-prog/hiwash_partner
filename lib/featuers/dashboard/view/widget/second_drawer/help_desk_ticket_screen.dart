import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';


import '../../../../../generated/assets.dart';
import '../../../../../styling/app_color.dart';
import '../../../../../styling/app_font_anybody.dart';
import '../../../../../widgets/components/app_home_bg.dart';
import '../../../../../widgets/components/hi_wash_button.dart';
import '../../../../../widgets/components/hi_wash_text_field.dart';
import '../../../../../widgets/components/image_view.dart';
import 'second_drawer_controller/second_drawer_controller.dart';

class HelpDeskTicketScreen extends StatelessWidget {
  HelpDeskTicketScreen({super.key});

  SecondDrawerController secondDrawerController = Get.put(
    SecondDrawerController(),
  );

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(

      headingText: "Help Desk Ticket",

      iconRight: SizedBox(),
      child: Container(
        padding: EdgeInsets.all(15),

        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.c142293.withOpacity(0.15),
              blurRadius: 15,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.heightSizeBox,
            HiWashTextField(
              hintText: "",
              labelText: "Issue",
              fillColor: AppColor.white,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(18),
                child: ImageView(
                  path: Assets.iconsIcDropDown,
                  height: 10,
                  width: 8,
                ),
              ),
            ),
            20.heightSizeBox,
            HiWashTextField(
              hintText: "Enter short summary of your issue",
              labelText: "Subject",
              fillColor: AppColor.white,
            ),
            20.heightSizeBox,
            HiWashTextField(
              hintText: "Please describe the issue in detail.",
              labelText: "Description",
              fillColor: AppColor.white,
            ),
            20.heightSizeBox,
          /// Todo
          /*  ImageView(
              path: Assets.imagesCameraImage,
              height: 144,
              width: Get.width,
             // fit: BoxFit.fitWidth,
            ),*/
            20.heightSizeBox,
            Text(
              "Preferred Contact Method",
              style: w500_12a(color: AppColor.c2C2A2A),
            ),
            20.heightSizeBox,
            Row(
              children: [
                checkboxWidget(0, "Email"),
                10.widthSizeBox,
                checkboxWidget(1, "Phone"),
                10.widthSizeBox,
                checkboxWidget(2, "In-app notification"),
              ],
            ),

            30.heightSizeBox,
            HiWashButton(text: "Submit Ticket"),
            20.heightSizeBox,
          ],
        ),
      ),
    );
  }

  Widget checkboxWidget(int index, String label) {
    return Obx(() {
      return CustomCheckbox(
        value: secondDrawerController.isChecked[index],
        onChanged: (bool? value) {
          secondDrawerController.toggleCheckbox(index);
        },
        label: label,
      );
    });
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(

            width: 18,
            height: 18,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
              color: value ? AppColor.c1F9D70: Colors.white,
            ),
            child:
                value ? Icon(Icons.check, color: Colors.white, size: 16) : null,
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: w400_11a(color: AppColor.c2C2A2A),

        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_home_bg.dart';
import '../../../widgets/components/doted_horizontal_line.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      headingText: "Language",
      iconRight:SizedBox(),
      child: Column(
        children: [
          15.heightSizeBox,
          countryRow(title: '🇸🇦 Arabic'),
          countryRow(title: '🇬🇧 English'),


        ],
      )
    );
  }

  countryRow({required String title}){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
          children: [

            Text(title,style: w500_18p(color: AppColor.c6B6B6B),)
          ],
          ),
        ),
        20.heightSizeBox,
        DotedHorizontalLine(),
        20.heightSizeBox,

      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/network_manager/local_storage.dart';
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
      headingText: StringConstant.kLanguage.tr,
      iconRight: SizedBox(),
      child: Column(
        children: [
          15.heightSizeBox,
          countryRow(
            title: '🇸🇦 ${"العربية"}',
            languageCode: 'ar',
            countryCode: 'SA',
          ),
          countryRow(
            title: '🇬🇧 English',
            languageCode: 'en',
            countryCode: 'US',
          ),
        ],
      ),
    );
  }

  Widget countryRow({
    required String title,
    required String languageCode,
    required String countryCode,
  }) {
    return GestureDetector(
      onTap: () async {
        Locale selectedLocale = Locale(languageCode, countryCode);
        await LocalStorage().saveLocale(languageCode);
        Get.updateLocale(selectedLocale);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [Text(title, style: w500_18p(color: AppColor.c6B6B6B))],
            ),
          ),
          20.heightSizeBox,
          DotedHorizontalLine(),
          20.heightSizeBox,
        ],
      ),
    );
  }
}

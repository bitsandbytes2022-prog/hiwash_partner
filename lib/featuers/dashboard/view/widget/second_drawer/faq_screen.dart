import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import '../../../../../generated/assets.dart';
import '../../../../../styling/app_color.dart';
import '../../../../../styling/app_font_anybody.dart';
import '../../../../../styling/app_font_poppins.dart';
import '../../../../../widgets/components/app_home_bg.dart';
import '../../../../../widgets/components/image_view.dart';
import 'second_drawer_controller/second_drawer_controller.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  final SecondDrawerController secondDrawerController = Get.put(
    SecondDrawerController(),
  );
  final RxInt selectedFaqIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    secondDrawerController.getFaq();

    return AppHomeBg(
      headingText: StringConstant.kFAQ.tr,
      iconRight: SizedBox(),
      child: Column(
        children: [
          15.heightSizeBox,

          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              onChanged: (value) {
                secondDrawerController.searchQuery.value = value.toLowerCase();
              },
              style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ImageView(
                    path: Assets.iconsIcSearch,
                    height: 20,
                    width: 20,
                  ),
                ),
                hintText: StringConstant.kSearch.tr,
                filled: true,
                fillColor: AppColor.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,

                hintStyle: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.40)),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          20.heightSizeBox,

          Obx(() {
            if (secondDrawerController.isLoading.value) {
              return const Center(child: CircularProgressIndicator(          color: Colors.blue,
                strokeWidth: 2,
              ));
            }

            final allFaqs =
                secondDrawerController.faqResponse.value?.data ?? [];

            // 🔍 Filter logic
            final filteredFaqs =
                allFaqs.where((faqItem) {
                  final query = secondDrawerController.searchQuery.value;
                  final question = faqItem.question?.toLowerCase() ?? '';
                  final answer = faqItem.answer?.toLowerCase() ?? '';
                  return question.contains(query) || answer.contains(query);
                }).toList();

            if (filteredFaqs.isEmpty) {
              return Center(child: Text(StringConstant.kNoFAQsFound.tr));
            }

            return Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.c142293.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredFaqs.length,
                separatorBuilder:
                    (context, index) => Column(
                      children: [
                        10.heightSizeBox,
                        Divider(color: AppColor.c142293.withOpacity(0.15)),
                        10.heightSizeBox,
                      ],
                    ),
                itemBuilder: (context, index) {
                  final faqItem = filteredFaqs[index];

                  return Obx(() {
                    final isSelected = selectedFaqIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        selectedFaqIndex.value = isSelected ? -1 : index;
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question Row
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    faqItem.question ?? '',
                                    style: w600_12a(color: AppColor.c2C2A2A),
                                  ),
                                ),
                                ImageView(
                                  path:
                                      isSelected
                                          ? Assets.iconsIcUpWardArrow
                                          : Assets.iconsIcDropDown,
                                  height: 10,
                                  width: 12,
                                ),
                              ],
                            ),
                          ),

                          // Answer if selected
                          if (isSelected) ...[
                            8.heightSizeBox,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                faqItem.answer ?? '',
                                style: w400_12p(),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

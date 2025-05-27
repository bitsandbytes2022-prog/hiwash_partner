import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../featuers/reward/controller/reward_controller.dart';
import '../../featuers/reward/model/offer_response_model.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import 'countdown_else_full_date.dart';

class OffersGridContainer extends StatelessWidget {
  final Offers offer;


  OffersGridContainer({super.key, required this.offer});

  final RewardController rewardController = Get.find();

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        (offer.image != null && offer.image!.isNotEmpty) ? offer.image! : '';

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.c5C6B72.withOpacity(0.4)),
        image: DecorationImage(
          image:
              imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : AssetImage(Assets.imagesImOffer) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: CountdownElseFullDate(expiryDateStr: offer.expiryDate ?? ''),
          ),
       /*   Spacer(),
          Text(
            "${offer.discountValue ?? 0}% Off",
            style: w900_14a(color: AppColor.c2C2A2A),
          ),*/
        ],
      ),
    );
  }
}

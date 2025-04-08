import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import 'date_time_widget.dart';

class OffersGridContainer extends StatelessWidget {
  const OffersGridContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.c5C6B72.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: DateTimeWidget(title: "0:3 HRS - 34 MINS",)
          ),

          Image.asset(
            Assets.imagesDemo2,
            height: 87,
            fit: BoxFit.cover,
          ),
          Text(
            "Flat 30% off",
            style: w900_14a(color: AppColor.c2C2A2A),
          ),
        ],
      ),
    );
  }
}

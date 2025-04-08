import 'package:flutter/material.dart';
import '../../../../styling/app_color.dart';
import '../../../../styling/app_font_anybody.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.c000000.withOpacity(0.3),
                    AppColor.c666666.withOpacity(0.0),
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.c000000.withOpacity(.1),

                    offset: Offset(-2, 0),
                    blurRadius: 1.0,
                  ),
                  BoxShadow(
                    color: AppColor.c000000.withOpacity(.0),
                    offset: Offset(2, 0),
                    blurRadius: 0.1,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(
              "OR",
              style: w400_14a(color: AppColor.c455A64),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.c000000.withOpacity(0.3),
                    AppColor.c666666.withOpacity(0.0),
                    //AppColor.white
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.c000000.withOpacity(.1),

                    offset: Offset(-2, 0),
                    blurRadius: 1.0, // Blur radius
                  ),
                  BoxShadow(
                    color: AppColor.c000000.withOpacity(.0),
                    offset: Offset(2, 0),
                    blurRadius: 0.1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

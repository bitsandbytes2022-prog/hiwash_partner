import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import 'image_view.dart';

class ProfileImageView extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final String? imagePath;
  final String? image;
  final double? heightStack;
  final double? widthStack;
  final double? radiusStack;
  final bool? isVisibleStack;
  final bool? isTopRight;

  const ProfileImageView({super.key,
    this.height=40,
    this.width=40,
    this.radius=20,
    this.imagePath,
    this.image,
    this.heightStack=15,
    this.widthStack=15,
    this.radiusStack=10,
    this.isVisibleStack=true,
    this.isTopRight
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: isTopRight==true?Alignment.topRight:Alignment.topLeft,
      children: [
        Container(

          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColor.blue.withOpacity(0.2)),
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage(imagePath??Assets.imagesDemoProfile),
          ),
        ),
    if(isVisibleStack==true)    Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColor.cE8E9F4),
          ),

          child:CircleAvatar(
            radius: radiusStack,
            backgroundImage: AssetImage(image??Assets.iconsIcCrown),

          ),

        ),
      ],
    );
  }
}





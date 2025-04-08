import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ImageView extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  final File? file;
  final BoxFit? fit;
  final Color? color;
  final double? radius;
  final double border;

  const ImageView(
      {Key? key,
        this.path,
        this.width,
        this.height,
        this.file,
        this.fit,
        this.radius,
        this.color,
        this.border = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (radius != null) {
      return path!.startsWith('http')
          ? CircleAvatar(
        backgroundImage: NetworkImage(path!),
        radius: radius!,
        onBackgroundImageError: (e, s) {
          debugPrint('image issue, $e,$s');
        },
      )
          : CircleAvatar(
        backgroundImage: AssetImage(path!),
        radius: radius!,
        onBackgroundImageError: (e, s) {
          debugPrint('image issue, $e,$s');
        },
      );
    }


    else if (file != null) {
      imageWidget = Image.file(
        file!,
        width: width,
        height: height,
        fit: fit,
      );
    } else if (path?.startsWith('http') ?? false) {
      if (path!.endsWith("svg")) {
        imageWidget = SvgPicture.network(
          path!,
          width: width ?? null,
          height: height ?? null,
        );
      } else {
        imageWidget = FadeInImage.assetNetwork(
            image: path!,
            width: width,
            height: height,
            fadeInDuration: const Duration(milliseconds: 1),
            fit: fit,
            placeholder: ''

        );
      }
    } else if (path?.startsWith('assets/') ?? false) {
      imageWidget = path!.contains(".svg")
          ? SvgPicture.asset(
        path!,
        width: width ?? null,
        height: height ?? null,
        color: color,
      )
          : Image.asset(
        path!,
        width: width ?? null,
        height: height ?? null,
        fit: fit ?? null,
        gaplessPlayback: true,
        color: color ?? null,
      );
    } else {
      imageWidget = Container(
        child: Image.file(
          File(path!),
          width: width ?? null,
          height: height ?? null,
          fit: fit ?? null,
        ),
      );
    }

    return imageWidget;
  }
}

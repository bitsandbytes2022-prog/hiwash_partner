import 'package:flutter/material.dart';

extension SizedboxExtension on num {
  SizedBox get heightSizeBox => SizedBox(height: toDouble());

  SizedBox get widthSizeBox => SizedBox(width: toDouble());
}
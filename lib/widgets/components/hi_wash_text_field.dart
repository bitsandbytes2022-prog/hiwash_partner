import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../styling/app_color.dart';
import '../../styling/app_font_poppins.dart';

class HiWashTextField extends StatelessWidget {
  final String? labelText;
  final String? subText;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? text;
  final bool readOnly;
  final bool obscure;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;
  final String? errorMaxLines;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final void Function(String?)? onFieldSubmitted;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final EdgeInsets? padding;
  final bool? isVisible;
  final String obscuringCharacter;
  final Color? fillColor;
  final TextStyle? hintStyle;

  const HiWashTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.suffixIcon,
    this.readOnly = false,
    this.obscure = false,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.onTap,
    this.text,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    this.keyboardType,
    this.errorMaxLines,
    this.subText,
    this.contentPadding,
    this.focusNode,
    this.onFieldSubmitted,
    this.padding,
    this.maxLength,
    this.textCapitalization,
    this.isVisible = true,
    this.obscuringCharacter = '*', this.fillColor, this.hintStyle,  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      readOnly: readOnly,
      obscureText: obscure,
      obscuringCharacter: obscuringCharacter,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onTap: onTap,
      enableInteractiveSelection: onTap == null,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters:
          inputFormatters ??
          inputFormatters ??
          [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(

        errorMaxLines: 3,
        errorStyle: w400_11p(color: AppColor.cC41948),
        hintText: hintText.tr,
        labelText: labelText?.tr,

        labelStyle: w400_14p(color: AppColor.c455A64),
        hintMaxLines: 2,
        fillColor: fillColor??AppColor.cF6F7FF,
        hintStyle:hintStyle?? w400_14p(color: AppColor.c2C2A2A.withOpacity(0.40)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,

        // Always show the label
        contentPadding: padding,
      ),
    );
  }
}

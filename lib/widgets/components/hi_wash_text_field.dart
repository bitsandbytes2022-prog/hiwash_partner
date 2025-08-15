import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../styling/app_color.dart';
import '../../styling/app_font_poppins.dart';


class HiWashTextField extends StatefulWidget {
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
  final String? initialValue;

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
    this.obscuringCharacter = '*',
    this.fillColor,
    this.initialValue,
  });

  @override
  State<HiWashTextField> createState() => _HiWashTextFieldState();
}

class _HiWashTextFieldState extends State<HiWashTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isReadOnly = widget.readOnly;
    return TextFormField(
      initialValue: widget.controller == null ? widget.initialValue : null,
      style: w400_14p(
        color:
        isReadOnly ? AppColor.c2C2A2A.withOpacity(0.6) : AppColor.c2C2A2A,
      ),
      focusNode: _focusNode,
      textInputAction: TextInputAction.next,
      readOnly: widget.readOnly,
      obscureText: widget.obscure,
      obscuringCharacter: widget.obscuringCharacter,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      onTap: widget.onTap,
      enableInteractiveSelection: widget.onTap == null,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters:
      widget.inputFormatters ??
          [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorMaxLines: 3,
        errorStyle: w400_11p(color: AppColor.cC41948),
        hintText: widget.hintText.tr,
        labelText: widget.labelText?.tr,
        labelStyle: w400_14p(color: AppColor.c455A64),
        hintMaxLines: 2,
        fillColor: widget.fillColor ?? AppColor.cF6F7FF,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: widget.padding,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
            isReadOnly
                ? AppColor.c2C2A2A.withOpacity(0.2)
                : AppColor.c5C6B72.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
            isReadOnly ? AppColor.c2C2A2A.withOpacity(0.2) : AppColor.blue,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
            isReadOnly
                ? AppColor.c2C2A2A.withOpacity(0.2)
                : AppColor.cC41948,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isReadOnly ? AppColor.c2C2A2A.withOpacity(0.2) : Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}
/*
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
*/

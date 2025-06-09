import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:intl/intl.dart';

import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';

class CountdownElseFullDate extends StatefulWidget {
  final String expiryDateStr;

  const CountdownElseFullDate({super.key, required this.expiryDateStr});

  @override
  State<CountdownElseFullDate> createState() => _CountdownElseFullDateState();
}

class _CountdownElseFullDateState extends State<CountdownElseFullDate> {
  late DateTime? expiryDate;
  late Timer _timer;
  Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    expiryDate = DateTime.tryParse(widget.expiryDateStr);
    if (expiryDate != null) {
      _updateRemaining();
      _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateRemaining());
    }
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = expiryDate!.difference(now);
    if (mounted) {
      setState(() {
        remaining = diff;
      });
    }
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (expiryDate == null) {
      return Text(StringConstant.kInvalidDate.tr, style: w400_12a(color: AppColor.white));
    }

    if (remaining.inHours >= 24) {
      if (remaining.inDays < 30) {
        final dayText =
        remaining.inDays == 1 ? "${StringConstant.kDays}" : "${remaining.inDays} ${StringConstant.kDays}";
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColor.cC7F6E5,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(dayText, style: w500_7a(color: AppColor.c1F9D70)),
        );
      } else {
        final formatted = DateFormat('dd MMM yyyy').format(expiryDate!);
        return Container(
          padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColor.cC7F6E5,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(formatted, style: w500_7a(color: AppColor.c1F9D70)),
        );
      }
    }

    if (remaining.isNegative) {
      return Text(StringConstant.kExpired.tr, style: w500_7a(color: AppColor.white));
    }

    final h = remaining.inHours;
    final m = remaining.inMinutes % 60;
    final s = remaining.inSeconds % 60;

    final formattedCountdown = "$h:$m ${StringConstant.kHRS.tr} - ${_twoDigits(s)} ${StringConstant.kMINS.tr}{}";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.cF6DBE2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(formattedCountdown.tr, style: w500_7a(color: AppColor.cC31848)),
    );
  }
}

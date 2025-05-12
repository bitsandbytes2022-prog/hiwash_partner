import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';

class CountdownOrDateTimer extends StatefulWidget {
  final String expiryDateStr;
  const CountdownOrDateTimer({super.key, required this.expiryDateStr});

  @override
  State<CountdownOrDateTimer> createState() => _CountdownOrDateTimerState();
}

class _CountdownOrDateTimerState extends State<CountdownOrDateTimer> {
  late DateTime? expiryDate;
  late Timer _timer;
  late Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    expiryDate = DateTime.tryParse(widget.expiryDateStr);
    if (expiryDate != null) {
      _updateRemaining();
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        _updateRemaining();
      });
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  Widget _timeContainer({required String value, required String bottomText}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: w700_22a(color: AppColor.cC31848),
          ),
          Text(
            bottomText,
            style: w400_10a(color: AppColor.c455A64),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (expiryDate == null) {
      return Text("Invalid date", style: w400_12a(color: AppColor.white));
    }

    if (remaining.inHours >= 24) {
      final formatted = DateFormat('dd MMM yyyy').format(expiryDate!);
      return Text(formatted, style: w400_12a(color: AppColor.white));
    }

    if (remaining.isNegative) {
      return Text("Expired", style: w400_12a(color: AppColor.white));
    }

    final h = remaining.inHours;
    final m = remaining.inMinutes % 60;
    final s = remaining.inSeconds % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timeContainer(
          value: _twoDigits(h),
          bottomText: h == 1 ? 'hour' : 'hours',
        ),
        Text(" : ", style: w700_22a(color: AppColor.cC31848)),
        _timeContainer(
          value: _twoDigits(m),
          bottomText: m == 1 ? 'minute' : 'minutes',
        ),
        Text(" : ", style: w700_22a(color: AppColor.cC31848)),
        _timeContainer(
          value: _twoDigits(s),
          bottomText: s == 1 ? 'second' : 'seconds',
        ),
      ],
    );
  }
}

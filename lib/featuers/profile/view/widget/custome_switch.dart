import 'package:flutter/material.dart';

class CustomContainerSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const CustomContainerSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.grey,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _CustomContainerSwitchState createState() => _CustomContainerSwitchState();
}

class _CustomContainerSwitchState extends State<CustomContainerSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 45,
        height: 22,
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.value ? widget.activeColor : widget.inactiveColor,
        ),
        child: AnimatedAlign(

          duration: Duration(milliseconds: 200),
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            margin: EdgeInsets.all(2),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

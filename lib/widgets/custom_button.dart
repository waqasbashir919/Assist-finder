import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  final String input_text;
  final GestureTapCallback onpressed;
  Color? borderColor;
  final Color buttoncolor;
  final Color textcolor;

  CustomButton(
      {Key? key,
      required this.input_text,
      required this.onpressed,
      this.borderColor,
      required this.buttoncolor,
      required this.textcolor})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: widget.borderColor ?? Colors.transparent),
          backgroundColor: widget.buttoncolor,
          minimumSize: Size(double.infinity.w, 70.h),
        ),
        onPressed: widget.onpressed,
        child: Text(
          widget.input_text.toUpperCase(),
          style: TextStyle(fontSize: 80.sp, color: widget.textcolor),
        ));
  }
}

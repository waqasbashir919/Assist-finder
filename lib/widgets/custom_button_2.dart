import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/appColors..dart';

class CustomButton2 extends StatefulWidget {
  final String input_btn;
  final void Function()? onpressed;
  final Color buttoncolor;
  final Color textcolor;
  CustomButton2(
      {Key? key,
      required this.input_btn,
      required this.onpressed,
      required this.buttoncolor,
      required this.textcolor})
      : super(key: key);

  @override
  _CustomButton2State createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2> {
  bool isButtonactive = true;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          //  side: BorderSide(color: widget.borderColor ?? Colors.transparent),
          backgroundColor: widget.buttoncolor,
          // minimumSize: Size(1080.w, 70.h),
          disabledBackgroundColor: AppColors.orange.withOpacity(0.5),
          minimumSize: Size(double.infinity.w, 70.h),
          // disabledBackgroundColor: AppColors.orange
        ),
        onPressed: widget.onpressed,
        child: Text(
          widget.input_btn.toUpperCase(),
          style: TextStyle(fontSize: 80.sp, color: Colors.white),
        ));
  }
}

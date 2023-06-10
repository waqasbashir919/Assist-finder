import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/appColors..dart';

class CutomTextField extends StatefulWidget {
  final String hintText;
  final String labeltext;
  final IconData? prefixicon;

  final TextInputType inputtype;
  final Color borerColor;
  bool obsecuretext;
  final double? height;
  final TextEditingController controller;
  final IconData? suffixicon;
  final IconData? suffixIcon2;
  final FormFieldValidator<String> validator;
  final int? maxLines;

  CutomTextField({
    Key? key,
    this.height,
    required this.hintText,
    required this.labeltext,
    this.prefixicon,
    required this.borerColor,
    required this.obsecuretext,
    required this.inputtype,
    this.maxLines,
    required this.controller,
    required this.validator,
    this.suffixicon,
    this.suffixIcon2,
    //  required this.controller,
  }) : super(key: key);

  @override
  _CutomTextFieldState createState() => _CutomTextFieldState();
}

class _CutomTextFieldState extends State<CutomTextField> {
  bool onclick = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Color.fromARGB(255, 255, 208, 205),
      width: double.infinity,
      height: 85.h,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // maxLines: widget.maxLines,
        style: TextStyle(fontSize: 75.sp),
        // autofocus: true, // boolean
        validator: widget.validator,
        controller: widget.controller,

        keyboardType: widget.inputtype,
        obscureText: widget.obsecuretext,
        decoration: InputDecoration(
            // fillColor: Colors.red,

            isDense: true,
            // errorText: 'hello',
            errorBorder: OutlineInputBorder(
              // gapPadding: 4,
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.grey,
              ),
            ),
            errorStyle: TextStyle(
              height: 0,
              fontSize: 0,
              color: Colors.transparent,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            suffixIcon: GestureDetector(
                onTap: () {
                  widget.obsecuretext = !widget.obsecuretext;
                  setState(() {});
                },
                child: widget.obsecuretext
                    ? Icon(
                        widget.suffixIcon2,
                        color: AppColors.green,
                        size: 28,
                      )
                    : Icon(
                        widget.suffixicon,
                        color: AppColors.green,
                        size: 28,
                      )),
            focusColor: Colors.grey,
            prefixIcon: IconTheme(
              data: IconThemeData(color: Colors.grey),
              child: Icon(
                widget.prefixicon,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.green, width: 2.0)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 10.0)),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/appColors..dart';

class CustomProfileInfo extends StatefulWidget {
  final String info_name;
  final String info_value;
  String? initial_value;
  TextEditingController? controller;
  final bool readOnly;
  //  final controllers = TextEditingController(text: "Your initial value");

  // final IconData prefixIcon;
  CustomProfileInfo({
    Key? key,
    required this.readOnly,
    required this.info_name,
    required this.info_value,
    this.initial_value,
    this.controller,
  }) : super(key: key);

  @override
  _CustomProfileInfoState createState() => _CustomProfileInfoState();
}

class _CustomProfileInfoState extends State<CustomProfileInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.info_name,
          style: TextStyle(fontSize: 70.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 60.h,
          child: TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controller,

            // readOnly: true,
            initialValue: widget.initial_value,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  // vertical: 10.h,
                  horizontal: 50.w),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              // labelText: 'abc@gmail.com',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              // hintStyle: TextStyle(fontSize: 70.sp, color: AppColors.green),
              // prefixIcon: Icon(
              //   widget.prefixIcon,
              //   color: AppColors.green,
              //   size: 20,
              // ),
              // focusedBorder: InputBorder.none,
              hintText: '${widget.info_value}',
            ),
          ),
        ),
      ],
    );
  }
}

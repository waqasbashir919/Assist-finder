import 'package:flutter/material.dart';

import '../const/appColors..dart';

class JobDescriptionTextfield extends StatefulWidget {
  final String hintText;
  final String labeltext;
  IconData? prefixicon;

  final TextInputType inputtype;

  final Color borerColor;
  bool obsecuretext;
  double? height;
  final TextEditingController controller;
  final IconData? suffixicon;
  final IconData? suffixIcon2;
  final FormFieldValidator<String> validator;
  int? maxLines;

  JobDescriptionTextfield(
      {Key? key,
      required this.hintText,
      required this.labeltext,
      this.prefixicon,
      required this.inputtype,
      required this.borerColor,
      required this.controller,
      this.suffixicon,
      this.suffixIcon2,
      required this.validator,
      required this.obsecuretext})
      : super(key: key);

  @override
  _JobDescriptionTextfieldState createState() =>
      _JobDescriptionTextfieldState();
}

class _JobDescriptionTextfieldState extends State<JobDescriptionTextfield> {
  bool onclick = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.inputtype,
      obscureText: widget.obsecuretext,
      decoration: InputDecoration(
          isDense: true,
          errorBorder: OutlineInputBorder(
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
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.green, width: 2.0)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 10.0)),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey)),
    );
  }
}

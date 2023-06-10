import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_drop_down.dart';

class FilerScreen extends StatefulWidget {
  const FilerScreen({Key? key}) : super(key: key);

  @override
  _FilerScreenState createState() => _FilerScreenState();
}

class _FilerScreenState extends State<FilerScreen> {
  bool isChecked_contactno = false;
  bool isChecked_emailidno = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        automaticallyImplyLeading: false,
        title: Text('Advance Search'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              SelecType(
                text: 'Select User Type',
              ),
              SizedBox(
                height: 30.h,
              ),
              SelecType(
                text: 'State',
              ),
              SizedBox(
                height: 30.h,
              ),
              SelecType(
                text: 'Requirements Priority',
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: AppColors.green,
                      value: isChecked_contactno,
                      onChanged: (value) {
                        setState(() {
                          isChecked_contactno = value!;
                        });
                      }),
                  Text('Post with Contact Number'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: AppColors.green,
                      value: isChecked_emailidno,
                      onChanged: (value) {
                        setState(() {
                          isChecked_emailidno = value!;
                        });
                      }),
                  Text('Post with Email ID Number'),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              //  CustomButton(
              //   input_text: 'Search Now',)
              InkWell(
                  onTap: () {},
                  child: CustomButton(
                    input_text: 'Search Now',
                    onpressed: () {},
                    buttoncolor: AppColors.orange,
                    textcolor: AppColors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

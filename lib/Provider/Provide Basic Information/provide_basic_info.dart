import 'package:asist_finder/Provider/custom_drop_down_location.dart';
import 'package:asist_finder/Provider/Include%20Details/include_details.dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/appColors..dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/job_description_textfield.dart';

class ProviderGiveJob2 extends StatefulWidget {
  const ProviderGiveJob2({Key? key}) : super(key: key);

  @override
  _ProviderGiveJob2State createState() => _ProviderGiveJob2State();
}

class _ProviderGiveJob2State extends State<ProviderGiveJob2> {
  @override
  final TextEditingController job_description = TextEditingController();

  final TextEditingController Responsibilities_controller =
      TextEditingController();

  final TextEditingController requirements_controller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomButton(
        input_text: 'Save and Continue',
        onpressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => IncludeDetail()));
        },
        buttoncolor: AppColors.orange,
        textcolor: AppColors.white,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text('Provide Basic Information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Text(
                  'Job Title',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 100.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CutomTextField(
                  maxLines: null,
                  borerColor: Colors.grey,
                  controller: Responsibilities_controller,
                  hintText: 'Enter Your Job Title',
                  inputtype: TextInputType.name,
                  labeltext: '',
                  obsecuretext: false,
                  prefixicon: CupertinoIcons.rectangle_stack_person_crop,
                  validator: (String? value) {
                    return null;
                  },
                ),
                Text(
                  'Location',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 100.sp),
                ),
                SizedBox(
                  height: 25.h,
                ),
                dropdown_location(),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Job Description',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 100.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                JobDescriptionTextfield(
                  borerColor: Colors.grey,
                  controller: job_description,
                  hintText: 'Write Job Description',
                  inputtype: TextInputType.multiline,
                  labeltext: '',
                  obsecuretext: false,
                  prefixicon: Icons.description,
                  validator: (String? value) {
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

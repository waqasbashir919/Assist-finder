import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Job Search/job_search.dart';
import '../../const/appColors..dart';
import 'job_type.dart';

class IncludeDetail extends StatefulWidget {
  const IncludeDetail({Key? key}) : super(key: key);

  @override
  _IncludeDetailState createState() => _IncludeDetailState();
}

class _IncludeDetailState extends State<IncludeDetail> {
  RangeValues _currentrangevalues = RangeValues(0, 100);
  DateTime? date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    RangeValues valuess = RangeValues(0, 100);
    RangeLabels labels =
        RangeLabels(valuess.start.toString(), valuess.end.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text('Include details'),
        centerTitle: true,
      ),
      floatingActionButton: CustomButton(
        input_text: 'Submit',
        onpressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => JobSearch()));
        },
        buttoncolor: AppColors.orange,
        textcolor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                'What is your job type ?',
                style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    JobType(
                      text: 'Full Time',
                    ),
                    JobType(
                      text: 'Part Time',
                    ),
                    JobType(
                      text: 'Temporary',
                    ),
                    JobType(
                      text: 'Contract',
                    ),
                    JobType(
                      text: 'Internship',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Select Deadline',
                style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: CustomButton(
                  input_text: 'Select Date',
                  onpressed: () async {
                    DateTime? newDate = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.orange,
                                ),
                              ),
                              child: child!);
                        },
                        context: context,
                        initialDate: date!,
                        firstDate: DateTime(1940),
                        lastDate: DateTime(2100));

                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                    });
                    print(date);
                  },
                  buttoncolor: AppColors.orange,
                  textcolor: AppColors.white,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Salary Range',
                style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w500),
              ),
              // RangeSlider(
              //     labels: labels,
              //     values: valuess,
              //     onChanged: (newvalue) {
              //       valuess = newvalue;
              //       setState(() {});
              //     })
              RangeSlider(
                  activeColor: AppColors.orange,
                  values: _currentrangevalues,
                  max: 100,
                  divisions: 20,
                  labels: RangeLabels(
                      _currentrangevalues.start.round().toString(),
                      _currentrangevalues.end.round().toString()),
                  onChanged: (RangeValues value) {
                    print('Range value start ${value.start}');
                    print('Range value end ${value.end}');
                    setState(() {
                      _currentrangevalues = value;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

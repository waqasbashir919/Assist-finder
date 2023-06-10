import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav.dart';
import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav_2.dart';
import 'package:asist_finder/Profile%20Screen/mypost.dart';
import 'package:asist_finder/const/appColors..dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class ViewProfile extends StatefulWidget {
  final mobileNumber;
  final email;
  final firstname;
  final lastname;
  ViewProfile(
      {Key? key,
      required this.mobileNumber,
      required this.email,
      required this.firstname,
      required this.lastname})
      : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  var firstname;
  var lastName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text("${widget.firstname} ${widget.lastname}"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150.h,
                      width: double.infinity,
                      color: AppColors.orange,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_pin_rounded,
                            size: 60,
                            color: AppColors.white,
                          ),
                          Text(
                            '${widget.firstname} ${widget.lastname}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 90.sp),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 50.h,
                            padding: EdgeInsets.only(left: 90.w),
                            width: double.infinity,
                            color: Color.fromARGB(255, 204, 204, 204),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "More Information",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 70.sp),
                              ),
                            )),
                        // SizedBox(
                        //   height: 20.h,
                        // ),

                        Container(
                            height: 60.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 90.w),
                            child: Text(
                              'Mobile: ${widget.mobileNumber}',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 70.sp),
                            )),
                        Divider(
                          thickness: 1,
                        ),
                        Container(
                            height: 60.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 90.w),
                            child: Text(
                              'Email: ${widget.email}',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 70.sp),
                            )),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 90.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 60.h,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'My Post',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 70.sp),
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mypost()));
                                },
                                child: Container(
                                  width: 230.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'View',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 90.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 60.h,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Payment History',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 70.sp),
                                  )),
                              Container(
                                width: 230.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.green,
                                ),
                                child: Center(
                                  child: Text(
                                    'View',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 90.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 60.h,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Do you want to refresh your app',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 70.sp),
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              bottomnav()));
                                },
                                child: Container(
                                  // width: 230.w,
                                  // height: 35.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 35.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Restart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Divider(
                        //   thickness: 1,
                        // ),

                        Container(
                            height: 50.h,
                            padding: EdgeInsets.only(left: 90.w),
                            width: double.infinity,
                            color: Color.fromARGB(255, 204, 204, 204),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Total Ratings",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 70.sp),
                              ),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('5 Star',
                                  style: TextStyle(
                                      color: AppColors.green, fontSize: 80.sp)),
                              SizedBox(
                                width: 50.w,
                              ),
                              Expanded(
                                child: GFProgressBar(
                                  percentage: 0.5,
                                  // width: 1400.w,
                                  lineHeight: 25.h,
                                  radius: 100,
                                  progressBarColor: AppColors.orange,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 234, 203),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      '40%',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 70.sp, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('4 Star',
                                  style: TextStyle(
                                      color: AppColors.green, fontSize: 80.sp)),
                              SizedBox(
                                width: 50.w,
                              ),
                              Expanded(
                                child: GFProgressBar(
                                  percentage: 0.2,
                                  // width: 1400.w,
                                  lineHeight: 25.h,
                                  radius: 100,
                                  progressBarColor: AppColors.orange,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 234, 203),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      '20%',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 70.sp, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('3 Star',
                                  style: TextStyle(
                                      color: AppColors.green, fontSize: 80.sp)),
                              SizedBox(
                                width: 50.w,
                              ),
                              Expanded(
                                child: GFProgressBar(
                                  percentage: 0.9,
                                  // width: 1400.w,
                                  lineHeight: 25.h,
                                  radius: 100,
                                  progressBarColor: AppColors.orange,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 234, 203),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      '90%',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 70.sp, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('2 Star',
                                  style: TextStyle(
                                      color: AppColors.green, fontSize: 80.sp)),
                              SizedBox(
                                width: 50.w,
                              ),
                              Expanded(
                                child: GFProgressBar(
                                  percentage: 0.3,
                                  // width: 1400.w,
                                  lineHeight: 25.h,
                                  radius: 100,
                                  progressBarColor: AppColors.orange,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 234, 203),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      '30%',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 70.sp, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.w,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('1 Star',
                                  style: TextStyle(
                                      color: AppColors.green, fontSize: 80.sp)),
                              SizedBox(
                                width: 50.w,
                              ),
                              Expanded(
                                child: GFProgressBar(
                                  percentage: 0.1,
                                  // width: 1400.w,
                                  lineHeight: 25.h,
                                  radius: 100,
                                  progressBarColor: AppColors.orange,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 234, 203),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      '10%',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 70.sp, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          // height: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 90.w, vertical: 15.h),
                          width: double.infinity,
                          color: Color.fromARGB(255, 204, 204, 204),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Recommendation'),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text('Total Reviews')
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

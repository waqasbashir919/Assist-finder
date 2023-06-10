import 'package:asist_finder/Profile%20Screen/change_password.dart';
import 'package:asist_finder/Profile%20Screen/custom_profile_info.dart';
import 'package:asist_finder/Profile%20Screen/privacy_policy.dart';
import 'package:asist_finder/Profile%20Screen/terms_and_condition.dart';
import 'package:asist_finder/Profile%20Screen/update_screen.dart';
import 'package:asist_finder/Profile%20Screen/view_profile.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/utils/utils.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Login Screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  // final chat_user_data user;
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  var id = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  //Image is null
  var _image;
  var imageUrl;
  var userData;

  bool isLoading = true;
  var selectedImage;

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  var firstname;
  var lastName;
  var mobileNumber;
  var email;
  var dropdownvalue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          centerTitle: true,
          title: Text('Profile'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: ((BuildContext context) {
                      return AlertDialog(
                        title: Text('Sign out app'),
                        content: StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return Text("Do you want to Sign out the app");
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'cancel',
                              style: TextStyle(
                                  color: AppColors.green, fontSize: 80.sp),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              'ok',
                              style: TextStyle(
                                  color: AppColors.green, fontSize: 80.sp),
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance
                                  .signOut()
                                  .then((value) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  utils.flushbarmessagegreen(
                                      'Application is sign out', context);
                                });
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              });

                              // Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }),
                  );
                },
                icon: Icon(Icons.logout_sharp))
          ],
          // leading: Icon(CupertinoIcons.home),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'User Type',
                          style: TextStyle(
                              fontSize: 80.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '$dropdownvalue',
                          style: TextStyle(
                            fontSize: 80.sp,
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'First Name',
                          style: TextStyle(
                              fontSize: 80.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '$firstname',
                          style: TextStyle(
                            fontSize: 80.sp,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Last Name',
                          style: TextStyle(
                              fontSize: 80.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '$lastName',
                          style: TextStyle(
                            fontSize: 80.sp,
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontSize: 80.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '$mobileNumber',
                          style: TextStyle(
                            fontSize: 80.sp,
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 80.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '$email',
                          style: TextStyle(
                            fontSize: 80.sp,
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        CustomButton(
                            input_text: 'Update Profile',
                            onpressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateScreen(
                                            lastName: lastName,
                                            mobileNumber: mobileNumber,
                                            email: email,
                                            firstname: firstname,
                                          )));
                              // utils.flushbarmessagegreen(
                              //     'Updated Successfully', context);
                            },
                            buttoncolor: AppColors.orange,
                            textcolor: AppColors.white),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomButton(
                            borderColor: AppColors.orange,
                            input_text: 'view full profile',
                            onpressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewProfile(
                                            email: email,
                                            mobileNumber: mobileNumber,
                                            firstname: firstname,
                                            lastname: lastName,
                                          )));
                            },
                            buttoncolor: AppColors.white,
                            textcolor: AppColors.orange),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomButton(
                            input_text: 'Change Password',
                            onpressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePassword()));
                            },
                            buttoncolor: AppColors.orange,
                            textcolor: AppColors.white),
                        SizedBox(
                          height: 150.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            PrivacyPolicy())));
                              },
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.green),
                              ),
                            ),
                            SizedBox(
                              width: 30.h,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            TermsAndCondition())));
                              },
                              child: Text(
                                'Terms and Condition',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.green),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  fetchUserInfo() {
    var docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .snapshots();
    docRef.first.then((value) {
      firstname = value['firstname'];
      lastName = value['Lastname'];
      mobileNumber = value['mobilenumber'];
      email = value['email'];
      dropdownvalue = value['dropdownvalue'];
    });
  }
}

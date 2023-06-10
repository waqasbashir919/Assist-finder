import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/utils/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/custom_text_field.dart';
import '../const/appColors..dart';
import '../widgets/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  // var email = "";
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailEditingcontroller =
        TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          title: Text('Forgot Password'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 65.h,
                    ),
                    Center(
                      child: CircleAvatar(
                        maxRadius: 240.r,
                        backgroundColor: AppColors.green,
                        child: Icon(
                          Icons.join_inner,
                          color: AppColors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('Welcome to AssistFinder',
                        style:
                            TextStyle(color: Colors.black87, fontSize: 100.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                        'Please put email address Password will be shortly reach on your email address',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      height: 50.h,
                    ),
                    CutomTextField(
                      inputtype: TextInputType.emailAddress,
                      hintText: 'Enter your Email',
                      borerColor: Colors.grey,
                      labeltext: '',
                      obsecuretext: false,
                      prefixicon: Icons.mail,
                      controller: emailEditingcontroller,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ("Please Enter Your Email");
                        }
                        // reg expression for email validation
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomButton(
                      input_text: 'Submit',
                      onpressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            // email = emailEditingcontroller.text;
                            // resetPassword(emailEditingcontroller.text);
                            ForgotPassword1(emailEditingcontroller.text);
                            // emailEditingcontroller.clear();
                          });
                        }
                      },
                      buttoncolor: AppColors.orange,
                      textcolor: AppColors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ForgotPassword1(String email) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(email: email).then((uid) => {
              utils.flushbarmessagegreen('Check Your Email', context),
              // //Navigate to bottom Nav bar
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => bottomnav())),
            });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case 'wrong-password':
            errorMessage = "Your password is wrong.";
            break;
          case 'user-not-found':
            errorMessage = "User with this email doesn't exist.";
            break;
          case 'user-disabled':
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        utils.flushbarmessagered(errorMessage!, context);

        print(error.code);
      }
    }
  }

  resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Password Reset Email has been sent !",
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email");
        utils.flushbarmessagered('No user found for that email', context);
      }
    }
  }
}

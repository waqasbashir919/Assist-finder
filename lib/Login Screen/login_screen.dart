import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav_2.dart';
import 'package:asist_finder/Login%20Screen/otp_verfication.dart';
import 'package:asist_finder/Login%20Screen/phone_textfield.dart';
import 'package:asist_finder/Profile%20Screen/terms_and_condition.dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/utils/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Bottom Navigation bar.dart/bottom_nav.dart';
import '../Forgot Password/forgot_password.dart';
import '../Profile Screen/privacy_policy.dart';
import '../Registration/registration.dart';
import '../const/appColors..dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_button_2.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  String? mobile_num;
  LoginScreen({Key? key, this.mobile_num}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final TextEditingController phonecontroller = TextEditingController();
  bool _btnEnabled = false;

  bool onclick = false;
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  // final uid = FirebaseAuth.instance.currentUser!.uid;

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
            child: Form(
              key: _formKey,
              onChanged: () => setState(
                  () => _btnEnabled = _formKey.currentState!.validate()),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120.h,
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
                    height: 40.h,
                  ),
                  Center(
                    child: Text(
                      'Welcome to Assist Finder',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 120.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CutomTextField(
                    inputtype: TextInputType.emailAddress,
                    hintText: 'Enter Your Email',
                    borerColor: Colors.grey,
                    labeltext: '',
                    obsecuretext: false,
                    prefixicon: Icons.mobile_friendly,
                    controller: emailEditingController,
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
                  // SizedBox(chan
                  //   height: 5.h,
                  // ),
                  CutomTextField(
                    suffixicon: Icons.visibility,
                    suffixIcon2: Icons.visibility_off,
                    inputtype: TextInputType.visiblePassword,
                    hintText: 'Enter Password',
                    borerColor: Colors.grey,
                    labeltext: '',
                    obsecuretext: true,
                    prefixicon: Icons.lock,
                    controller: passwordEditingController,
                    validator: (String? value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomButton2(
                    input_btn: 'Login',
                    onpressed: _btnEnabled
                        ? () => signIn(emailEditingController.text,
                            passwordEditingController.text)
                        : null,
                    buttoncolor: AppColors.orange,
                    textcolor: Colors.white,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 1),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: AppColors.orange))),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: AppColors.orange),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    borderColor: AppColors.orange,
                    input_text: 'Create Account',
                    onpressed: () {
                      setState(() {
                        signIn(emailEditingController.text,
                            passwordEditingController.text);
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registration()));
                          // print('Wajih ki uid ${uid}');
                        });
                      });
                    },
                    buttoncolor: Colors.white,
                    textcolor: AppColors.orange,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Or",
                    style: TextStyle(fontSize: 80.sp, color: AppColors.green),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton2(
                    input_btn: 'Login with OTP',
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contetx) => PhoneTextfield()));
                    },
                    buttoncolor: AppColors.orange,
                    textcolor: Colors.white,
                  ),

                  SizedBox(
                    height: 120.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => PrivacyPolicy())));
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
                                  builder: ((context) => TermsAndCondition())));
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
        ),
      ),
    );
  }

  // login function
  Future signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    utils.flushbarmessagegreen('Login Successfully', context);
                  }),
                  // Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => bottomnav())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
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
        // Fluttertoast.showToast(msg: errorMessage!);
        utils.flushbarmessagered(errorMessage!, context);
        print(error.code);
      }
    }
  }
}

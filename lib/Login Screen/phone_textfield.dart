import 'package:asist_finder/Login%20Screen/otp_verfication.dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/appColors..dart';
import '../widgets/custom_button_2.dart';
import '../widgets/custom_text_field.dart';

class PhoneTextfield extends StatefulWidget {
  const PhoneTextfield({Key? key}) : super(key: key);

  @override
  _PhoneTextfieldState createState() => _PhoneTextfieldState();
}

class _PhoneTextfieldState extends State<PhoneTextfield> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  final TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: AppColors.green,
        centerTitle: true,
        title: Text('Login with Phone'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We will send you a OTP verification code",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.h,
              ),
              CutomTextField(
                inputtype: TextInputType.phone,
                hintText: '+923162788562',
                borerColor: Colors.grey,
                labeltext: '',
                obsecuretext: false,
                prefixicon: Icons.phone,
                controller: phonecontroller,
                validator: (String? value) {
                  // reg expression for email validation
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomButton2(
                input_btn: 'get otp',
                onpressed: () {
                  print(phonecontroller);
                  _auth.verifyPhoneNumber(
                      phoneNumber: phonecontroller.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        utils.flushbarmessagered(e.toString(), context);
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => otpVerification(
                                      verficationid: verificationId,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        utils.flushbarmessagered(e.toString(), context);
                      });
                },
                buttoncolor: AppColors.orange,
                textcolor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

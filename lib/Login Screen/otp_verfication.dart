import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav.dart';
import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav_2.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class otpVerification extends StatefulWidget {
  final String verficationid;
  const otpVerification({key, required this.verficationid}) : super(key: key);

  @override
  _otpVerificationState createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController verifyCode = TextEditingController();
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
        title: Text('OTP Verification'),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 24,
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
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CutomTextField(
                      inputtype: TextInputType.phone,
                      hintText: 'Enter Phone Number',
                      borerColor: Colors.grey,
                      labeltext: '',
                      obsecuretext: false,
                      prefixicon: Icons.phone,
                      controller: verifyCode,
                      validator: (String? value) {
                        // reg expression for email validation
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final credential = PhoneAuthProvider.credential(
                              verificationId: widget.verficationid,
                              smsCode: verifyCode.text.toString());

                          try {
                            await _auth.signInWithCredential(credential);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => bottomnav()));
                          } catch (e) {
                            utils.flushbarmessagered(e.toString(), context);
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

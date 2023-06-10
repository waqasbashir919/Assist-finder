import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/utils/utils.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var changepasswords = '';
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.green,
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Change Password',
                style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20.h,
              ),
              CutomTextField(
                prefixicon: Icons.lock,
                borerColor: Colors.grey,
                controller: newPassword,
                hintText: 'Enter New Password',
                inputtype: TextInputType.visiblePassword,
                labeltext: '',
                obsecuretext: true,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please type password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              // Text(
              //   'Confirm Password',
              //   style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w400),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // CutomTextField(
              //   prefixicon: Icons.lock,
              //   borerColor: Colors.grey,
              //   controller: confirmPassword,
              //   hintText: 'Enter Confirm Password',
              //   inputtype: TextInputType.visiblePassword,
              //   labeltext: '',
              //   obsecuretext: true,
              //   validator: (String? value) {

              //   },
              // ),
              CustomButton(
                  input_text: 'update password',
                  onpressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        // email = emailEditingcontroller.text;
                        // resetPassword(emailEditingcontroller.text);
                        // changepasswords = newPassword.text;
                        changePassword(newPassword.text);
                      });
                    }
                  },
                  buttoncolor: AppColors.orange,
                  textcolor: AppColors.white)
            ],
          ),
        ),
      ),
    );
  }

  changePassword(String newPass) async {
    print(newPass);
    try {
      await currentUser!.updatePassword(newPass);
      newPassword.clear();
      print('wajih');
      utils.flushbarmessagegreen('Your Password has been Changed', context);
    } catch (e) {
      utils.flushbarmessagered(e.toString(), context);
    }
  }
}

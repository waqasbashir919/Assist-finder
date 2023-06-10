import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav.dart';
import 'package:asist_finder/Profile%20Screen/profile_screen.dart';
import 'package:asist_finder/Profile%20Screen/view_profile.dart';
import 'package:asist_finder/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Login Screen/login_screen.dart';
import '../const/appColors..dart';
import '../widgets/custom_button.dart';
import 'change_password.dart';
import 'custom_profile_info.dart';

class UpdateScreen extends StatefulWidget {
  final String firstname;
  final String lastName;
  final String mobileNumber;
  final String email;

  UpdateScreen(
      {Key? key,
      required this.firstname,
      required this.lastName,
      required this.mobileNumber,
      required this.email})
      : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  var id = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  // final  firstnamecontroller = TextEditingController(text: '$firstname');
  // final  lastnamecontroller = TextEditingController(text: "Your initial value");
  // final  emailEditingcontroller = TextEditingController(text: "Your initial value");
  // final  mobilenumcontroller = TextEditingController(text: "Your initial value");
  // final  passwordeditingcontroller = TextEditingController(text: "Your initial value");

  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController emailEditingcontroller = TextEditingController();
  final TextEditingController mobilenumcontroller = TextEditingController();
  final TextEditingController passwordeditingcontroller =
      TextEditingController();

  // void get() async {
  //   TextEditingController firstName;
  //   TextEditingController lastName;

  //   User? user = await FirebaseAuth.instance.currentUser;
  //   var getName = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get();

  //   setState(() {
  //     firstName = TextEditingController(text: getName.data()!['firstname']);
  //      = TextEditingController(text: getName.data()!['firstname']);

  //   });
  //   // setState(() {

  //   // });
  // }

  // UserModel loggedInUser = UserModel();

  final _formKey = GlobalKey<FormState>();

  //Image is null
  var _image;
  var imageUrl;
  var userData;
  bool isLoading = true;
  var selectedImage;

  @override
  void initState() {
    firstnamecontroller.text = widget.firstname;
    lastnamecontroller.text = widget.lastName;
    emailEditingcontroller.text = widget.email;
    mobilenumcontroller.text = widget.mobileNumber;
    // widget.firstname;
    // widget.lastName;
    // widget.mobileNumber;
    // widget.email;

    // firstnamecontroller;
    // lastnamecontroller;
    // emailEditingcontroller;
    // mobilenumcontroller;
    // fetchUserInfo();
    // fetchUserInformation();
    super.initState();
  }

  var firstname;
  var lastName;
  var mobileNumber;
  var email;

  void get() async {
    // TextEditingController _username;
    User? user = await FirebaseAuth.instance.currentUser;
    var getName = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    // setState(() {
    //   user_name = TextEditingController(text: getName.data()!['username']);
    //   email = getName.data()!['email'];
    //   name = getName.data()!['username'];

    //   // date1 = getName.data()!['date1'];
    // });
    // setState(() {

    // });
  }

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
              title: Text('Update'),
            ),
            body: Form(
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
                      // CustomProfileInfo(
                      //   info_name: 'User Type*',
                      //   info_value: 'Contractors',
                      // ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomProfileInfo(
                        info_name: 'First Name*',
                        info_value: '',
                        // initial_value: widget.firstname,
                        readOnly: false,
                        controller: firstnamecontroller,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomProfileInfo(
                        info_name: 'Last Name*',
                        info_value: '',
                        // initial_value: widget.lastName,
                        readOnly: false,
                        controller: lastnamecontroller,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomProfileInfo(
                        info_name: 'Mobile Number*',
                        info_value: '',
                        // initial_value: widget.mobileNumber,
                        readOnly: true,
                        controller: mobilenumcontroller,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomProfileInfo(
                        info_name: 'Email',
                        info_value: '',
                        // initial_value: widget.email,
                        readOnly: false,
                        controller: emailEditingcontroller,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomButton(
                          input_text: 'update now',
                          onpressed: () {
                            // fetchUserInformation();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => bottomnav()));
                            fetchUserInfo();
                            utils.flushbarmessagegreen(
                                'Updated Successfully', context);
                          },
                          buttoncolor: AppColors.orange,
                          textcolor: AppColors.white),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  // fetchUserInfo() {
  //   var docRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(currentUser)
  //       .update({
  //         'firstname': firstname,
  //         'Lastname': lastName,
  //         'mobilenumber': mobileNumber,
  //         'email': email,
  //       })
  //       .then((value) => print("Success"))
  //       .catchError((error) => print('Failed: $error'));
  // }
  // fetchUserInformation() {
  //   var docRef = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(currentUser)
  //       .snapshots();
  //   docRef.first.then((value) {
  //     firstname = value['firstname'];
  //     lastName = value['Lastname'];
  //     mobileNumber = value['mobilenumber'];
  //     email = value['email'];
  //   });
  // }

  fetchUserInfo() {
    var docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser);

    docRef.update({
      'firstname': firstnamecontroller.text.trim(),
      'Lastname': lastnamecontroller.text.trim(),
      'mobilenumber': mobilenumcontroller.text.trim(),
      'email': emailEditingcontroller.text.trim(),
    });

    // docRef.update({
    //   'firstname': firstname.text.trim(),
    //   'Lastname': lastName.text.trim(),
    //   'mobilenumber': mobileNumber.text.trim(),
    //   'email': email.text.trim(),
    //   // 'gender': gender == 1 ? "male" : "Female"
    // });
  }
}

import 'package:asist_finder/Login%20Screen/login_screen.dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/utils/utils.dart';
import 'package:asist_finder/widgets/custom_button_2.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_text_field.dart';
import '../const/appColors..dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final List<String> _values = ["Seeker", "Provider", "User Type"];

  // the selected value
  String? _selectedfield;
  bool _btnEnabled = false;
  // firebase
  // final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  bool onclick = false;

  static TextEditingController mobilenumcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController emailEditingcontroller = TextEditingController();
  final TextEditingController passwordeditingcontroller =
      TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // var selectedImage;
  // var imageUrl;
  @override
  void dispose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    emailEditingcontroller.dispose();
    mobilenumcontroller.dispose();
    passwordeditingcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          // bottomNavigationBar: bottomnav(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.green,
            title: Text('Registration'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
              child: Form(
                key: _formKey,
                onChanged: () => setState(
                    () => _btnEnabled = _formKey.currentState!.validate()),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'Welcome to AssistFinder',
                      style: TextStyle(color: Colors.black, fontSize: 100.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'New User Please register here',
                      style: TextStyle(color: Colors.grey, fontSize: 75.sp),
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 15),
                      height: 70.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                        
                        ],
                        color: Colors.white,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        // onChanged: (salutation) =>
                        //     setState(() => selectedSalutation = salutation),
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        hint: Text(
                          'Select',
                          style: TextStyle(color: Colors.grey, fontSize: 80.sp),
                        ),
                        value: _selectedfield,
                        onChanged: (value) {
                          setState(() {
                            _selectedfield = value;
                          });
                        },
                        // Hide the default underline
                        // set the color of the dropdown menu
                        // dropdownColor: Colors.amber,
                        icon: Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.grey,
                        ),
                        isExpanded: true,

                        // The list of options
                        items: _values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          fontSize: 80.sp,
                                          color: Color.fromARGB(
                                              255, 143, 143, 143)),
                                    ),
                                  ),
                                ))
                            .toList(),

                        // Customize the selected item
                        selectedItemBuilder: (BuildContext context) => _values
                            .map((e) => Center(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          fontSize: 80.sp, color: Colors.grey),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    // SelecType(
                    //   text: 'Select User Type',
                    // ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CutomTextField(
                      hintText: 'Enter Your First Name',
                      borerColor: Colors.grey,
                      labeltext: '',
                      obsecuretext: false,
                      prefixicon: Icons.person,
                      inputtype: TextInputType.name,
                      controller: firstnamecontroller,
                      validator: (String? value) {
                        RegExp regex = new RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return ("First Name cannot be Empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid name(Min. 3 Character)");
                        }
                        return null;
                      },
                    ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    CutomTextField(
                      hintText: 'Enter Your Last Name',
                      inputtype: TextInputType.name,
                      borerColor: Colors.grey,
                      labeltext: '',
                      obsecuretext: false,
                      prefixicon: Icons.person,
                      controller: lastnamecontroller,
                      validator: (String? value) {
                        RegExp regex = new RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return ("Second Name cannot be Empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid name(Min. 3 Character)");
                        }
                        return null;
                      },
                    ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    CutomTextField(
                      inputtype: TextInputType.emailAddress,
                      hintText: 'Enter Your Email',
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
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    CutomTextField(
                      inputtype: TextInputType.phone,
                      hintText: 'Enter Your Mobile Number',
                      borerColor: Colors.grey,
                      labeltext: '',
                      obsecuretext: false,
                      prefixicon: Icons.mobile_friendly,
                      controller: mobilenumcontroller,
                      validator: (String? value) {
                        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = RegExp(pattern);
                        if (value?.length == 0) {
                          return 'Please Enter Your mobile number';
                        } else if (!regExp.hasMatch(value!)) {
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                    ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    CutomTextField(
                      inputtype: TextInputType.visiblePassword,
                      suffixicon: Icons.visibility,
                      suffixIcon2: Icons.visibility_off,
                      hintText: 'Enter Your Password',
                      borerColor: Colors.grey,
                      labeltext: '',
                      obsecuretext: true,
                      prefixicon: Icons.lock,
                      controller: passwordeditingcontroller,
                      validator: (String? value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return ("Password is required for login");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid Password(Min. 6 Character)");
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

                    // CustomButton(
                    //   input_text: 'Upload Image',
                    //   onpressed: () async{
                    //       final ImagePicker picker = ImagePicker();

                    //             // Pick an image.
                    //             var image = await picker.pickImage(
                    //                 source: ImageSource.gallery);

                    //             if (image != null) {
                    //               File imageTemporary = File(image!.path);
                    //             setState(() {
                    //               selectedImage = imageTemporary.path;
                    //             });
                    //             }
                    //   },
                    // ),
                    CustomButton2(
                        input_btn: 'Register',
                        onpressed: _btnEnabled
                            ? () {
                                signUp(emailEditingcontroller.text,
                                    passwordeditingcontroller.text);
                                print(mobilenumcontroller);

                                // _auth.verifyPhoneNumber(
                                //     phoneNumber: mobilenumcontroller.text,
                                //     verificationCompleted: (_) {
                                //       utils.flushbarmessagegreen(
                                //           'verification sent to the mobile number',
                                //           context);
                                //     },
                                //     verificationFailed: (e) {
                                //       utils.flushbarmessagered(
                                //           e.toString(), context);
                                //     },
                                //     codeSent:
                                //         (String verificationId, int? token) {
                                //       //  Navigator.push(
                                //       //       context,
                                //       //       MaterialPageRoute(
                                //       //           builder: (context) => otpVerification(
                                //       //                 verficationid: verificationId,
                                //       //               )));
                                //     },
                                //     codeAutoRetrievalTimeout: (e) {
                                //       utils.flushbarmessagered(
                                //           e.toString(), context);
                                //     });
                              }
                            : null,
                        buttoncolor: AppColors.orange,
                        textcolor: Colors.white),
                    SizedBox(
                      height: 20.h,
                    ),
                    // CustomButton(
                    //   input_text: 'Register',
                    //   onpressed: () {
                    //     signUp(emailEditingcontroller.text,
                    //         passwordeditingcontroller.text);
                    //     // Navigator.push(context,
                    //     //     MaterialPageRoute(builder: (context) => bottomnav()));
                    //   },
                    //   buttoncolor: AppColors.orange,
                    //   textcolor: AppColors.white,
                    // ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 75.sp)),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                            mobile_num:
                                                mobilenumcontroller.text,
                                          )));
                              // index = 0;
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    color: AppColors.orange,
                                    fontSize: 75.sp,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                    SizedBox(
                      height: 50.w,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          // Fluttertoast.showToast(msg: e!.message);
          utils.flushbarmessagered(e!.message, context);
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

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    // UserModel userModel = UserModel();

    // // writing all the values
    // userModel.email = user!.email;
    // userModel.uid = user.uid;
    // userModel.firstName = firstnamecontroller.text;
    // userModel.secondName = lastnamecontroller.text;
    // userModel.mobilenumber = mobilenumcontroller.text;
    Map<String, dynamic> userData = {
      'firstname': firstnamecontroller.text,
      'Lastname': lastnamecontroller.text,
      'mobilenumber': mobilenumcontroller.text,
      'email': emailEditingcontroller.text,
      'dropdownvalue': _selectedfield
    };
    await firebaseFirestore.collection("users").doc(user!.uid).set(userData);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      utils.flushbarmessagegreen('Account created successfully', context);
    });

    Navigator.push(
        (context), MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

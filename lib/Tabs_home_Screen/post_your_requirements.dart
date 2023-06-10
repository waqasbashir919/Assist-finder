// import 'package:asist_finder/Tabs_home_Screen/availability_item.dart';
// import 'package:asist_finder/Tabs_home_Screen/requirements_items.dart';
// import 'package:asist_finder/Tabs_home_Screen/state_items.dart';
import 'dart:io';

import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav.dart';
import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav_2.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:asist_finder/widgets/custom_button_2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/job_description_textfield.dart';

class PostYourRequirements extends StatefulWidget {
  const PostYourRequirements({Key? key}) : super(key: key);

  @override
  _PostYourRequirementsState createState() => _PostYourRequirementsState();
}

class _PostYourRequirementsState extends State<PostYourRequirements> {
  String imageUrl = '';

  //upload image
  void pickUploadImage() async {
    var collection = await FirebaseFirestore.instance.collection('jobs').doc();

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    Reference ref =
        FirebaseStorage.instance.ref().child('banner/${collection.id}');

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) {
      print(value);

      setState(() {
        imageUrl = value;
      });
      print('wajih ${imageUrl}');
    });
  }

  bool _btnEnabled = false;

  void _handleRadioValueChange1(int value) {
    setState(() {
      reqAvailKey = value;
    });
  }

  // List<bool> ischecked = [
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  // ];
  List<String> companyname = [
    'Cement',
    'Mini Crane ',
    'Spans',
    'RCC pipes',
    'Concrete Pump',
    'Concrete Batching Plant',
    'Transit Mixer for purchase',
    'Tie Rods',
    'RMC- Ready Mix Concrete',
    'Used Old Shuttering Material',
    'Crane on rent',
    'Putty',
    'Ms pipes',
    'Fly ash',
    'Blacks',
  ];

  List<String> stateitems = [
    'Andaman and Nicolar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigrah',
    'Chhattisgrah',
    'Dadra and Nagar Haveli',
    'Daman and Diu',
    'Delhi',
    'jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kenmore',
    'Madhya Pradesh',
    'Maharashtra',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Peschim Medinipur',
    'Pondicherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttarakhand',
    'Vaishali',
    'West Bengal',
    'Aheri',
    'Akola',
    'Akot',
    'Badlapur',
    'Ashti',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Kerala',
    'Lakshadweep',
    'Manipur',
    'Narora',
    'Natwar',
    'Odisha',
    'Utter Pradesh'
  ];

  bool is_on = false;
  List<String> addItemsavailable = [];
  List<String> addItemsRequirements = [];
  List<String> addItemsState = [];

  bool ischeck = false;
  int required = 0;
  int reqAvailKey = 0;
  int priority = 0;
  int Available = 0;
  String? reqAvail;
  String? regUrgent;
  String? gender;
  @override
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contact_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController Responsibilities_controller =
      TextEditingController();

  final TextEditingController requirements_controller = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  var loggedUserName;
  var loggesLastName;
  var loggedMobileNumber;

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => bottomnav())));
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Post Your Requirements'),
          centerTitle: true,
          backgroundColor: AppColors.green,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
            child: Form(
              key: formKey,
              onChanged: () => setState(
                  () => _btnEnabled = formKey.currentState!.validate()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  //image
                  GestureDetector(
                    onTap: () {
                      print('dawd');
                      pickUploadImage();
                    },
                    //if image is null
                    child: Center(
                      child: Container(
                          height: 250.h,
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.orange,
                          ),
                          child: imageUrl == ""
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      'Upload Image',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 80.sp),
                                    )
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Title*',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CutomTextField(
                    maxLines: null,
                    borerColor: Colors.grey,
                    controller: titleController,
                    hintText: 'Enter Your Job Title',
                    inputtype: TextInputType.name,
                    labeltext: '',
                    obsecuretext: false,
                    prefixicon: CupertinoIcons.rectangle_stack_person_crop,
                    validator: (String? value) {
                      RegExp regex = new RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("Enter job title");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                  ),
                  Text(
                    'Required/Available',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  // dropdown_location(),

                  InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: ((BuildContext context) {
                            return AlertDialog(
                              // title: Text('Available or Required'),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Container(
                                    height: 148.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print(reqAvailKey);

                                            setState(() {
                                              reqAvailKey = 1;
                                              reqAvail = 'Required';
                                            });
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Radio(
                                                      activeColor:
                                                          AppColors.orange,
                                                      value: 1,
                                                      groupValue: reqAvailKey,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _handleRadioValueChange1;
                                                          reqAvailKey = 1;
                                                          reqAvail = 'Required';
                                                        });
                                                      }),
                                                  InkWell(
                                                      onTap: () {
                                                        print(reqAvailKey);

                                                        setState(() {
                                                          reqAvailKey = 1;
                                                          reqAvail = 'Required';
                                                        });
                                                      },
                                                      child: Text('Required')),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(reqAvailKey);
                                            setState(() {
                                              reqAvailKey = 2;
                                              reqAvail = 'Available';
                                            });
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Radio(
                                                      activeColor:
                                                          AppColors.orange,
                                                      value: 2,
                                                      groupValue: reqAvailKey,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          reqAvailKey = 2;
                                                          reqAvail =
                                                              'Available';
                                                        });
                                                      }),
                                                  InkWell(
                                                      onTap: () {
                                                        print(reqAvailKey);
                                                        setState(() {
                                                          reqAvailKey = 2;
                                                          reqAvail =
                                                              'Available';
                                                        });
                                                      },
                                                      child: Text('Available')),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Divider(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'cancel',
                                    style: TextStyle(
                                        color: AppColors.green,
                                        fontSize: 80.sp),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'ok',
                                    style: TextStyle(
                                        color: AppColors.green,
                                        fontSize: 80.sp),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      is_on = true;
                                      print('farrukh ${reqAvail}');
                                      // print('hammad  ${reqAvailKey == 1}');
                                      // print('wajih ${context}');
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 50.r),
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            reqAvailKey == 1
                                ? Text('Required')
                                : reqAvailKey == 2
                                    ? Text('Available')
                                    : Text("select"),
                            Icon(
                              CupertinoIcons.chevron_down,
                              size: 18,
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 30.h,
                  ),

                  reqAvailKey == 0
                      ? SizedBox()
                      : reqAvailKey == 1
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Types of Requirements',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 90.sp),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: ((BuildContext context) {
                                            return AlertDialog(
                                              content: StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      void Function(
                                                              void Function())
                                                          setState) {
                                                return Container(
                                                  height: double.infinity,
                                                  width: 8000,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: 50.h,
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(
                                                                            vertical: 0
                                                                                .h),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                          ),
                                                                        ),
                                                                        hintStyle: TextStyle(
                                                                            fontSize: 70
                                                                                .sp),
                                                                        prefixIcon:
                                                                            Icon(Icons
                                                                                .search),
                                                                        hintText:
                                                                            'Search'),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear,
                                                                  color:
                                                                      AppColors
                                                                          .green,
                                                                  size: 30)),
                                                        ],
                                                      ),

                                                      Flexible(
                                                        child: ListView.builder(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: companyname
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                // print(companyname[index]);
                                                                // ischecked[
                                                                //         index] =
                                                                //     !ischecked[
                                                                //         index];
                                                                if (addItemsRequirements
                                                                    .contains(
                                                                        companyname[
                                                                            index])) {
                                                                  setState(() {
                                                                    addItemsRequirements
                                                                        .remove(
                                                                            companyname[index]);
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    addItemsRequirements.add(
                                                                        companyname[
                                                                            index]);
                                                                  });
                                                                }
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Checkbox(
                                                                          activeColor: AppColors
                                                                              .orange,
                                                                          shape:
                                                                              CircleBorder(),
                                                                          value: addItemsRequirements.isEmpty
                                                                              ? false
                                                                              : addItemsRequirements.contains(companyname[index])
                                                                                  ? true
                                                                                  : false,
                                                                          onChanged: (value) {
                                                                            if (addItemsRequirements.contains(companyname[index])) {
                                                                              setState(() {
                                                                                addItemsRequirements.remove(companyname[index]);
                                                                              });
                                                                            } else {
                                                                              setState(() {
                                                                                addItemsRequirements.add(companyname[index]);
                                                                              });
                                                                            }
                                                                            // ischecked[index] =
                                                                            //     value!;

                                                                            print(addItemsRequirements);
                                                                          }),
                                                                      SizedBox(
                                                                        width:
                                                                            20.w,
                                                                      ),
                                                                      Text(
                                                                          companyname[
                                                                              index],
                                                                          style:
                                                                              TextStyle(fontSize: 75.sp)),
                                                                    ],
                                                                  ),
                                                                  // Divider(
                                                                  //   indent: 50,
                                                                  //   thickness: 1,
                                                                  //   color: Colors
                                                                  //       .grey,
                                                                  // ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      // Text('wajih'),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              actions: <Widget>[
                                                //wajih
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: CustomButton(
                                                        input_text: 'CLEAR',
                                                        onpressed: () {
                                                          setState(() {
                                                            addItemsRequirements
                                                                .clear();
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        buttoncolor:
                                                            AppColors.orange,
                                                        textcolor:
                                                            AppColors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100.w,
                                                    ),
                                                    Flexible(
                                                      child: CustomButton(
                                                        input_text: 'OK',
                                                        onpressed: () {
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        buttoncolor:
                                                            AppColors.orange,
                                                        textcolor:
                                                            AppColors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          }));
                                    },
                                    child: addItemsRequirements.isEmpty
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50.r),
                                            height: 60.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('select'),
                                                Icon(
                                                  CupertinoIcons.chevron_down,
                                                  size: 18,
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h,
                                                horizontal: 50.r),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Text(addItemsRequirements
                                                .join('\n')),
                                          )),
                                SizedBox(
                                  height: 20.h,
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Types of Availability',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 90.sp),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             AvailabilityItem()));
                                      showDialog(
                                          context: context,
                                          builder: ((BuildContext context) {
                                            return AlertDialog(
                                              // title: Text('Available or Required'),
                                              content: StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      void Function(
                                                              void Function())
                                                          setState) {
                                                return Container(
                                                  height: double.infinity,
                                                  width: 8000,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: 50.h,
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(
                                                                            vertical: 0
                                                                                .h),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                          ),
                                                                        ),
                                                                        hintStyle: TextStyle(
                                                                            fontSize: 70
                                                                                .sp),
                                                                        prefixIcon:
                                                                            Icon(Icons
                                                                                .search),
                                                                        hintText:
                                                                            'Search'),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear,
                                                                  color:
                                                                      AppColors
                                                                          .green,
                                                                  size: 30)),
                                                        ],
                                                      ),

                                                      Flexible(
                                                        child: ListView.builder(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: companyname
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                // print(companyname[index]);

                                                                if (addItemsavailable
                                                                    .contains(
                                                                        companyname[
                                                                            index])) {
                                                                  setState(() {
                                                                    addItemsavailable
                                                                        .remove(
                                                                            companyname[index]);
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    addItemsavailable.add(
                                                                        companyname[
                                                                            index]);
                                                                  });
                                                                }
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Checkbox(
                                                                          activeColor: AppColors
                                                                              .orange,
                                                                          shape:
                                                                              CircleBorder(),
                                                                          value: addItemsavailable.isEmpty
                                                                              ? false
                                                                              : addItemsavailable.contains(companyname[index])
                                                                                  ? true
                                                                                  : false,
                                                                          onChanged: (value) {
                                                                            if (addItemsavailable.contains(companyname[index])) {
                                                                              setState(() {
                                                                                addItemsavailable.remove(companyname[index]);
                                                                              });
                                                                            } else {
                                                                              setState(() {
                                                                                addItemsavailable.add(companyname[index]);
                                                                              });
                                                                            }
                                                                            // ischecked[index] =
                                                                            //     value!;
                                                                            // print(
                                                                            //     addItemsavailable);
                                                                          }),
                                                                      SizedBox(
                                                                        width:
                                                                            20.w,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          if (addItemsavailable
                                                                              .contains(companyname[index])) {
                                                                            setState(() {
                                                                              addItemsavailable.remove(companyname[index]);
                                                                            });
                                                                          } else {
                                                                            setState(() {
                                                                              addItemsavailable.add(companyname[index]);
                                                                            });
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            companyname[
                                                                                index],
                                                                            style:
                                                                                TextStyle(fontSize: 75.sp)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  // Divider(
                                                                  //   indent: 50,
                                                                  //   thickness: 1,
                                                                  //   color: Colors
                                                                  //       .grey,
                                                                  // ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      // Text('wajih'),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              actions: <Widget>[
                                                //wajih
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: CustomButton(
                                                        input_text: 'CLEAR',
                                                        onpressed: () {
                                                          setState(() {});
                                                          addItemsavailable
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        buttoncolor:
                                                            AppColors.orange,
                                                        textcolor:
                                                            AppColors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100.w,
                                                    ),
                                                    Flexible(
                                                      child: CustomButton(
                                                        input_text: 'OK',
                                                        onpressed: () {
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        buttoncolor:
                                                            AppColors.orange,
                                                        textcolor:
                                                            AppColors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          }));
                                    },
                                    child: addItemsavailable.isEmpty
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50.r),
                                            height: 60.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('select'),
                                                Icon(
                                                  CupertinoIcons.chevron_down,
                                                  size: 18,
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h,
                                                horizontal: 50.r),
                                            // height: 80.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: SingleChildScrollView(
                                              child: Text(
                                                  addItemsavailable.join('\n')),
                                            ),
                                          )),
                                SizedBox(
                                  height: 20.h,
                                )
                              ],
                            ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  Text(
                    'Description',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  JobDescriptionTextfield(
                    borerColor: Colors.grey,
                    controller: descriptionController,
                    hintText: 'Write Job Description',
                    inputtype: TextInputType.multiline,
                    labeltext: '',
                    obsecuretext: false,
                    validator: (String? value) {
                      RegExp regex = new RegExp(r'^.{10,}$');
                      if (value!.isEmpty) {
                        return ("First Name cannot be Empty");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'State*',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => StateItems()));
                        showDialog(
                            context: context,
                            builder: ((BuildContext context) {
                              return AlertDialog(
                                // title: Text('Available or Required'),
                                content: StatefulBuilder(builder: (BuildContext
                                        context,
                                    void Function(void Function()) setState) {
                                  return SizedBox(
                                    height: double.infinity,
                                    width: 8000,
                                    child: Column(
                                      children: [
                                        // Align(
                                        //   alignment: Alignment.topRight,
                                        //   child: IconButton(
                                        //       onPressed: () {
                                        //         Navigator.pop(context);
                                        //       },
                                        //       icon: Icon(Icons.clear,
                                        //           color: AppColors.green,
                                        //           size: 30)),
                                        // ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 50.h,
                                                width: double.infinity,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0.h),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                        ),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          fontSize: 70.sp),
                                                      prefixIcon:
                                                          Icon(Icons.search),
                                                      hintText: 'Search'),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.clear,
                                                    color: AppColors.green,
                                                    size: 30)),
                                          ],
                                        ),
                                        Flexible(
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: stateitems.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  // print(companyname[index]);
                                                  // ischecked[index] =
                                                  //     !ischecked[index];
                                                  setState(() {
                                                    if (addItemsState.contains(
                                                        stateitems[index])) {
                                                      setState(() {
                                                        addItemsState.remove(
                                                            stateitems[index]);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        addItemsState.add(
                                                            stateitems[index]);
                                                      });
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                            activeColor:
                                                                AppColors
                                                                    .orange,
                                                            shape:
                                                                CircleBorder(),
                                                            value: addItemsState
                                                                    .isEmpty
                                                                ? false
                                                                : addItemsState.contains(
                                                                        stateitems[
                                                                            index])
                                                                    ? true
                                                                    : false,
                                                            onChanged: (value) {
                                                              if (addItemsState
                                                                  .contains(
                                                                      stateitems[
                                                                          index])) {
                                                                setState(() {
                                                                  addItemsState.remove(
                                                                      stateitems[
                                                                          index]);
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  addItemsState.add(
                                                                      stateitems[
                                                                          index]);
                                                                });
                                                              }
                                                              // ischecked[index] =
                                                              //     value!;
                                                              print(
                                                                  addItemsState);
                                                            }),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Text(stateitems[index],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    75.sp)),
                                                      ],
                                                    ),
                                                    // Divider(
                                                    //   indent: 50,
                                                    //   thickness: 1,
                                                    //   color: Colors.grey,
                                                    // ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // Text('wajih'),
                                      ],
                                    ),
                                  );
                                }),
                                actions: <Widget>[
                                  //wajih
                                  Row(
                                    children: [
                                      Flexible(
                                        child: CustomButton(
                                          input_text: 'CLEAR',
                                          onpressed: () {
                                            setState(() {
                                              addItemsState.clear();
                                              Navigator.pop(context);

                                              // print(addItemsState);
                                            });
                                            // print(stateitems);
                                            // print(addItemsState);
                                            // addItemsState.isEmpty;
                                            // print("hello world");
                                          },
                                          buttoncolor: AppColors.orange,
                                          textcolor: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100.w,
                                      ),
                                      Flexible(
                                        child: CustomButton(
                                          input_text: 'OK',
                                          onpressed: () {
                                            print('wajih ${addItemsState}');
                                            print('wajih ${reqAvail}');
                                            print('wajih ${reqAvailKey}');
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          buttoncolor: AppColors.orange,
                                          textcolor: AppColors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }));
                      },
                      child: addItemsState.isEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 50.r),
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('select'),
                                  Icon(
                                    CupertinoIcons.chevron_down,
                                    size: 18,
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.w, vertical: 20.h),
                              // height: 80.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.grey)),
                              child: Container(
                                  child: Text(addItemsState.join('\n'))),
                            )),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Contact (Optional)',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CutomTextField(
                    maxLines: null,
                    borerColor: Colors.grey,
                    controller: contact_controller,
                    hintText: 'Enter Your Contact No',
                    inputtype: TextInputType.number,
                    labeltext: '',
                    obsecuretext: false,
                    prefixicon: CupertinoIcons.rectangle_stack_person_crop,
                    validator: (String? value) {
                      // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      // RegExp regExp = RegExp(pattern);
                      // if (value?.length == 0) {
                      //   return 'Please Enter Your mobile number';
                      // } else if (!regExp.hasMatch(value!)) {
                      //   return 'Please enter valid mobile number';
                      // }
                      return null;
                    },
                  ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  Text(
                    'Email*',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CutomTextField(
                    maxLines: null,
                    borerColor: Colors.grey,
                    controller: email_controller,
                    hintText: 'Enter Your Email',
                    inputtype: TextInputType.emailAddress,
                    labeltext: '',
                    obsecuretext: false,
                    prefixicon: CupertinoIcons.rectangle_stack_person_crop,
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
                  Text(
                    'Priority*',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((BuildContext context) {
                            return AlertDialog(
                              // title: Text('Reg or Required'),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Container(
                                    height: 145.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              priority = 1;
                                              regUrgent = 'Regular';
                                            });
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Radio(
                                                    activeColor:
                                                        AppColors.orange,
                                                    value: 1,
                                                    groupValue: priority,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        priority = 1;
                                                        regUrgent = 'Regular';
                                                      });
                                                    }),
                                                InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        priority = 1;
                                                        regUrgent = 'Regular';
                                                      });
                                                    },
                                                    child: Text('Regular')),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              priority = 2;
                                              regUrgent = 'Urgent';
                                            });
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Radio(
                                                    activeColor:
                                                        AppColors.orange,
                                                    value: 2,
                                                    groupValue: priority,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        priority = 2;
                                                        regUrgent = 'Urgent';
                                                      });
                                                    }),
                                                InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        priority = 2;
                                                        regUrgent = 'Urgent';
                                                      });
                                                    },
                                                    child: Text('Urgent')),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'cancel',
                                    style: TextStyle(
                                        color: AppColors.green,
                                        fontSize: 80.sp),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'ok',
                                    style: TextStyle(
                                        color: AppColors.green,
                                        fontSize: 80.sp),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      // is_on = true;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.r),
                      height: 60.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          priority == 1
                              ? Text('Regular')
                              : priority == 2
                                  ? Text('Urgent')
                                  : Text("select"),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // CustomButton(
                  //   input_text: 'Post Now',
                  //   // onpressed: () {
                  //   //   setState(() {
                  //   //     _btnEnabled
                  //   //         ? () => signUp(emailEditingcontroller.text,
                  //   //             passwordeditingcontroller.text)
                  //   //         : null,
                  //   //     submitForm();
                  //   //     setState(() {});
                  //   //   });
                  //   // },
                  //   onpressed: _btnEnabled ? () => submitForm() : null,
                  //   buttoncolor: AppColors.orange,
                  //   textcolor: AppColors.white,
                  // ),
                  CustomButton2(
                      input_btn: 'Post Now',
                      onpressed: _btnEnabled ? () => submitForm() : null,
                      buttoncolor: AppColors.orange,
                      textcolor: AppColors.white),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submitForm() async {
    if (formKey.currentState!.validate()) {
      print(currentUser);
      var collection =
          await FirebaseFirestore.instance.collection('jobs').doc();

      await collection.set({
        'banner': imageUrl,
        'ref_id': currentUser,
        'job_id': collection.id,
        'name': loggedUserName,
        'job_title': titleController.text,
        'req_Avail': reqAvail,
        'add_Items_Requirements':
            reqAvail == 'Required' ? addItemsRequirements : addItemsavailable,
        'job_description': descriptionController.text,
        'add_Items_State': addItemsState,
        'contact': contact_controller.text,
        'email': email_controller.text,
        'reg_Urgent': regUrgent,
        'created_At': DateTime.now()
      }).then((value) {
        titleController.clear();
        descriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Job have been posted')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form: $error')),
        );
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => bottomnav(),
          ));
    }
  }

  fetchUser() {
    var docRef = FirebaseFirestore.instance
        .collection('users/')
        .doc(currentUser)
        .snapshots();
    docRef.first.then((value) {
      loggedUserName = value['firstname'];
      loggesLastName = value['Lastname'];
      loggedMobileNumber = value['mobilenumber'];
      // email = value['email'];
    });
  }
}

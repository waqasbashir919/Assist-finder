// import 'package:asist_finder/Tabs_home_Screen/availability_item.dart';
// import 'package:asist_finder/Tabs_home_Screen/requirements_items.dart';
// import 'package:asist_finder/Tabs_home_Screen/state_items.dart';
import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav.dart';
import 'package:asist_finder/Bottom%20Navigation%20bar.dart/bottom_nav_2.dart';
import 'package:asist_finder/Tabs_home_Screen/tabs_home.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/job_description_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class filterScreen extends StatefulWidget {
  static void fetchJobss() async {
    List jobs = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var usersCollection =
        firestore.collection('jobs').orderBy('created_At', descending: true);
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    documents.forEach((doc) {
      jobs.add(doc.data());
    });

    // isLoading = false;
  }

  static final searchfilter = TextEditingController();

  static void searchfromfirebase(String query, String search_result) async {
    final result = await FirebaseFirestore.instance
        .collection('jobs')
        .where('job_title', arrayContains: query)
        .get();
    // setState(() {
    //   SearchResult = result.docs.map((e) => e.data()).toList();
    // });
  }

  filterScreen({Key? key}) : super(key: key);

  @override
  _filterScreenState createState() => _filterScreenState();
}

class _filterScreenState extends State<filterScreen> {
  List allResult = [];
  List resultList = [];
  final TextEditingController searchcon = TextEditingController();

  static void searchfromfirebase(String query, String search_result) async {
    final result = await FirebaseFirestore.instance
        .collection('jobs')
        .where('job_title', arrayContains: query)
        .get();
  }

  bool isSearch = false;
  List? allJobs;

  TextEditingController searchController = TextEditingController();

  bool isLoadings = false;
  List SearchResult = [];
  bool isChecked_contactno = false;
  bool isChecked_emailidno = false;

  void _handleRadioValueChange1(int value) {
    setState(() {
      reqAvailKey = value;
    });
  }

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
    getSearchPref();
  }

  bool isLoading = false;
  List? apiJobs;

  var loggedUserName;
  Map<String, dynamic>? userMap;

  final TextEditingController _search = TextEditingController();
  void onSearch() async {
    FirebaseFirestore _firstore = FirebaseFirestore.instance;

    setState(() {
      isLoadings = true;
    });

    await _firstore
        .collection('jobs')
        .where('job_title', arrayContains: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoadings = false;
      });
      print('wajih ${userMap}');
    });
  }

  ///search filter page variables
  bool? isFilterPage;
  String? searchKeywork, searchReqAvail, searchRegUrgent;
  List? searchAddItemsavailable,
      searchAddItemsRequirements,
      searchAddItemsState;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advance Search'),
        centerTitle: true,
        backgroundColor: AppColors.green,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                (isFilterPage == false || isFilterPage == null)
                    ? SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.remove('isFilterPage');
                            prefs.remove('searchKeyword');
                            prefs.remove('reqAvail');
                            prefs.remove('addItemsavailable');
                            prefs.remove('addItemsRequirements');
                            prefs.remove('addItemsState');
                            prefs.remove('regUrgent');

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Filter have been set')),
                            );
                            setState(() {});
                          },
                          child: Text('Clear filter'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green),
                        ),
                      ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Flexible(
                        child: isLoadings
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                height: 52.h,
                                child: TextFormField(
                                  controller: reqAvailKey == 1
                                      ? searchController
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: 'Search keyword',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.h,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide:
                                            BorderSide(color: AppColors.green)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide:
                                            BorderSide(color: Colors.teal)),
                                  ),
                                ),
                              )),
                  ],
                ),
                userMap != null
                    ? ListTile(
                        title: Text(userMap!['job_title']),
                        subtitle: Text(userMap!['job_description']),
                      )
                    : Container(),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Required/Available*',
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
                                'Types of Requirement',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 70.sp),
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
                                                            width:
                                                                double.infinity,
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
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
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
                                                                color: AppColors
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
                                                        itemCount:
                                                            companyname.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              if (addItemsRequirements
                                                                  .contains(
                                                                      companyname[
                                                                          index])) {
                                                                setState(() {
                                                                  addItemsRequirements.remove(
                                                                      companyname[
                                                                          index]);
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
                                                                        activeColor:
                                                                            AppColors
                                                                                .orange,
                                                                        shape:
                                                                            CircleBorder(),
                                                                        value: addItemsRequirements
                                                                                .isEmpty
                                                                            ? false
                                                                            : addItemsRequirements.contains(companyname[
                                                                                    index])
                                                                                ? true
                                                                                : false,
                                                                        onChanged:
                                                                            (value) {
                                                                          if (addItemsRequirements
                                                                              .contains(companyname[index])) {
                                                                            setState(() {
                                                                              addItemsRequirements.remove(companyname[index]);
                                                                            });
                                                                          } else {
                                                                            setState(() {
                                                                              addItemsRequirements.add(companyname[index]);
                                                                            });
                                                                          }
                                                                        }),
                                                                    SizedBox(
                                                                      width:
                                                                          20.w,
                                                                    ),
                                                                    Text(
                                                                        companyname[
                                                                            index],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                75.sp)),
                                                                  ],
                                                                ),
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
                                                        addItemsRequirements
                                                            .clear();
                                                        Navigator.pop(context);
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

                                                        Navigator.pop(context);
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
                                              vertical: 20.h, horizontal: 50.r),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Text(
                                              addItemsRequirements.join('\n')),
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
                                    fontSize: 70.sp),
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
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: Icon(
                                                              Icons.clear,
                                                              color: AppColors
                                                                  .green,
                                                              size: 30)),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 50.h,
                                                            width:
                                                                double.infinity,
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
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                        ),
                                                                      ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
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
                                                                color: AppColors
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
                                                        itemCount:
                                                            companyname.length,
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
                                                                  addItemsavailable.remove(
                                                                      companyname[
                                                                          index]);
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
                                                                        activeColor:
                                                                            AppColors
                                                                                .orange,
                                                                        shape:
                                                                            CircleBorder(),
                                                                        value: addItemsavailable
                                                                                .isEmpty
                                                                            ? false
                                                                            : addItemsavailable.contains(companyname[
                                                                                    index])
                                                                                ? true
                                                                                : false,
                                                                        onChanged:
                                                                            (value) {
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
                                                                          setState(
                                                                              () {
                                                                            addItemsavailable.remove(companyname[index]);
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
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
                                                        Navigator.pop(context);
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
                                                        Navigator.pop(context);
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
                                              vertical: 20.h, horizontal: 50.r),
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
                              content: StatefulBuilder(builder:
                                  (BuildContext context,
                                      void Function(void Function()) setState) {
                                return SizedBox(
                                  height: double.infinity,
                                  width: 8000,
                                  child: Column(
                                    children: [
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
                                                              AppColors.orange,
                                                          shape: CircleBorder(),
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
                                                          }),
                                                      SizedBox(
                                                        width: 20.w,
                                                      ),
                                                      Text(stateitems[index],
                                                          style: TextStyle(
                                                              fontSize: 75.sp)),
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
                                          setState(() {});
                                          addItemsState.clear();
                                          Navigator.pop(context);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                // SizedBox(
                //   height: 5.h,
                // ),

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
                                                  activeColor: AppColors.orange,
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
                                                  activeColor: AppColors.orange,
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

                CustomButton(
                  input_text: 'Search Now',
                  onpressed: () {
                    print('${searchController.text}');
                    print('${reqAvail}');
                    print('${addItemsavailable}');
                    print('${addItemsRequirements}');
                    print('${addItemsState}');
                    print('${regUrgent}');
                    Center(child: CircularProgressIndicator());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => bottomnav()));
                    saveSearchPref();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Filter have been set')),
                    );
                  },
                  buttoncolor: AppColors.orange,
                  textcolor: AppColors.white,
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//hello
  void filterSearchResults(String query) {
    if (query == '') {
      setState(() {
        allJobs = apiJobs;
      });
    } else {
      print(query);
      setState(() {
        List searchList = apiJobs!.where((job) {
          return job['job_title'].toLowerCase().contains(query.toLowerCase()) ||
              job['job_description']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              job['req_Avail'].toLowerCase().contains(query.toLowerCase()) ||
              job['add_Items_State']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              job['reg_Urgent'].toLowerCase().contains(query.toLowerCase());
        }).toList();
        allJobs = searchList;
        // filteredItems.clear();
        // filteredItems.addAll(searchList);
      });
    }
  }

  void saveSearchPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isFilterPage', true);
    prefs.setString('searchKeyword', searchController.text);
    prefs.setString('reqAvail', reqAvail!);
    prefs.setStringList('addItemsavailable', addItemsavailable);
    prefs.setStringList('addItemsRequirements', addItemsRequirements);
    prefs.setStringList('addItemsState', addItemsState);
    prefs.setString('regUrgent', regUrgent!);
  }

  void getSearchPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isFilterPage = prefs.getBool('isFilterPage');
    if (isFilterPage == true) {
      setState(() {
        searchKeywork = prefs.getString('searchKeyword');
        searchReqAvail = prefs.getString('reqAvail');
        searchAddItemsavailable = prefs.getStringList('addItemsavailable');
        searchAddItemsRequirements =
            prefs.getStringList('addItemsRequirements');
        searchAddItemsState = prefs.getStringList('addItemsState');
        searchRegUrgent = prefs.getString('regUrgent');
        searchAddItemsavailable == null
            ? null
            : searchAddItemsavailable!.isNotEmpty
                ? print('sharedPref : $searchAddItemsavailable')
                : null;
        searchAddItemsRequirements == null
            ? null
            : searchAddItemsRequirements!.isNotEmpty
                ? print('sharedPref : $searchAddItemsRequirements')
                : null;
      });
      searchController.text = searchKeywork!;

      if (searchReqAvail == 'Required') {
        reqAvail = 'Required';
        reqAvailKey = 1;
        addItemsRequirements = searchAddItemsRequirements as List<String>;
      } else {
        reqAvail = 'Available';
        reqAvailKey = 2;
        addItemsavailable = searchAddItemsavailable as List<String>;
      }
      addItemsState = searchAddItemsState as List<String>;

      if (searchRegUrgent == 'Regular') {
        priority = 1;
        regUrgent = 'Regular';
      } else {
        priority = 2;
        regUrgent = 'Urgent';
      }
    }
  }
}

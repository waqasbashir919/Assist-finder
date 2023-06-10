import 'package:asist_finder/Filter/filter_screen.dart';
import 'package:asist_finder/Login%20Screen/login_screen.dart';
import 'package:asist_finder/Provider/Include%20Details/include_details.dart';
import 'package:asist_finder/Provider/Provide%20Basic%20Information/provide_basic_info.dart';
import 'package:asist_finder/Tabs_home_Screen/more_details.dart';
import 'package:asist_finder/Tabs_home_Screen/post_your_requirements.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:asist_finder/homescreen.dart';
import 'package:asist_finder/widgets/custom_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Requirements/requirements.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabsHome extends StatefulWidget {
  TextEditingController? searchfilr;
  TabsHome({Key? key, this.searchfilr}) : super(key: key);

  @override
  _TabsHomeState createState() => _TabsHomeState();
}

class _TabsHomeState extends State<TabsHome> {
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List? allJobs;
  List? apiJobs;
  bool isSearch = false;

  bool isLoading = false;
  var currentUser;
  List filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchJobs();
    currentUser = FirebaseAuth.instance.currentUser!.uid;
  }

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
                  .contains(query.toLowerCase());
        }).toList();
        allJobs = searchList;
        // filteredItems.clear();
        // filteredItems.addAll(searchList);
      });
    }
  }

  ///search filter page variables
  bool? isFilterPage;
  String? searchKeywork, searchReqAvail, searchRegUrgent;
  List? searchAddItemsavailable,
      searchAddItemsRequirements,
      searchAddItemsState;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.orange,
              // backgroundColor: Colors.transparent,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              toolbarHeight: 255.h,
              flexibleSpace: Container(
                // height: 50,
                color: const Color.fromARGB(255, 212, 212, 212),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              color: Colors.white,
                              height: 50.h,
                              child: TextFormField(
                                autofocus: false,
                                controller: searchController,
                                onChanged: (value) {
                                  if (searchController.text.isEmpty) {
                                    setState(() {
                                      isSearch = false;
                                    });
                                  } else {
                                    setState(() {
                                      isSearch = true;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 35.w, bottom: 20.h),
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: isSearch == false
                                        ? null
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                searchController.text = '';
                                              });
                                              filterSearchResults(
                                                  searchController.text);
                                              setState(() {
                                                isSearch == false;
                                              });
                                            },
                                            child: Icon(Icons.clear)),
                                    hintText: 'Search Now',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.7))),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.orange),
                                onPressed: () {
                                  filterSearchResults(searchController.text);
                                },
                                child: Icon(Icons.search)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: CarouselSlider(
                          items: [
                            InkWell(
                              onTap: () {
                                launch(
                                    'https://www.youtube.com/watch?v=2rJvE1jcjlk');
                              },
                              child: Text(
                                'Restart tha App if it hangs or remain blank',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.green,
                                    color: Colors.black54,
                                    fontSize: 80.sp),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  launch(
                                      'https://www.youtube.com/watch?v=PxgFKO-n30A');
                                },
                                child: Text(
                                  'Disclaimer: Dont give advance to anyone',
                                  style: TextStyle(
                                    decorationColor: AppColors.green,
                                    decoration: TextDecoration.underline,
                                    fontSize: 80.sp,
                                    color: Colors.black54,
                                  ),
                                )),
                            InkWell(
                                onTap: () {
                                  launch(
                                      'https://www.youtube.com/watch?v=AZa0MwFLCEs');
                                },
                                child: Text(
                                  'For customer care click here to Whatapp',
                                  style: TextStyle(
                                    decorationColor: AppColors.green,
                                    decoration: TextDecoration.underline,
                                    fontSize: 80.sp,
                                    color: Colors.black54,
                                  ),
                                )),
                          ],
                          options: CarouselOptions(
                            viewportFraction: 1,
                            aspectRatio: 16 / 9,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            height: 30,
                          )),
                    ),
                    Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                      ),
                      child: TabBar(
                        labelColor: Colors.white,
                        indicator: BoxDecoration(
                          color: AppColors.green,
                        ),
                        unselectedLabelColor: Colors.white,
                        tabs: [
                          //first tab
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 55,
                              ),
                              Text(
                                'Requirements',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 55.sp),
                              ),
                              // Tab(text: 'Requirements',icon: Icon(Icons.person),),
                            ],
                          ),
                          //second tab
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fire_truck_outlined,
                                size: 55,
                              ),

                              Text(
                                'Available',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 55.sp),
                              ),
                              // Tab(text: 'Requirements',icon: Icon(Icons.person),),
                            ],
                          ),
                          //  third tab
                          InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PostYourRequirements()));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             PostYourRequirements()));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 55,
                                ),
                                Text(
                                  'Post your Requirements',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 55.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                //
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: padding.padding80.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Requirements',
                              style: TextStyle(
                                  fontSize: 80.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          (isFilterPage == false || isFilterPage == null)
                              ? SizedBox()
                              : GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    prefs.remove('isFilterPage');
                                    prefs.remove('searchKeyword');
                                    prefs.remove('reqAvail');
                                    prefs.remove('addItemsavailable');
                                    prefs.remove('addItemsRequirements');
                                    prefs.remove('addItemsState');
                                    prefs.remove('regUrgent');
                                    fetchJobs();
                                    setState(() {});
                                  },
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Clear filter',
                                      style: TextStyle(
                                          fontSize: 80.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      isLoading == true
                          ? CircularProgressIndicator(
                              color: AppColors.green,
                            )
                          : Expanded(
                              child: RefreshIndicator(
                                color: AppColors.green,
                                onRefresh: () async {
                                  fetchJobs();
                                },
                                child: ListView.builder(
                                  itemCount: allJobs!.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final job = allJobs![index];
                                    print('my job: $allJobs');

                                    var date =
                                        DateFormat('yyyy-MMMM-dd hh:mm:a')
                                            .format(allJobs![index]
                                                    ['created_At']
                                                .toDate());

                                    if (allJobs![index]['req_Avail'] ==
                                        'Required') {
                                      return Card(
                                        child: Container(
                                          width: double.infinity,
                                          // height: 220.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(18.r),
                                                topRight: Radius.circular(18.r),
                                              ),
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 40.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        allJobs![index][
                                                                    'reg_Urgent'] ==
                                                                'Urgent'
                                                            ? Icon(
                                                                Icons
                                                                    .info_outline,
                                                                color:
                                                                    Colors.red,
                                                                size: 20,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .pentagon_outlined,
                                                                color: AppColors
                                                                    .green,
                                                                size: 20,
                                                              ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Text(
                                                          '${allJobs![index]['job_title']}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                        height: 300.h,
                                                        width:
                                                            double.infinity.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: allJobs![index][
                                                                    'banner'] ==
                                                                null
                                                            ? Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .camera,
                                                                    color: AppColors
                                                                        .green,
                                                                    size: 40,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        10.h,
                                                                  ),
                                                                ],
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image(
                                                                  image: NetworkImage(
                                                                      allJobs![
                                                                              index]
                                                                          [
                                                                          'banner']),
                                                                  // fit: BoxFit
                                                                  //     .cover,
                                                                ),
                                                              )),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      '${allJobs![index]['req_Avail']} Details: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      '${allJobs![index]['add_Items_Requirements'].join(', ')}',
                                                      style: TextStyle(),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Description: ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                width: 960.w,
                                                                child: Text(
                                                                  '${allJobs![index]['job_description']}',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.red,
                                                        ),
                                                        Text(
                                                          '${allJobs![index]['add_Items_State'].join(' , ')}',
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(CupertinoIcons
                                                            .timer),
                                                        SizedBox(
                                                          width: 5.h,
                                                        ),
                                                        Text(
                                                          '${date} ',
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MoreDetails(
                                                                  job: allJobs![
                                                                      index])));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.orange),
                                                  width: double.infinity,
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'More Details',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 75.sp),
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        color: AppColors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                //Available
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: padding.padding80.w),
                  child: Column(
                    // scrollDirection: Axis.vertical,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Available',
                              style: TextStyle(
                                  fontSize: 80.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          (isFilterPage == false || isFilterPage == null)
                              ? SizedBox()
                              : GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    prefs.remove('isFilterPage');
                                    prefs.remove('searchKeyword');
                                    prefs.remove('reqAvail');
                                    prefs.remove('addItemsavailable');
                                    prefs.remove('addItemsRequirements');
                                    prefs.remove('addItemsState');
                                    prefs.remove('regUrgent');
                                    fetchJobs();
                                    setState(() {});
                                  },
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Clear filter',
                                      style: TextStyle(
                                          fontSize: 80.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // DefaultTabController(
                      //   length: 3,
                      //   initialIndex: 0,
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         height: 130.h,
                      //         decoration: BoxDecoration(
                      //           color: AppColors.orange,
                      //         ),
                      //         child: TabBar(
                      //             labelColor: Colors.white,
                      //             indicator: BoxDecoration(
                      //               color: AppColors.green,
                      //             ),
                      //             unselectedLabelColor: Colors.white,
                      //             tabs: [
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.stretch,
                      //                 children: [
                      //                   Icon(
                      //                     Icons.person,
                      //                     size: 55,
                      //                   ),

                      //                   Text(
                      //                     'Requirements',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(fontSize: 55.sp),
                      //                   ),
                      //                   // Tab(text: 'Requirements',icon: Icon(Icons.person),),
                      //                 ],
                      //               ),
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 children: [
                      //                   Icon(
                      //                     Icons.fire_truck_outlined,
                      //                     size: 55,
                      //                   ),
                      //                   Text(
                      //                     'Available',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(fontSize: 55.sp),
                      //                   ),
                      //                   // Tab(text: 'Requirements',icon: Icon(Icons.person),),
                      //                 ],
                      //               ),
                      //               Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 children: [
                      //                   Icon(
                      //                     Icons.add_circle_outline_rounded,
                      //                     size: 55,
                      //                   ),

                      //                   Text(
                      //                     'Post your Requiremtns',
                      //                     maxLines: 2,
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(fontSize: 55.sp),
                      //                   ),
                      //                   // Tab(text: 'Requirements',icon: Icon(Icons.person),),
                      //                 ],
                      //               ),
                      //             ]),
                      //       ),
                      //       // Container(
                      //       //   height: 200.h,
                      //       //   child: TabBarView(children: [
                      //       //     // Center(child: Text('wajih')),
                      //       //     Center(child: Text('wagas')),
                      //       //     Center(child: Text('Hello world')),
                      //       //   ]),
                      //       // )
                      //     ],
                      //   ),
                      // ),

                      //
                      isLoading == true
                          ? CircularProgressIndicator(
                              color: AppColors.green,
                            )
                          : Expanded(
                              child: RefreshIndicator(
                                color: AppColors.green,
                                onRefresh: () async {
                                  fetchJobs();
                                },
                                child: ListView.builder(
                                  itemCount: allJobs!.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final job = allJobs![index];

                                    var date =
                                        DateFormat('yyyy-MMMM-dd hh:mm:a')
                                            .format(allJobs![index]
                                                    ['created_At']
                                                .toDate());

                                    if (allJobs![index]['req_Avail'] ==
                                        'Available') {
                                      return Card(
                                        child: Container(
                                          width: double.infinity,
                                          // height: 220.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(18.r),
                                                topRight: Radius.circular(18.r),
                                              ),
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 40.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        allJobs![index][
                                                                    'reg_Urgent'] ==
                                                                'Urgent'
                                                            ? Icon(
                                                                Icons
                                                                    .info_outline,
                                                                color:
                                                                    Colors.red,
                                                                size: 20,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .pentagon_outlined,
                                                                color: AppColors
                                                                    .green,
                                                                size: 20,
                                                              ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Text(
                                                          '${allJobs![index]['job_title']}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Container(
                                                        height: 300.h,
                                                        width:
                                                            double.infinity.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: allJobs![index][
                                                                    'banner'] ==
                                                                null
                                                            ? Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .camera,
                                                                    color: AppColors
                                                                        .green,
                                                                    size: 40,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        10.h,
                                                                  ),
                                                                ],
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image(
                                                                  image: NetworkImage(
                                                                      allJobs![
                                                                              index]
                                                                          [
                                                                          'banner']),
                                                                  // fit: BoxFit
                                                                  //     .fill,
                                                                ),
                                                              )),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      '${allJobs![index]['req_Avail']} Details: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      '${allJobs![index]['add_Items_Requirements'].join(', ')}',
                                                      style: TextStyle(),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Description: ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                width: 960.w,
                                                                child: Text(
                                                                  '${allJobs![index]['job_description']}',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.red,
                                                        ),
                                                        Text(
                                                          '${allJobs![index]['add_Items_State'].join(' , ')}',
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(CupertinoIcons
                                                            .timer),
                                                        SizedBox(
                                                          width: 5.h,
                                                        ),
                                                        Text(
                                                          '${date} ',
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MoreDetails(
                                                                  job: allJobs![
                                                                      index])));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.orange),
                                                  width: double.infinity,
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'More Details',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 75.sp),
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        color: AppColors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                // Center(child: Text('data')),

                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: PostYourRequirements()),
              ],
            )),
      ),
    );
  }

  // void searchdata() async {
  //   filterScreen.searchfromfirebase();
  //   }
  void fetchJobs() async {
    setState(() {
      isLoading = true;
    });

    List jobs = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var usersCollection =
        firestore.collection('jobs').orderBy('created_At', descending: true);
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    documents.forEach((doc) {
      jobs.add(doc.data());
    });
    setState(() {
      apiJobs = jobs;
      allJobs = jobs;
    });

    getSearchPref();
    setState(() {
      isLoading = false;
    });
  }

  void getSearchPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isFilterPage = prefs.getBool('isFilterPage');
    searchKeywork = prefs.getString('searchKeyword');
    searchReqAvail = prefs.getString('reqAvail');
    searchAddItemsavailable = prefs.getStringList('addItemsavailable');
    searchAddItemsRequirements = prefs.getStringList('addItemsRequirements');
    searchAddItemsState = prefs.getStringList('addItemsState');
    searchRegUrgent = prefs.getString('regUrgent');

    // print('sharedPref : $isFilterPage');
    // print('sharedPref : $searchKeywork');
    // print('searchReqAvail : $searchReqAvail');
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
    print('sharedPref : $searchAddItemsState');
    print('sharedPref : $searchRegUrgent');

    if (isFilterPage == true) {
      filterSearchPage(searchKeywork, searchReqAvail, searchAddItemsavailable,
          searchAddItemsRequirements, searchAddItemsState, searchRegUrgent);
    }
  }

  void filterSearchPage(
      String? searchKeywork,
      String? searchReqAvail,
      List? searchAddItemsavailable,
      List? searchAddItemsRequirements,
      List? searchAddItemsState,
      String? searchRegUrgent) {
    // List searchList = [];
    List searchList = apiJobs!.where((job) {
      searchAddItemsRequirements!.map((item) => item.toLowerCase()).toList();
      return ((job['job_title']
              .toLowerCase()
              .contains(searchKeywork!.toLowerCase())) &&
          (job['req_Avail']
                  .toLowerCase()
                  .contains(searchReqAvail!.toLowerCase()) &&
              job['reg_Urgent']
                  .toLowerCase()
                  .contains(searchRegUrgent!.toLowerCase())));
    }).toList();

    setState(() {
      allJobs = searchList;
    });

    // for (var i = 0; i < apiJobs!.length; i++) {
    //   if (apiJobs![i]['job_title'].toLowerCase() ==
    //           searchKeywork!.toLowerCase() &&
    //       apiJobs![i]['req_Avail'].toLowerCase() ==
    //           searchReqAvail!.toLowerCase() &&
    //       apiJobs![i]['reg_Urgent'].toLowerCase() ==
    //           searchRegUrgent!.toLowerCase()) {
    //     searchList.add(apiJobs![i]);
    //   }
    // }
    // setState(() {
    //   allJobs = searchList;
    // });
    // print('hey:${searchList}');
  }
}

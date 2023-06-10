import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_text_field.dart';

class Requirements extends StatefulWidget {
  const Requirements({Key? key}) : super(key: key);

  @override
  _RequirementsState createState() => _RequirementsState();
}

class _RequirementsState extends State<Requirements> {
  List? allJobs;
  List? apiJobs;

  bool isLoading = false;
  var currentUser;
  List filteredItems = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!.uid;
    fetchJobs();
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
          return job['title'].toLowerCase().contains(query.toLowerCase()) ||
              job['description'].toLowerCase().contains(query.toLowerCase());
        }).toList();
        allJobs = searchList;
        // filteredItems.clear();
        // filteredItems.addAll(searchList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        //   automaticallyImplyLeading: false,
        //   toolbarHeight: 50.h,
        //   flexibleSpace: Container(
        //     color: Colors.grey.withOpacity(0.2),
        //     child: Row(
        //       children: [
        //         Flexible(
        //           child: TextField(
        //             decoration: InputDecoration(
        //                 enabledBorder: OutlineInputBorder(
        //                   borderSide: BorderSide(
        //                       width: 3, color: Colors.black), //<-- SEE HERE
        //                 ),
        //                 focusedBorder: InputBorder.none,
        //                 prefixIcon: Icon(Icons.search),
        //                 hintText: 'Search Now',
        //                 hintStyle:
        //                     TextStyle(color: Colors.grey.withOpacity(0.7))),
        //           ),
        //         ),
        //         ElevatedButton(
        //             style: ElevatedButton.styleFrom(primary: AppColors.orange),
        //             onPressed: () {},
        //             child: Icon(Icons.search))
        //       ],
        //     ),
        //   ),
        // ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
            child: Column(
              // scrollDirection: Axis.vertical,
              // physics: NeverScrollableScrollPhysics(),
              children: [
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
                        child: ListView.builder(
                          itemCount: allJobs!.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final job = allJobs![index];

                            if (job['ref_id'] == currentUser) {
                              return SizedBox();
                            } else {
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
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 40.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.join_full,
                                              color: AppColors.green,
                                            ),
                                            SizedBox(
                                              width: 10.h,
                                            ),
                                            Text('Job title: ${job['title']}'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.join_full,
                                              color: AppColors.green,
                                            ),
                                            SizedBox(
                                              width: 10.h,
                                            ),
                                            Text(
                                                'Job description: ${job['description']}'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Requirement Details: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'RCC, Waterproofing, Gypsum Plaster , Tiling ',
                                          style: TextStyle(),
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
                                              'Amarpur , Ara',
                                              style: TextStyle(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(CupertinoIcons.timer),
                                            SizedBox(
                                              width: 5.h,
                                            ),
                                            Text(
                                              '13 Nov 2023 01:00AM',
                                              style: TextStyle(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // CutomTextField(
                //   inputtype: TextInputType.name,
                //   hintText: 'Job Search',
                //   borerColor: Colors.grey,
                //   labeltext: '',
                //   obsecuretext: false,
                //   prefixicon: Icons.search,
                //   controller: jobsearchcontroller,
                //   validator: (String? value) {
                //     return null;
                //   },
                // ),
                // Flexible(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           height: 10.h,
                //         ),
                //         SizedBox(
                //           height: 30.h,
                //         ),
                //         Align(
                //             alignment: Alignment.topLeft,
                //             child: Text(
                //               'Contractor Requirements',
                //               style: TextStyle(
                //                   fontWeight: FontWeight.bold, fontSize: 80.sp),
                //             )),
                //         SizedBox(
                //           height: 20.h,
                //         ),
                //         ListView.separated(
                //           scrollDirection: Axis.vertical,
                //           padding: EdgeInsets.only(bottom: 10),
                //           physics: BouncingScrollPhysics(),
                //           itemCount: 10,
                //           shrinkWrap: true,
                //           itemBuilder: (context, index) {
                //             return Column(
                //               children: [
                //                 Container(
                //                   width: double.infinity,
                //                   height: 220.h,
                //                   decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.only(
                //                         topLeft: Radius.circular(18.r),
                //                         topRight: Radius.circular(18.r),
                //                       ),
                //                       color: Colors.white),
                //                   child: Padding(
                //                     padding: EdgeInsets.only(left: 40.w),
                //                     child: Column(
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       children: [
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             Icon(
                //                               Icons.join_full,
                //                               color: AppColors.green,
                //                             ),
                //                             SizedBox(
                //                               width: 10.h,
                //                             ),
                //                             Text('Contractor'),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Text(
                //                           'Requirement Details: ',
                //                           style:
                //                               TextStyle(fontWeight: FontWeight.w500),
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Text(
                //                           'RCC, Waterproofing, Gypsum Plaster , Tiling ',
                //                           style: TextStyle(),
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             Icon(
                //                               Icons.location_on,
                //                               color: Colors.red,
                //                             ),
                //                             Text(
                //                               'Amarpur , Ara',
                //                               style: TextStyle(),
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             Icon(CupertinoIcons.timer),
                //                             SizedBox(
                //                               width: 5.h,
                //                             ),
                //                             Text(
                //                               '13 Nov 2023 01:00AM',
                //                               style: TextStyle(),
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 Container(
                //                   width: double.infinity,
                //                   height: 80.h,
                //                   decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.only(
                //                         bottomLeft: Radius.circular(18.r),
                //                         bottomRight: Radius.circular(18.r),
                //                       ),
                //                       color: AppColors.orange),
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                     children: [
                //                       Container(
                //                         child: Row(
                //                           children: [
                //                             Text(
                //                               'View Details',
                //                               style: TextStyle(color: Colors.white),
                //                             ),
                //                             SizedBox(
                //                               width: 10.h,
                //                             ),
                //                             Icon(
                //                               Icons.add,
                //                               color: Colors.white,
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                       Container(
                //                         child: Row(
                //                           children: [
                //                             Text(
                //                               'Chat Now',
                //                               style: TextStyle(color: Colors.white),
                //                             ),
                //                             SizedBox(
                //                               width: 10.h,
                //                             ),
                //                             Icon(
                //                               CupertinoIcons.chat_bubble_2,
                //                               color: Colors.white,
                //                             )
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             );
                //           },
                //           separatorBuilder: (BuildContext context, int index) =>
                //               SizedBox(
                //             height: 15.h,
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchJobs() async {
    setState(() {
      isLoading = true;
    });
    List jobs = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('jobs');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    documents.forEach((doc) {
      jobs.add(doc.data());
    });
    setState(() {
      if (mounted) {
        allJobs = jobs;
      }
    });
    setState(() {
      isLoading = false;
    });
  }
}

import 'package:asist_finder/const/appColors..dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Mypost extends StatefulWidget {
  const Mypost({Key? key}) : super(key: key);

  @override
  _MypostState createState() => _MypostState();
}

class _MypostState extends State<Mypost> {
  List? allJobs;
  bool isLoading = false;
  var currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!.uid;
    fetchJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My jobs'),
        // automaticallyImplyLeading: true,
        backgroundColor: AppColors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   height: 70.h,
            //   color: Color.fromARGB(255, 223, 223, 223),
            //   child: Row(
            //     children: [
            //       IconButton(
            //           onPressed: () {
            //             Navigator.pop(context);
            //           },
            //           icon: Icon(Icons.arrow_back_ios_rounded)),
            //       Align(alignment: Alignment.center, child: Text('My Jobs')),
            //     ],
            //   ),
            // ),
            isLoading == true
                ? Center(child: CircularProgressIndicator())
                : Flexible(
                    child: ListView.builder(
                        itemCount: allJobs!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          var job = allJobs![index];
                          var date = DateFormat('yyyy-MMMM-dd hh:mm:a')
                              .format(job['created_At'].toDate());

                          if (job['ref_id'] == currentUser) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 50.w),
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 65.w, vertical: 20.h),
                                      width: double.infinity,
                                      // height: 500.h,
                                      // decoration: BoxDecoration(
                                      //     // color: Colors.red,
                                      //     border: Border.all(color: Colors.grey)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            job['reg_Urgent'],
                                            style: TextStyle(
                                              fontSize: 80.sp,
                                              color: AppColors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            'Requirements Details',
                                            style: TextStyle(
                                              fontSize: 80.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text(
                                            'Workers',
                                            style: TextStyle(
                                                color: AppColors.green),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Quantity: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                job['job_description'],
                                              ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '${job['add_Items_State'].join(' , ')}',
                                              ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.clock,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Expanded(child: Text('$date')),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Posted by: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                job['name'],
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Email by: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                job['email'],
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Contact by: ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    job['contact'],
                                                  )
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      'tel:${job['contact']}');
                                                },
                                                child: CircleAvatar(
                                                  radius: 80.r,
                                                  backgroundColor:
                                                      AppColors.green,
                                                  child: Icon(
                                                    Icons.phone,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        })),
          ],
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
    var usersCollection =
        firestore.collection('jobs').orderBy('created_At', descending: true);
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    documents.forEach((doc) {
      jobs.add(doc.data());
    });
    setState(() {
      allJobs = jobs;
    });
    setState(() {
      isLoading = false;
    });
  }
}

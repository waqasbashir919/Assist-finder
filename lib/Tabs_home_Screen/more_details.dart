import 'package:asist_finder/Chat%20Screen/chat_details.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class MoreDetails extends StatefulWidget {
  final dynamic job;
  const MoreDetails({Key? key, this.job}) : super(key: key);

  @override
  _MoreDetailsState createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  var currentUser = FirebaseAuth.instance.currentUser!.uid;
  var loggedUserName;
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  var selectedJob, date;
  @override
  Widget build(BuildContext context) {
    selectedJob = widget.job;
    date = DateFormat('yyyy-MMMM-dd hh:mm:a')
        .format(selectedJob['created_At'].toDate());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Position'),
        backgroundColor: AppColors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 120.w),
              height: 70.h,
              color: Color.fromARGB(255, 231, 231, 231),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${selectedJob['req_Avail']}',
                    style:
                        TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'Urgent',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 70.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pentagon_outlined,
                              color: AppColors.green,
                              size: 20,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'Regular',
                              style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 70.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
                child: SingleChildScrollView(
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 50.w),
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
                                        Row(
                                          children: [
                                            selectedJob['reg_Urgent'] ==
                                                    'Urgent'
                                                ? Icon(
                                                    Icons.info_outline,
                                                    color: Colors.red,
                                                    size: 20,
                                                  )
                                                : Icon(
                                                    Icons.pentagon_outlined,
                                                    color: AppColors.green,
                                                    size: 20,
                                                  ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Text(
                                              '${selectedJob['job_title']}',
                                              style: TextStyle(
                                                  // color: AppColors.green,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 70.sp),
                                            ),
                                          ],
                                        ),
                                        // Text(
                                        //   '${selectedJob['reg_Urgent']}',
                                        //   style: TextStyle(
                                        //     fontSize: 80.sp,
                                        //     color: AppColors.green,
                                        //     fontWeight: FontWeight.w500,
                                        //   ),
                                        // ),

                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          '${selectedJob['req_Avail']} Details',
                                          style: TextStyle(
                                            fontSize: 80.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.green,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50.w, vertical: 10.h),
                                          child: Text(
                                            '${selectedJob['job_title']}',
                                            style: TextStyle(
                                                color: AppColors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),

                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Description: ',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              TextSpan(
                                                  text:
                                                      '${selectedJob['job_description']} '),
                                            ],
                                          ),
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
                                              '${selectedJob['add_Items_State'].join(' , ')}',
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
                                            Expanded(child: Text('${date}')),
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
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Expanded(
                                                child: Text(
                                              '${selectedJob['name']}',
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
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Expanded(
                                                child: Text(
                                              '${selectedJob['email']}',
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
                                                    '${selectedJob['contact']}')
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                print(selectedJob['contact']);

                                                launch(
                                                    'tel:${selectedJob['contact']}');
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
                              ),
                              selectedJob['ref_id'] == currentUser
                                  ? SizedBox()
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 50.w),
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.orange),
                                          onPressed: () async {
                                            var username =
                                                '${selectedJob['name']}_${loggedUserName}';

                                            var doc1 =
                                                '${selectedJob['name']}_${loggedUserName}';
                                            var doc2 =
                                                '${loggedUserName}_${selectedJob['name']}';

                                            var checkDocument1 =
                                                await FirebaseFirestore.instance
                                                    .collection('chatRoom')
                                                    .doc(doc1)
                                                    .get();
                                            var checkDocument2 =
                                                await FirebaseFirestore.instance
                                                    .collection('chatRoom')
                                                    .doc(doc2)
                                                    .get();

                                            if (checkDocument1.exists) {
                                              final route = MaterialPageRoute(
                                                builder: (context) => ChatDetails(
                                                    // selectedJob: selectedJob,
                                                    chatRoomId: doc1,
                                                    sentByName: loggedUserName),
                                              );
                                              Navigator.push(context, route);
                                            } else if (checkDocument2.exists) {
                                              final route = MaterialPageRoute(
                                                builder: (context) => ChatDetails(
                                                    // selectedJob: selectedJob,
                                                    chatRoomId: doc2,
                                                    sentByName: loggedUserName),
                                              );
                                              Navigator.push(context, route);
                                            } else {
                                              var docRef =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('chatRoom')
                                                      .doc(username)
                                                      .set({
                                                'chatRoomId': username,
                                                'users': [
                                                  selectedJob['name'],
                                                  loggedUserName
                                                ]
                                              });
                                              final route = MaterialPageRoute(
                                                builder: (context) => ChatDetails(
                                                    // selectedJob: selectedJob,
                                                    chatRoomId: username,
                                                    sentByName: loggedUserName),
                                              );
                                              Navigator.push(context, route);
                                            }
                                          },
                                          label: Text('Chat now'),
                                          icon: Icon(
                                              CupertinoIcons.chat_bubble_2)),
                                    )
                            ],
                          );
                        }))),
          ],
        ),
      ),
    );
  }

  fetchUser() async {
    var docRef = await FirebaseFirestore.instance
        .collection('users/')
        .doc(currentUser)
        .snapshots();
    docRef.first.then((value) {
      setState(() {
        loggedUserName = value['firstname'];
      });
    });
  }
}

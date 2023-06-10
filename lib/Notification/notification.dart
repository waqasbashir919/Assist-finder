import 'package:asist_finder/Chat%20Screen/chat_details.dart';
import 'package:asist_finder/Tabs_home_Screen/more_details.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List? apiJobs;
  @override
  void initState() {
    super.initState();

    fetchJobs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notification'),
        centerTitle: true,
        backgroundColor: AppColors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: Text(
          //     'Notifications',
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fetchJobs(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = documents[index];
                      var date = DateFormat('yyyy-MMMM-dd')
                          .format(data['created_At'].toDate());
                      var time = DateFormat('hh:mm:a')
                          .format(data['created_At'].toDate());
                      return GestureDetector(
                        onTap: () {
                          final route = MaterialPageRoute(
                            builder: (context) => MoreDetails(job: data),
                          );
                          Navigator.push(context, route);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Posted a job by ${data['name']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: AssetImage(
                                                'assets/images/user.png'),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['job_title'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 950.w,
                                                child: Text(
                                                  '${data['job_description']}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('$date'),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('$time'),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    ));
  }

  Stream<QuerySnapshot> fetchJobs() {
    return FirebaseFirestore.instance
        .collection('jobs')
        .orderBy('created_At', descending: true)
        .snapshots();
    // return FirebaseFirestore.instance.collection('users').snapshots();
  }
}

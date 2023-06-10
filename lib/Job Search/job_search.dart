import 'package:asist_finder/const/appColors..dart';
import 'package:asist_finder/const/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_text_field.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({Key? key}) : super(key: key);

  @override
  _JobSearchState createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController jobsearchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding.padding80.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.0),
                      Text('Tabs Inside Body',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22)),
                      DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            Container(
                              child: TabBar(
                                tabs: [
                                  Tab(text: 'Tab 1'),
                                  Tab(text: 'Tab 2'),
                                  Tab(text: 'Tab 3'),
                                ],
                              ),
                            ),
                            Container(
                              height: 400, //height of TabBarView
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: TabBarView(children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Text('Display Tab 1',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text('Display Tab 2',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              child: Center(
                                child: Text('Display Tab 3',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CutomTextField(
                  inputtype: TextInputType.name,
                  hintText: 'Job Search',
                  borerColor: Colors.grey,
                  labeltext: '',
                  obsecuretext: false,
                  prefixicon: Icons.search,
                  controller: jobsearchcontroller,
                  validator: (String? value) {
                    return null;
                  },
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Contractor Requirements',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 80.sp),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(bottom: 10),
                          physics: BouncingScrollPhysics(),
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 220.h,
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
                                            Text('Contractor'),
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
                                Container(
                                  width: double.infinity,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(18.r),
                                        bottomRight: Radius.circular(18.r),
                                      ),
                                      color: AppColors.orange),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              'View Details',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 10.h,
                                            ),
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Chat Now',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 10.h,
                                            ),
                                            Icon(
                                              CupertinoIcons.chat_bubble_2,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: 15.h,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:asist_finder/Chat%20Screen/chat_screen.dart';
import 'package:asist_finder/Notification/notification.dart';
import 'package:asist_finder/const/appColors..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Filter/filter_screen.dart';
import '../Profile Screen/profile_screen.dart';
import '../Tabs_home_Screen/tabs_home.dart';

class bottomnav extends StatefulWidget {
  TextEditingController? searchfiler;
  bottomnav({
    this.searchfiler,
    Key? key,
  }) : super(key: key);

  @override
  _bottomnavState createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int _currentindex = 0;

  final tabs = [
    // ProviderGiveJob2(),
    // JobSearch(),
    TabsHome(),
    // Requirements(),
    filterScreen(),
    ChatScreen(),
    // ProfileScreen()
    // Center(child: Text('Notification')),

    NotificationScreen(),

    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    // widget.fromUpdate != null
    //     ? widget.fromUpdate == true
    //         ? _currentindex = 4
    //         : _currentindex = 0
    //     : _currentindex = 0;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.green,
          currentIndex: _currentindex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.color_filter),
              label: 'Filters',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (value) {
            setState(() {
              _currentindex = value;
              // if (widget.fromUpdate == true) {
              //   _currentindex = 4;
              // } else {
              //   _currentindex = value;
              // }
            });
          },
        ),
        body: tabs[_currentindex],
      ),
    );
  }
}

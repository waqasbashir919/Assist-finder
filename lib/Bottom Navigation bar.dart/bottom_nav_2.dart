// import 'package:asist_finder/Filter/filter_screen.dart';
// import 'package:asist_finder/Profile%20Screen/profile_screen.dart';
// import 'package:asist_finder/const/appColors..dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../Chat Screen/chat_screen.dart';
// import '../Filter/filer_screen.dart';
// import '../Notification/notification.dart';
// import '../Tabs_home_Screen/tabs_home.dart';

// class BottomNav2 extends StatefulWidget {
//   const BottomNav2({Key? key}) : super(key: key);

//   @override
//   _BottomNav2State createState() => _BottomNav2State();
// }

// class _BottomNav2State extends State<BottomNav2> {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: CupertinoTabScaffold(
//           tabBar: CupertinoTabBar(
//             activeColor: AppColors.green,
//             items: const <BottomNavigationBarItem>[
//               //active color use on first
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home_outlined,
//                 ),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.color_filter),
//                 label: 'Filters',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.chat_outlined),
//                 label: 'Chat',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.chat_outlined),
//                 label: 'Notification',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//           tabBuilder: (context, index) {
//             switch (index) {
//               case 0:
//                 return CupertinoTabView(builder: (context) {
//                   return CupertinoPageScaffold(
//                     child: TabsHome(),
//                   );
//                 });
//               case 1:
//                 return CupertinoTabView(builder: (context) {
//                   return CupertinoPageScaffold(
//                     child: filterScreen(),
//                   );
//                 });
//               case 2:
//                 return CupertinoTabView(builder: (context) {
//                   return CupertinoPageScaffold(
//                     child: ChatScreen(),
//                   );
//                 });
//               case 3:
//                 return CupertinoTabView(builder: (context) {
//                   return CupertinoPageScaffold(
//                     child: NotificationScreen(),
//                   );
//                 });
//               case 4:
//                 return CupertinoTabView(builder: (context) {
//                   return CupertinoPageScaffold(
//                     child: ProfileScreen(),
//                   );
//                 });
//               default:
//                 CupertinoTabView(builder: (context) {
//                   return CupertinoPageScaffold(
//                     child: Container(
//                       child: Text("page dates "),
//                     ),
//                   );
//                 });
//             }
//             ;
//             return Container();
//           }),
//     );
//   }
// }

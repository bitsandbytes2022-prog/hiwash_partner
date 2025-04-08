import 'package:flutter/material.dart';
import 'package:hiwash_partner/featuers/qr_scanner/view/qr_scanner.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../notification/view/notification_screen.dart';
import '../../profile/view/drawer_screen.dart';
import '../../reward/view/reward_screen.dart';
import '../../rewarded_customers/view/rewarded_customers_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    RewardScreen(),
    RewardedCustomersScreen(),
    NotificationScreen(),
    //NotificationScreen(),
    DrawerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> iconList = [
      Icons.home,
      Icons.star,
      Icons.notifications,
      Icons.person,
    ];

    return Scaffold(
      drawer:DrawerScreen() ,
      body: _pages[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,

        onTap: _onItemTapped,
        backgroundColor: AppColor.blue,
        activeColor: Colors.white,
        inactiveColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return QrScreen();
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget scanDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        37.heightSizeBox,
        Text("Redeem Wash!", style: w700_22a(color: AppColor.c2C2A2A)),
        Text(
          "Scan Your QR Code to\nEnjoy Your Wash.",
          style: w400_16p(color: AppColor.c455A64),
          textAlign: TextAlign.center,
        ),
        15.heightSizeBox,
        Image.asset(Assets.imagesImQr, height: 261, width: 261),
        46.heightSizeBox,
      ],
    );
  }
}



/*



import 'package:flutter/material.dart';
import 'package:hiwash_partner/featuers/qr_scanner/view/qr_scanner.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';


import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../notification/view/notification_screen.dart';
import '../../profile/view/drawer_screen.dart';
import '../../reward/view/reward_screen.dart';
import '../../rewarded_customers/view/rewarded_customers_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    RewardScreen(),
    RewardedCustomersScreen(),
    QrScreen(),
    NotificationScreen(),
    DrawerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                _currentIndex == 0
                    ? Icon(Icons.home, color: Colors.white)
                    : Icon(Icons.home_outlined, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:
                _currentIndex == 1
                    ? Icon(Icons.star, color: Colors.white)
                    : Icon(Icons.star_border, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:
                _currentIndex == 2
                    ? Icon(Icons.add, color: Colors.white)
                    : Icon(Icons.add_outlined, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:
                _currentIndex == 3
                    ? Icon(Icons.notifications, color: Colors.white)
                    : Icon(Icons.notifications_outlined, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:
                _currentIndex == 4
                    ? Icon(Icons.person, color: Colors.white)
                    : Icon(Icons.person_outline, color: Colors.white),
            label: '', // Empty label
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: AppColor.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return QrScreen();
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget scanDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        37.heightSizeBox,

        Text("Redeem Wash!", style: w700_22a(color: AppColor.c2C2A2A)),
        Text(
          "Scan Your QR Code to\nEnjoy Your Wash.",
          style: w400_16p(color: AppColor.c455A64),
          textAlign: TextAlign.center,
        ),

        15.heightSizeBox,
        Image.asset(Assets.imagesImQr, height: 261, width: 261),

        46.heightSizeBox,
      ],
    );
  }
}
*/

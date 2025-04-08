import 'package:flutter/material.dart';
import 'package:hiwash_partner/featuers/dashboard/view/widget/second_drawer.dart';
import 'package:hiwash_partner/featuers/notification/view/notification_screen.dart';
import 'package:hiwash_partner/featuers/profile/view/drawer_screen.dart';
import 'package:hiwash_partner/featuers/qr_scanner/view/qr_scanner.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hiwash_partner/featuers/reward/view/reward_screen.dart';
import 'package:hiwash_partner/featuers/rewarded_customers/view/rewarded_customers_screen.dart';
import 'package:hiwash_partner/generated/assets.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/widgets/components/image_view.dart';
import 'package:hiwash_partner/widgets/components/profile_image_view.dart';
import '../../../widgets/components/app_home_bg.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentDrawer = 'first';

  final List<Widget> _pages = [
    RewardScreen(),
    RewardedCustomersScreen(),
    NotificationScreen(),
  ];

  final List<String> _headings = [
    "Your Exclusive Reward",
    "Rewarded Customers",
    "Notification’s",
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      _openDrawer('first');
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }


  void _openDrawer(String drawerType) {
    setState(() {
      _currentDrawer = drawerType;
    });
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      print("Drawer scaffold state is null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> filledImages = [
      fillNavigationImage(image: Assets.iconsIcHomeFill),
      fillNavigationImage(image: Assets.iconsIcUsersFill),
      fillNavigationImage(image: Assets.iconsIcNotificationFill),
      ProfileImageView(isVisibleStack: false),
    ];

    final List<Widget> outlineImages = [
      ImageView(path: Assets.iconsIcHome, height: 23, width: 23),
      ImageView(path: Assets.iconsIcUsers, height: 23, width: 23),
      ImageView(path: Assets.iconsIcNotification, height: 23, width: 23),
      ProfileImageView(isVisibleStack: false),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: _currentDrawer == 'first'
          ? DrawerScreen()
          : SecondDrawer(),
      drawerEnableOpenDragGesture: false,

      body: AppHomeBg(
        iconLeft: SizedBox(),
        headingText: _headings[_currentIndex],
        padding: _currentIndex == 2 ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 16),
        iconRight: GestureDetector(
          onTap: () {
            setState(() {
              _currentDrawer = 'second';
            });
            _openDrawer('second');
          },
          child: ImageView(
            height: 23,
            width: 23,
            path: Assets.iconsIcMessage,
          ),
        ),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: filledImages.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isActive ? filledImages[index] : outlineImages[index],
            ],
          );
        },
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: _onItemTapped,
        backgroundColor: AppColor.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return QrScreen();
            },
          );
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColor.cC31848,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: AppColor.cC31848.withOpacity(0.60),
                spreadRadius: 0,
                blurRadius: 30,
                offset: Offset(0, 15),
              ),
            ],
          ),
          child: Center(
            child: ImageView(
              path: Assets.iconsIcQrScanner,
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget fillNavigationImage({required String image}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.c000000.withOpacity(0.70),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: ImageView(path: image, height: 25, width: 25),
    );
  }
}




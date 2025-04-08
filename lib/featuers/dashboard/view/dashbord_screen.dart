import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/featuers/notification/view/notification_screen.dart';
import 'package:hiwash_partner/featuers/profile/view/drawer_screen.dart';
import 'package:hiwash_partner/featuers/qr_scanner/view/qr_scanner.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hiwash_partner/featuers/reward/view/reward_screen.dart';
import 'package:hiwash_partner/featuers/rewarded_customers/view/rewarded_customers_screen.dart';
import 'package:hiwash_partner/generated/assets.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/widgets/components/app_home_bg.dart';
import 'package:hiwash_partner/widgets/components/image_view.dart';
import 'package:hiwash_partner/widgets/components/profile_image_view.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'package:flutter/material.dart';
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

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    RewardScreen(),
    RewardedCustomersScreen(),
    NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      _openDrawer();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
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
      drawer: DrawerScreen(),
      body: _pages[_currentIndex],
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


/*class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    RewardScreen(),
    RewardedCustomersScreen(),
    NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      _openDrawer(isProfileDrawer: true); // Open the profile drawer
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _openDrawer({bool isProfileDrawer = false}) {
    if (isProfileDrawer) {
      // Open the profile drawer
      _scaffoldKey.currentState?.openDrawer();
    } else {
      // Open the help/support drawer
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return secondDrawer();
        },
      );
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
      drawer: DrawerScreen(), // This is your profile drawer
      body: AppHomeBg(
        icon: GestureDetector(
          onTap: () {
            _openDrawer(isProfileDrawer: false); // Open the profile drawer
          },
          child: ImageView(
            height: 23,
            width: 23,
            path: Assets.iconsIcMessage,
          ),
        ),
        headingText: 'Dashboard',
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

  secondDrawer() {
    return Drawer(
      backgroundColor: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          48.heightSizeBox,
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Align(
                alignment: Alignment.topRight,
                child: ImageView(
                  path: Assets.iconsIcClose,
                  height: 28,
                  width: 32,
                ),
              ),
            ),
          ),
          ImageView(path: Assets.imagesHelpSupport, height: 180),
          31.heightSizeBox,
          Text("Get Help?", style: w700_22a()),
          40.heightSizeBox,

          /// **Drawer Options**
          drawerRowWidget(
            onTap: () => {
              Get.to(ChatScreen())
            },
            title: 'Chat with Support',
            image: Assets.iconsIcChat,
          ),
          drawerRowWidget(
            onTap: () => {},
            title: 'Help Desk Ticket',
            image: Assets.iconsIcTicket,
          ),
          drawerRowWidget(
            onTap: () => {},
            title: 'FAQ’s',
            image: Assets.iconsIcFaq,
          ),
          drawerRowWidget(
            onTap: () => {},
            title: 'Step-by-Step Guide',
            dashedLineWidget: false,
            image: Assets.iconsIcGuideBook,
          ),

          Spacer(),
          DashedLineWidget(),
          Container(
            color: AppColor.cF6F7FF,
            alignment: Alignment.center,
            height: 86,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageView(height: 23, width: 23, path: Assets.iconsPhone),
                      Text("+974 7048 7070", style: w500_12a()),
                    ],
                  ),
                ),
                DotedVerticalLine(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageView(height: 23, width: 23, path: Assets.iconsIcAtSign),
                      Text("info@hiwash.com", style: w500_12a()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerRowWidget({
    required VoidCallback onTap,
    required String title,
    bool dashedLineWidget = true,
    required String image,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 12),
            child: Row(
              children: [
                ImageView(path: image, height: 20, width: 20),
                10.widthSizeBox,
                Text(title, style: w500_14a(color: AppColor.c2C2A2A)),
                Spacer(),
                ImageView(
                  path: Assets.iconsBlackForwardArrow,
                  height: 13,
                  width: 13,
                ),
              ],
            ),
          ),
          18.heightSizeBox,
          dashedLineWidget ? DashedLineWidget() : SizedBox(),
          18.heightSizeBox,
        ],
      ),
    );
  }
}*/


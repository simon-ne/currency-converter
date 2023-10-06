import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/screens/history_screen/history.dart';
import 'package:my_app/screens/home_screen/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<Widget> _buildScreens() {
    return [HomeScreen(), HistoryScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox),
        title: ("History"),
        activeColorPrimary: CupertinoColors.black,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller = PersistentTabController(initialIndex: 0);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: false, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
      ),

      // home: Navigator(
      //   initialRoute: '/',
      //   onGenerateRoute: (settings) {
      //     switch (settings.name) {
      //       case '/':
      //         return MaterialPageRoute(builder: (_) => HomePage());
      //       case '/history':
      //         return MaterialPageRoute(builder: (_) => HistoryPage());
      //       default:
      //         return MaterialPageRoute(builder: (_) => Container());
      //     }
      //   },
      // ),
    );
  }
}

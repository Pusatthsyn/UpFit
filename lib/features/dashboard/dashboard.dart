import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:upfit/core/themes/app_colors.dart';
import 'package:upfit/features/dashboard/dashboard_controller.dart';
import 'package:upfit/features/home/home_screen.dart';
import 'package:upfit/features/profile/profile_screen.dart';
import 'package:upfit/features/settings/settings.dart';

class Dashboard extends GetView<DashboardController> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  Dashboard({super.key});

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: AppColors.kPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: AppColors.kPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: AppColors.kPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) {
        return PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          navBarStyle: NavBarStyle.style4, // Navbar design style
        );
      },
    );
  }
}

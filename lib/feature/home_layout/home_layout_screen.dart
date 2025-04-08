import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_images.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Layout'),
      ),
      body: const Center(
        child: const Text(
          'Welcome to the Home Layout Screen!',
        ),
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: 0,
        showElevation: true,
        onItemSelected: (index) {},
        items: [
          FlashyTabBarItem(
            activeColor: AppColor.primaryColor,
            icon: SvgPicture.asset(Assets.assetsHome),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: AppColor.primaryColor,
            icon: SvgPicture.asset(Assets.assetsDetection),
            title: const Text('Detection'),
          ),
          FlashyTabBarItem(
            activeColor: AppColor.primaryColor,
            icon: SvgPicture.asset(Assets.assetsControl),
            title: const Text('Control'),
          ),
        ],
      ),
    );
  }
}

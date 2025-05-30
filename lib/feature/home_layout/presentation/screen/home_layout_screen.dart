import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/core/utils/app_images.dart';
import 'package:final_proj/core/utils/app_string.dart';
import 'package:final_proj/feature/home_layout/presentation/cubit/cubit/home_layout_cubit.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/fonts.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  List<String> title = [
    "Weather",
    AppString.detection,
    "Controls",
    "Plant Health",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text(
          title[context.read<HomeLayoutCubit>().currentIndex],
          style: AppFonts.textBold20(context)
              .copyWith(color: AppColor.primaryColor),
        ),
        leading: const SizedBox(),
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
      ),
      body: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
        builder: (context, state) {
          return Container(child: state.getScreen());
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: context.read<HomeLayoutCubit>().currentIndex,
        backgroundColor: AppColor.whiteColor,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            context.read<HomeLayoutCubit>().changeScreen(index);
          });
        },
        items: [
          FlashyTabBarItem(
            activeColor: AppColor.primaryColor,
            inactiveColor: AppColor.primaryColor,
            icon: SvgPicture.asset(
              Assets.assetsHome,
              color: AppColor.primaryColor,
            ),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: AppColor.primaryColor,
            icon: SvgPicture.asset(
              Assets.assetsDetection,
              color: AppColor.primaryColor,
            ),
            title: const Text('Detection'),
          ),
          FlashyTabBarItem(
            activeColor: AppColor.primaryColor,
            icon: SvgPicture.asset(
              Assets.assetsControl,
              color: AppColor.primaryColor,
            ),
            title: const Text('Control'),
          ),
          FlashyTabBarItem(
            activeColor: AppColor.primaryColor,
            icon: const Icon(
              Icons.health_and_safety_outlined,
              color: AppColor.primaryColor,
              size: 30,
            ),
            title: const Text('Health'),
          ),
        ],
      ),
    );
  }
}

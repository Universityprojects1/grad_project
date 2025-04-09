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
    AppString.home,
    AppString.detection,
    AppString.controls
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title[context.read<HomeLayoutCubit>().currentIndex],
          style: AppFonts.textBold20(context).copyWith(color: Colors.white),
        ),
        leading: const SizedBox(),
        centerTitle: true,
        backgroundColor: AppColor.colorButton2,
      ),
      body: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
        builder: (context, state) {
          return Container(
            height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.assetsBackgroundHome),
                      fit: BoxFit.cover)),
              child: state.getScreen());
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: context.read<HomeLayoutCubit>().currentIndex,
        backgroundColor: AppColor.colorButton2,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            context.read<HomeLayoutCubit>().changeScreen(index);
          });
        },
        items: [
          FlashyTabBarItem(
            activeColor: AppColor.whiteColor,
            inactiveColor: AppColor.whiteColor,
            icon: SvgPicture.asset(
              Assets.assetsHome,
              color: AppColor.whiteColor,
            ),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: AppColor.whiteColor,
            icon: SvgPicture.asset(
              Assets.assetsDetection,
              color: AppColor.whiteColor,
            ),
            title: const Text('Detection'),
          ),
          FlashyTabBarItem(
            activeColor: AppColor.whiteColor,
            icon: SvgPicture.asset(
              Assets.assetsControl,
              color: AppColor.whiteColor,
            ),
            title: const Text('Control'),
          ),
        ],
      ),
    );
  }
}

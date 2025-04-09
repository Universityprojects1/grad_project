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
  List<String> title =[
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
        backgroundColor: AppColor.primaryColor,
      ),
      body: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
        builder: (context, state) {
          return state.getScreen();
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: context.read<HomeLayoutCubit>().currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            context.read<HomeLayoutCubit>().changeScreen(index);
          });
        },
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

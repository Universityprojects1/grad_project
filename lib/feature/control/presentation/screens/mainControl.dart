import 'package:final_proj/core/utils/app_color.dart';
import 'package:final_proj/feature/control/presentation/screens/control_screen.dart';
import 'package:flutter/material.dart';

import 'DirecationControl_screen.dart';

class MainControl extends StatelessWidget {
  const MainControl({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColor.colorButton3,
            ),
            tabs: [
              Tab(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Pump Control",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Direction Control",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),

            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PumpControlScreen(),
            DirecationcontrolScreen(),
          ],
        ),
      ),
    );
  }
}

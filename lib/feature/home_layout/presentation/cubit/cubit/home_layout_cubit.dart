import 'package:bloc/bloc.dart';
import 'package:final_proj/feature/control/presentation/screens/control_screen.dart';
import 'package:final_proj/feature/detection/detection_screen.dart';
import 'package:final_proj/feature/home_feature/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutHomeState());
  int currentIndex = 0;
  void changeScreen(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        emit(HomeLayoutHomeState());
        break;
      case 1:
        emit(HomeLayoutDetectionState());
        break;
      case 2:
        emit(HomeLayoutControlState());
        break;
      default:
        emit(HomeLayoutHomeState());
    }
  }
}

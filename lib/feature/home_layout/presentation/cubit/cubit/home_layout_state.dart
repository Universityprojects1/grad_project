part of 'home_layout_cubit.dart';

@immutable
sealed class HomeLayoutState {
  Widget getScreen();
}

final class HomeLayoutHomeState extends HomeLayoutState {
  @override
  Widget getScreen() {
    return BlocProvider(
      create: (context) => WeatherCubit()..updateLocation(),
      child: const HomePage(),
    );
  }
}

final class HomeLayoutDetectionState extends HomeLayoutState {
  @override
  Widget getScreen() {
    return BlocProvider(
      create: (context) => DetectionCubit(DetectionRepoImpl()),
      child: const DetectionScreen(),
    );
  }
}

final class HomeLayoutControlState extends HomeLayoutState {
  @override
  Widget getScreen() {
    return const ControlScreen();
  }
}

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
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => DetectionCubit()..startListening(),
      ),
      BlocProvider(
        create: (context) => DetectionCameraCubit(),
      ),
    ], child: const DetectionScreen());
  }
}

final class HomeLayoutControlState extends HomeLayoutState {
  @override
  Widget getScreen() {
    return const MainControl();
  }
}

final class HomeLayoutHealthState extends HomeLayoutState {
  @override
  Widget getScreen() {
    return BlocProvider(
      create: (context) => NpkCubit(
        NpkSocketService(

            // Replace with your WebSocket port
            ),
      )..connect("4.3.2.24", 8765),
      child: HealthScreen(),
    );
  }
}

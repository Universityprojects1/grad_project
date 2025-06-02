import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:final_proj/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'config/routes/routes.dart';
import 'core/di/service_locator.dart';
import 'core/services/notifications/local_notifications_service.dart';
import 'core/services/notifications/puch_notifications.dart';
import 'core/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  Bloc.observer = MyBlocObserver();
  await Future.wait([
    PushNotificationsService.init(),
    LocalNotificationService.init(),
  ]);
  runApp(
    DevicePreview(
      enabled: true,

      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRoute.router,
      ),
    );
  }
}

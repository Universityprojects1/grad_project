import 'package:final_proj/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/cache/storage_token.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StorageToken storageToken = StorageToken();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body:  Center(
        child: InkWell(
          onTap: () {
            storageToken.deleteToken();
            GoRouter.of(context).pushReplacement(AppRoute.signInScreen);
          },
          child: const Text(
            'Welcome to Home Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

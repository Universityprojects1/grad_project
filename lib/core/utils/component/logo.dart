import 'package:final_proj/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage: AssetImage(Assets.assetsFlower),
      radius: 50,
    );
  }
}

import 'package:final_proj/feature/detection/data/repo/detection_repo.dart';
import 'package:final_proj/feature/detection/data/repo/detection_repo_impl.dart';
import 'package:final_proj/feature/detection/presentation/cubit/detection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Screen'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            context.read<DetectionCubit>().detect();
          },
          child: const Text('Test.'),
        ),
      ),
    );
  }
}

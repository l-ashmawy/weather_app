import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

class AnimatedComponent extends StatelessWidget {
  final double height;
  final double width;
  final String path;

  const AnimatedComponent(
      {super.key,
      required this.height,
      required this.width,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(path, width: width, height: height);
  }
}

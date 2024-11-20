import 'package:art_core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

import '../animated_component.dart';

class AnimatedAppLoader extends StatelessWidget {
  final double height;
  final double width;

  const AnimatedAppLoader({
    super.key,
     this.height =180,
    this.width=180,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedComponent(
      height: height,
      width: width,
      path: AssetsManager.loadingIcon,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:orange_ui/utils/color_res.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  final Color? color1;
  final Color? color2;

  const GradientWidget({
    Key? key,
    required this.child,
    this.color1,
    this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1 ?? ColorRes.orange2,
            color2 ?? ColorRes.red2,
          ],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

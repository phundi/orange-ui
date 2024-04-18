import 'package:flutter/material.dart';
import 'package:orange_ui/utils/color_res.dart';

class StyleRes {
  static const Gradient linearGradient = LinearGradient(
      colors: [ColorRes.lightOrange1, ColorRes.darkOrange],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static const Gradient linearDimGrey = LinearGradient(
      colors: [ColorRes.dimGrey, ColorRes.dimGrey],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}

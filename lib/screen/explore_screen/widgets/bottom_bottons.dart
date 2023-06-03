import 'package:flutter/material.dart';
import 'package:orange_ui/common/widgets/gradient_widget.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onPlayBtnTap;
  final VoidCallback onNextBtnTap;
  final VoidCallback onEyeTap;

  const BottomButtons({
    Key? key,
    required this.onPlayBtnTap,
    required this.onNextBtnTap,
    required this.onEyeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Visibility(
            visible:
                PrefService.settingData?.appdata?.isDating == 0 ? false : true,
            child: PlayBtnClick(onPlayBtnClick: onPlayBtnTap)),
        UnicornOutlineButton(
          strokeWidth: 3,
          radius: 30,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorRes.lightOrange1,
              ColorRes.darkOrange,
            ],
          ),
          onPressed: onNextBtnTap,
          child: Center(
            child: Text(
              S.current.next,
              style: const TextStyle(
                color: ColorRes.orange2,
                fontSize: 17,
                fontFamily: FontRes.bold,
              ),
            ),
          ),
        ),
        Visibility(
          visible:
              PrefService.settingData?.appdata?.isDating == 0 ? false : true,
          child: InkWell(
            onTap: onEyeTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 51,
              width: 51,
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1.7, 1.5),
                    color: ColorRes.lightGrey.withOpacity(0.7),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  AssetRes.eye,
                  height: 20,
                  width: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PlayBtnClick extends StatefulWidget {
  final VoidCallback onPlayBtnClick;

  const PlayBtnClick({Key? key, required this.onPlayBtnClick})
      : super(key: key);

  @override
  State<PlayBtnClick> createState() => _PlayBtnClickState();
}

class _PlayBtnClickState extends State<PlayBtnClick>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return InkWell(
      onTap: widget.onPlayBtnClick,
      splashColor: ColorRes.transparent,
      highlightColor: ColorRes.transparent,
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      borderRadius: BorderRadius.circular(10),
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 51,
          width: 51,
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(1.7, 1.5),
                color: ColorRes.lightGrey.withOpacity(0.7),
                blurRadius: 3,
              ),
            ],
          ),
          child: Center(
            child: Transform.rotate(
              angle: 3.1,
              child: GradientWidget(
                child: Image.asset(
                  AssetRes.playButton,
                  height: 25,
                  width: 25,
                  color: ColorRes.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

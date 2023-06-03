import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/utils/color_res.dart';

class DropDownBox extends StatelessWidget {
  final String gender;
  final Function(String value) onChange;

  const DropDownBox({
    Key? key,
    required this.gender,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: ColorRes.white, boxShadow: [
        BoxShadow(
          color: ColorRes.grey2.withOpacity(0.35),
          offset: const Offset(0, 2),
          blurRadius: 3,
        ),
        BoxShadow(
          color: ColorRes.grey2.withOpacity(0.35),
          offset: const Offset(2, 0),
          blurRadius: 3,
        ),
      ]),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  onChange(S.current.male);
                },
                child: Container(
                  height: 30,
                  width: Get.width - 80,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.male,
                    style: TextStyle(
                      color: gender == S.current.male
                          ? ColorRes.orange
                          : ColorRes.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onChange(S.current.female);
                },
                child: Container(
                  height: 30,
                  width: Get.width - 80,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.female,
                    style: TextStyle(
                      color: gender == S.current.female
                          ? ColorRes.orange
                          : ColorRes.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onChange(S.current.other);
                },
                child: Container(
                  height: 30,
                  width: Get.width - 80,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.other,
                    style: TextStyle(
                      color: gender == S.current.other
                          ? ColorRes.orange
                          : ColorRes.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

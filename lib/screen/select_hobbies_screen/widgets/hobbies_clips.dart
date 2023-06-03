import 'package:flutter/material.dart';
import 'package:orange_ui/utils/color_res.dart';

class HobbiesClips extends StatelessWidget {
  final List<String> hobbiesList;
  final List<String> selectedList;
  final Function(String value) onClipTap;

  const HobbiesClips({
    Key? key,
    required this.hobbiesList,
    required this.selectedList,
    required this.onClipTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 13),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: hobbiesList.map<Widget>((e) => clip(e)).toList(),
      ),
    );
  }

  Widget clip(String label) {
    bool selected = selectedList.contains(label);
    return Padding(
      padding: const EdgeInsets.only(right: 9, bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          onClipTap(label);
        },
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color:
                selected ? ColorRes.white : ColorRes.orange2.withOpacity(0.06),
            borderRadius: BorderRadius.circular(30),
            gradient: selected
                ? const LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                      ColorRes.orange2,
                      ColorRes.red2,
                    ],
                  )
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? ColorRes.white : ColorRes.orange2,
              fontSize: 12,
              fontFamily: "gilroy_bold",
            ),
          ),
        ),
      ),
    );
  }
}

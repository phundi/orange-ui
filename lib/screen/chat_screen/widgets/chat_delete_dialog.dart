import 'package:flutter/material.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/font_res.dart';

class ChatDeleteDialog extends StatelessWidget {
  final VoidCallback onCancelBtnCLick;
  final VoidCallback onDeleteBtnClick;

  const ChatDeleteDialog(
      {Key? key,
      required this.onCancelBtnCLick,
      required this.onDeleteBtnClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 2.5,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                S.current.deleteMessage,
                style: const TextStyle(
                    fontSize: 18, fontFamily: FontRes.extraBold),
              ),
              const Spacer(),
              Text(
                S.current.areYouSureYouEtc,
                style: const TextStyle(
                    color: ColorRes.grey,
                    fontFamily: FontRes.medium,
                    fontSize: 15),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: onCancelBtnCLick,
                    splashColor: ColorRes.transparent,
                    highlightColor: ColorRes.transparent,
                    child: Text(
                      S.current.cancelCap,
                      style: const TextStyle(
                          color: ColorRes.grey, fontFamily: FontRes.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: onDeleteBtnClick,
                    child: Text(
                      S.current.deleteCap,
                      style: const TextStyle(
                          color: ColorRes.orange2, fontFamily: FontRes.bold),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

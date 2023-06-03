import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';

class ImageListArea extends StatelessWidget {
  final List<String> imageList;
  final Function(int index) onImgRemove;
  final VoidCallback onAddBtnTap;

  const ImageListArea({
    Key? key,
    required this.imageList,
    required this.onImgRemove,
    required this.onAddBtnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            AppRes.photos,
            style: TextStyle(
              color: ColorRes.darkGrey3,
              fontSize: 15,
              fontFamily: "gilroy_extra_bold",
            ),
          ),
        ),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                width: Get.width - 105,
                height: 58,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        onImgRemove(index);
                      },
                      child: Container(
                        height: 58,
                        width: 58,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(imageList[index]),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 31,
                            width: 31,
                            decoration: BoxDecoration(
                              color: ColorRes.white.withOpacity(0.30),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                AssetRes.bin,
                                height: 16,
                                width: 15,
                                color: ColorRes.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                //width: 130,
                height: 58,
                child: Row(
                  children: [
                    const SizedBox(width: 7),
                    InkWell(
                      onTap: onAddBtnTap,
                      child: Container(
                        height: 58,
                        width: 58,
                        decoration: BoxDecoration(
                          color: ColorRes.lightGrey3,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:
                              Image.asset(AssetRes.plus, height: 17, width: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

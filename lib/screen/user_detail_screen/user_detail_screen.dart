import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/shimmer_screen/shimmer_screen.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen_view_model.dart';
import 'package:orange_ui/screen/user_detail_screen/widgets/detail_page.dart';
import 'package:orange_ui/screen/user_detail_screen/widgets/image_selection_area.dart';
import 'package:orange_ui/screen/user_detail_screen/widgets/top_bar.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:stacked/stacked.dart';

class UserDetailScreen extends StatefulWidget {
  final bool? showInfo;

  const UserDetailScreen({Key? key, this.showInfo}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn, reverseCurve: Curves.fastOutSlowIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDetailScreenViewModel>.reactive(
      onViewModelReady: (model) {
        model.init(model.moreInfo);
      },
      viewModelBuilder: () => UserDetailScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              model.isLoading
                  ? ShimmerScreen.rectangular(
                      height: Get.height,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    )
                  : model.userData?.images == null || model.userData!.images!.isEmpty
                      ? Container(
                          height: Get.height,
                          width: double.infinity,
                          decoration: const BoxDecoration(color: ColorRes.lightGrey),
                          child: Image.asset(AssetRes.imageWarning),
                        )
                      : Container(
                          height: Get.height,
                          width: Get.width,
                          color: ColorRes.darkOrange.withOpacity(0.2),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${ConstRes.aImageBaseUrl}${model.userData?.images?[model.selectedImgIndex].image}',
                            cacheKey:
                                '${ConstRes.aImageBaseUrl}${model.userData?.images?[model.selectedImgIndex].image}',
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) {
                              return Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: ColorRes.darkOrange.withOpacity(0.2)),
                                  child: Image.asset(AssetRes.themeLabel));
                            },
                          ),
                        ),
              Column(
                children: [
                  TopBar(model: model),
                  Expanded(
                    child: !model.moreInfo
                        ? ImageSelectionArea(
                            model: model,
                            onMoreInfoTap: () {
                              model.moreInfo = true;
                              _controller.forward();
                              setState(() {});
                            },
                          )
                        : SlideTransition(
                            position: _animation,
                            transformHitTests: true,
                            child: DetailPage(
                              model: model,
                              onHideBtnTap: () {
                                _controller.reverse().then((value) {
                                  model.moreInfo = false;
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

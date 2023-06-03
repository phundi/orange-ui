import 'package:flutter/material.dart';
import 'package:orange_ui/screen/livestream_dashboard_screen/livestream_dashboard_screen_view_model.dart';
import 'package:orange_ui/screen/livestream_dashboard_screen/widgets/center_area_livestream_dashboard.dart';
import 'package:orange_ui/screen/livestream_dashboard_screen/widgets/top_area_livestream_dashboard.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class LiveStreamDashBoard extends StatelessWidget {
  const LiveStreamDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveStreamDashBoardViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => LiveStreamDashBoardViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              TopAreaLiveStreamDashBoard(onBackBtnTap: model.onBackBtnTap),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                width: MediaQuery.of(context).size.width,
                color: ColorRes.grey5,
              ),
              CenterAreaLiveStreamDashBoard(
                onRedeemTap: model.onRedeemTap,
                eligible: model.eligible,
                onEligibleTap: model.onEligibleTap,
                onHistoryBtnTap: model.onHistoryBtnTap,
                onRedeemBtnTap: model.onRedeemBtnTap,
                onApplyBtnTap: model.onApplyBtnTap,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:orange_ui/screen/options_screen/widgets/bottom_legal_area.dart';
import 'package:orange_ui/screen/options_screen/widgets/options_center_area.dart';
import 'package:orange_ui/screen/options_screen/widgets/options_top_bar.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

import 'options_screen_view_model.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OptionalScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => OptionalScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                OptionsTopBar(onBackBtnTap: model.onBackBtnTap),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: MediaQuery.of(context).size.width,
                  color: ColorRes.grey5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 9),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          OptionsCenterArea(
                            notificationEnable: model.notificationEnable,
                            goAnnonymous: model.goAnnonymous,
                            showMeOnMap: model.showMeOnMap,
                            onGoPremiumTap: model.onGoPremiumTap,
                            onLiveStreamTap: model.onLiveStreamTap,
                            onAnnonymousTap: model.onGoAnnonymousTap,
                            onNotificationTap: model.onNotificationTap,
                            onShowMeOnMapTap: model.onSHowMeOnMapTap,
                          ),
                          const SizedBox(height: 20),
                          BottomLegalArea(
                            onPrivacyPolicyTap: model.onPrivacyPolicyTap,
                            onTermsOfUseTap: model.onTermsOfUseTap,
                            onHelpNSupportTap: model.onHelpNSupportTap,
                            onLogoutTap: model.onLogoutTap,
                            onDeleteAccountTap: model.onDeleteAccountTap,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orange_ui/screen/map_screen/map_screen_view_model.dart';
import 'package:orange_ui/screen/map_screen/widgets/hobby_selection_bar.dart';
import 'package:orange_ui/screen/map_screen/widgets/top_bar_area.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:stacked/stacked.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init(context);
      },
      viewModelBuilder: () => MapScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  onMapCreated: model.onMapCreated,
                  markers: model.markers,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: model.center,
                    zoom: 15.0,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    const SizedBox(height: 13),
                    TopBarArea(
                      distanceList: model.distanceList,
                      selectedDistance: model.selectedDistance,
                      onBackBtnTap: model.onBackBtnTap,
                      onDistanceChange: model.onDistanceChange,
                    ),
                    const Spacer(),
                    HobbySelectionBar(
                      hobbyList: model.hobbyList,
                      selectedHobby: model.selectedHobby,
                      onHobbySelect: model.onHobbySelect,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

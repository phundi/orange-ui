import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orange_ui/screen/map_screen/widgets/user_pop_up.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class MapScreenViewModel extends BaseViewModel {
  void init(context) {
    getCurrentLocation();
    setCustomMapPin();
  }

  String selectedHobby = AppRes.singingCap;
  List<String> hobbyList = [
    AppRes.dance,
    AppRes.singingCap,
    AppRes.travelCap,
    AppRes.athletics,
    AppRes.photography,
    AppRes.gym,
    AppRes.yoga,
    AppRes.swimming,
    AppRes.musicCap,
    AppRes.walkingCap,
    AppRes.pets,
    AppRes.fitnessCap,
    AppRes.sports,
    AppRes.fashion,
  ];
  int selectedDistance = 10;
  List<int> distanceList = [1, 5, 10, 20, 50];
  late GoogleMapController mapController;
  LatLng center = const LatLng(28.535517, 77.391029);
  List<BitmapDescriptor> pinLocationIcon = [];
  Set<Marker> markers = {};
  Completer<GoogleMapController> controller = Completer();

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    center = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  void setCustomMapPin() async {
    pinLocationIcon.add(await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)), AssetRes.marker1));
    pinLocationIcon.add(await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)), AssetRes.marker2));
    pinLocationIcon.add(await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)), AssetRes.marker3));
    pinLocationIcon.add(await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)), AssetRes.marker4));
    pinLocationIcon.add(await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)), AssetRes.marker5));
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    markers.add(Marker(
      markerId: const MarkerId('1'),
      position: LatLng(center.latitude + 0.0090, center.longitude),
      icon: pinLocationIcon[0],
      onTap: onMapTap,
    ));
    markers.add(Marker(
      markerId: const MarkerId('2'),
      position: LatLng(center.latitude + 0.0040, center.longitude - 0.0050),
      icon: pinLocationIcon[1],
      onTap: onMapTap,
    ));
    markers.add(Marker(
      markerId: const MarkerId('3'),
      position: LatLng(center.latitude + 0.0010, center.longitude + 0.0030),
      icon: pinLocationIcon[2],
      onTap: onMapTap,
    ));
    markers.add(Marker(
      markerId: const MarkerId('4'),
      position: LatLng(center.latitude - 0.0050, center.longitude - 0.0010),
      icon: pinLocationIcon[3],
      onTap: onMapTap,
    ));
    markers.add(Marker(
      markerId: const MarkerId('5'),
      position: LatLng(center.latitude - 0.0100, center.longitude + 0.0060),
      icon: pinLocationIcon[4],
      onTap: onMapTap,
    ));
    mapController.animateCamera(CameraUpdate.newLatLng(center));
  }

  void onDistanceChange(int value) {
    selectedDistance = value;
    notifyListeners();
  }

  void onMapTap() {
    Get.dialog(
      UserPopUp(
        onMoreInfoTap: onMoreInfoTap,
        onCancelTap: onCancelTap,
      ),
      barrierColor: Colors.transparent,
    );
  }

  void onMoreInfoTap() {
    Get.back();
    Get.to(() => const UserDetailScreen(showInfo: true));
  }

  void onCancelTap() {
    Get.back();
  }

  void onHobbySelect(String value) {
    selectedHobby = value;
    notifyListeners();
  }
}

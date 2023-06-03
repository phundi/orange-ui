import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/map_screen/map_screen.dart';
import 'package:orange_ui/screen/user_detail_screen/user_detail_screen.dart';
import 'package:orange_ui/utils/app_res.dart';
import 'package:orange_ui/utils/asset_res.dart';
import 'package:stacked/stacked.dart';

class SearchScreenViewModel extends BaseViewModel {
  void init() {
    onSearchBtnTap();
  }

  String selectedTab = '';
  TextEditingController searchController = TextEditingController();
  List<String> tabList = [
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
  List<Map<String, dynamic>> filterList = [];
  List<Map<String, dynamic>> userList = [
    {
      'name': "Natalia Nora",
      'age': 24,
      'address': 'Las Vegas, USA',
      'tickMark': true,
      'image': AssetRes.profile6,
    },
    {
      'name': "Pinky Arora",
      'age': 22,
      'address': 'Mumbai, India',
      'tickMark': true,
      'image': AssetRes.profile9,
    },
    {
      'name': "Nora Malik",
      'age': 28,
      'address': 'Karachi, Pakistan',
      'tickMark': false,
      'image': AssetRes.profile10,
    },
    {
      'name': "Aron Nora",
      'age': 26,
      'address': 'London, UK',
      'tickMark': true,
      'image': AssetRes.profile11,
    },
    {
      'name': "Norak Patel",
      'age': 26,
      'address': 'Delhi, India',
      'tickMark': true,
      'image': AssetRes.profile12,
    },
  ];

  void onBackBtnTap() {
    if (selectedTab == '') {
      Get.back();
    } else {
      selectedTab = '';
      notifyListeners();
    }
  }

  void onSearchBtnTap() {
    filterList = [];
    for (var element in userList) {
      if (element['name']
          .toString()
          .toUpperCase()
          .contains(searchController.text.toUpperCase())) {
        filterList.add(element);
      }
    }
    notifyListeners();
  }

  void onLocationTap() {
    Get.to(() => const MapScreen());
  }

  void onTabSelect(String value) {
    selectedTab = value;
    notifyListeners();
  }

  void onUserTap(Map<String, dynamic> data) {
    Get.to(() => const UserDetailScreen());
  }
}

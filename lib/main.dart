import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orange_ui/screen/get_started_screen/get_started_screen.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:photo_manager/photo_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PhotoManager.requestPermissionExtend();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Orange UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "gilroy",
        primaryColor: ColorRes.orange,
      ),
      home: const GetStartedScreen(),
    );
  }
}

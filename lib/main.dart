import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/screen/chat_screen/chat_screen_view_model.dart';
import 'package:orange_ui/screen/get_started_screen/get_started_screen.dart';
import 'package:orange_ui/screen/languages_screen/languages_screen_view_model.dart';
import 'package:orange_ui/screen/restart_app/restart_app.dart';
import 'package:orange_ui/service/pref_service.dart';
import 'package:orange_ui/utils/color_res.dart';
import 'package:orange_ui/utils/const_res.dart';
import 'package:orange_ui/utils/font_res.dart';
import 'package:orange_ui/utils/pref_res.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // Status bar color
    statusBarColor: ColorRes.transparent,
    // Status bar brightness (optional)
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light, // For iOS (dark icons)
  ));
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  LanguagesScreenViewModel.selectedLanguage =
      await PrefService.getString(PrefConst.languageCode) ??
          Platform.localeName.split('_')[0];
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // This should be used while in development mode
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const RestartWidget(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    FlutterAppBadger.removeBadge();
    saveTokenUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(LanguagesScreenViewModel.selectedLanguage),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: FontRes.regular,
        primaryColor: ColorRes.orange,
        splashColor: ColorRes.transparent,
        highlightColor: ColorRes.transparent,
      ),
      home: const GetStartedScreen(),
    );
  }

  void saveTokenUpdate() async {
    await FirebaseMessaging.instance
        .subscribeToTopic(ConstRes.subscribeToTopic);

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'orange_flutter', // id
      'Orange', // title
      playSound: true,
      description: 'Orange App',
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        var initializationSettingsAndroid =
            const AndroidInitializationSettings('@mipmap/ic_launcher');
        var initializationSettingsIOS = const DarwinInitializationSettings();
        var initializationSettings = InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
        flutterLocalNotificationsPlugin.initialize(initializationSettings);
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? apple = message.notification?.apple;

        if (notification != null &&
            apple != null &&
            !ChatScreenViewModel.isScreen) {
          flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            const NotificationDetails(
              iOS: DarwinNotificationDetails(
                presentSound: true,
                presentAlert: true,
                presentBadge: true,
              ),
            ),
          );
        }
        if (notification != null &&
            android != null &&
            !ChatScreenViewModel.isScreen) {
          flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
              ),
            ),
          );
        }
      },
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

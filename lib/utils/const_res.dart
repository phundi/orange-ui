class ConstRes {
  ///------------------------ Backend urls and key ------------------------///

  static const String base = 'https://mobile.malovings.com/';
  static const String aBaseUrl = '${base}api/';
  static const String aImageBaseUrl = '${base}public/storage/';
  static const String apiKey = '123';

  ///------------------------ Firebase FCM token And Token Id ------------------------///

  static const String subscribeTopic = 'orange';

  ///------------------------ Agora app Id ------------------------///
  static const String agoraAppId = "c22dddb581324f658403022a2dbc49a1";
  static const String customerId = "b6fbe01d27744650a32e4da5562d8dbd";
  static const String customerSecret = "4cc5fc61d3e1420781bf4c0ddb642931";
}

/// AppName
const String appName = 'Malovings';

///_____________________________ Image Quality _______________________///
const double maxWidth = 1080;
const double maxHeight = 1080;
const int quality = 80;

// max Images for Post
const int defaultMaxImagesForPost = 5;

//pagination data limit
const int paginationLimit = 20;

// Corner Radius-Smoothing
const cornerSmoothing = 1.0;

//  story Duration for image
const int storyDuration = 5;

// Capture story video duration in second
const int storyVideoDuration = 30;

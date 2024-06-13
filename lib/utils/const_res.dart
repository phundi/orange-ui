class ConstRes {
  ///------------------------ Backend urls and key ------------------------///

  // static const String base = 'https://orange.invatomarket.com/';

  static const String base = 'http://192.168.0.107/orange/';
  static const String aBaseUrl = '${base}api/';
  static const String aImageBaseUrl = '${base}public/storage/';
  static const String apiKey = '123';

  ///------------------------ Firebase FCM token And Token Id ------------------------///

  static const String subscribeTopic = 'orange';

  ///------------------------ Agora app Id ------------------------///
  static const String agoraAppId = "6e660987f7c541309c0c45a133fde8c7";
  static const String customerId = "2fa80f7f38ec48c7b3df029de7599738";
  static const String customerSecret = "ce11056b3fd44851919670703656b9e9";
}

/// AppName
const String appName = 'Orange';

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

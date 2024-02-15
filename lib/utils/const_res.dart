class ConstRes {
  ///------------------------ Backend urls and key ------------------------///

  static const String base = 'https://orange.invatomarket.com/';
  // static const String base = 'http://192.168.0.116/orange/';
  static const String aBaseUrl = '${base}api/';
  static const String aImageBaseUrl = '${base}public/storage/';
  static const String apiKey = '123';

  ///------------------------ Firebase FCM token And Token Id ------------------------///

  static const String subscribeToTopic = 'Orange';

  ///------------------------ Agora app Id ------------------------///
  static const String agoraAppId = "6e660987f7c541309c0c45a133fde8c7";
  static const String customerId = "2fa80f7f38ec48c7b3df029de7599738";
  static const String customerSecret = "ce11056b3fd44851919670703656b9e9";
}

///_____________________________ Image Quality _______________________///
const double maxWidth = 720;
const double maxHeight = 720;
const int quality = 100;

import 'package:orange_ui/generated/l10n.dart';
import 'package:orange_ui/service/pref_service.dart';

class AppRes {
  static const String isSuccessPurchase = "is_success_purchase";
  static const String hmmA = "h:mm a";
  static const String hhMmA = "hh:mm a";
  static const String dMY = "dd MMM yyyy";
  static const String isHttp = "http://";
  static const String isHttps = "https://";
  static String reverseSwipeDisc =
      "${S.current.reverseSwipeWillCostYou} ${PrefService.reverseSwipePrice} ${S.current.coinsPleaseConfirmIfYouToContinueOrNot}";
  static String messageDisc =
      "${S.current.messagePriceWillCostYou} ${PrefService.messagePrice} ${S.current.coinsPerMsgPleaseConfirmIfYouToContinueOr}";
  static String liveStreamDisc =
      "${S.current.liveStreamPriceWillCostYou} ${PrefService.liveWatchingPrice} ${S.current.coinsPerMinutesPleaseConfirmIfYouToContinueOr}";
  static const String reportName = 'reportName';
  static const String reportImage = 'reportImage';
  static const String reportAge = 'reportAge';
  static const String reportAddress = 'reportAddress';
  static const String report = 'Report';

  static const String defaultFullname = 'Unknown';
}

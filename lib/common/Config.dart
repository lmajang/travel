import 'package:amap_flutter_base/amap_flutter_base.dart';

class mapConfig {

  /// 安卓key
  static const androidKey = 'f16c35341ea9a6487f2ec1d21766bc2a';

  /// 苹果key
  static const iosKey = '';

  static const AMapApiKey amapApiKeys =
  AMapApiKey(iosKey: iosKey, androidKey: androidKey);

  ///隐私权政策同意
  static const AMapPrivacyStatement amapPrivacyStatement =
        AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);

}
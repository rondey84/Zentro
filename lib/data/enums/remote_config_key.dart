import 'package:zentro/services/firebase_service.dart';

enum RemoteConfigKey {
  // Home Screen Parameters
  showSearch,
  sectionOneHeader,
  sectionTwoHeader,
  currentOrderCardTitle,
  currentOrderCardButtonText,
  // Payment Parameters
  paymentDisplayName,
  paymentLiveMode,
  paymentTimeout,
}

extension EnvKeysExtension on RemoteConfigKey {
  Type get type {
    switch (this) {
      case RemoteConfigKey.sectionOneHeader:
      case RemoteConfigKey.sectionTwoHeader:
      case RemoteConfigKey.currentOrderCardTitle:
      case RemoteConfigKey.currentOrderCardButtonText:
      case RemoteConfigKey.paymentDisplayName:
        return String;
      case RemoteConfigKey.showSearch:
      case RemoteConfigKey.paymentLiveMode:
        return bool;
      case RemoteConfigKey.paymentTimeout:
        return int;
    }
  }

  String get key {
    switch (this) {
      case RemoteConfigKey.sectionOneHeader:
        return 'Section_One_Header';
      case RemoteConfigKey.sectionTwoHeader:
        return 'Section_Two_Header';
      case RemoteConfigKey.showSearch:
        return 'Show_Search';
      case RemoteConfigKey.currentOrderCardTitle:
        return 'Current_Order_Card_Title';
      case RemoteConfigKey.currentOrderCardButtonText:
        return 'Current_Order_Card_Button_Text';
      case RemoteConfigKey.paymentDisplayName:
        return 'Payment_Name';
      case RemoteConfigKey.paymentLiveMode:
        return 'Payment_Live_Mode';
      case RemoteConfigKey.paymentTimeout:
        return 'Payment_Timeout';
    }
  }

  dynamic get value {
    final remoteConfig = FirebaseService.instance.remoteConfigHelper;

    if (type == String) {
      return remoteConfig.getString(this);
    }
    if (type == int) {
      return remoteConfig.getInt(this);
    }
    if (type == double) {
      return remoteConfig.getDouble(this);
    }
    if (type == bool) {
      return remoteConfig.getBool(this);
    }
  }
}

import 'package:flutter/foundation.dart';

class NotificationSettingProvider with ChangeNotifier {
  bool _vibration = true;
  bool _sound = true;
  bool _notificationEnabled = true;

  bool get vibration => _vibration;
  bool get sound => _sound;

  void toggleNotification(bool value) {
    _notificationEnabled = value;
    notifyListeners();
  }

  void toggleVibration(bool value) {
    _vibration = value;
    notifyListeners();
  }

  void toggleSound(bool value) {
    _sound = value;
    notifyListeners();
  }
}

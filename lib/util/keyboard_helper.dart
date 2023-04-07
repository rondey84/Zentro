import 'package:flutter/services.dart';

class KeyboardHelper {
  /// Closes/Dismisses the keyboard
  static void closeKeyboard() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }
}

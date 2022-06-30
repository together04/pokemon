
import 'dart:async';

import 'package:flutter/services.dart';

class Idenfy {
  static const MethodChannel _channel = MethodChannel('idenfy');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

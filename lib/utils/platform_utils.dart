import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static bool get isWeb => kIsWeb;
  
  static bool get isAndroid {
    if (kIsWeb) return false;
    try {
      // Only import dart:io on non-web platforms
      return false; // Will be overridden in platform-specific code
    } catch (e) {
      return false;
    }
  }
  
  static bool get isIOS {
    if (kIsWeb) return false;
    try {
      return false; // Will be overridden in platform-specific code
    } catch (e) {
      return false;
    }
  }
  
  static String get operatingSystem {
    if (kIsWeb) return 'web';
    return 'unknown';
  }
}

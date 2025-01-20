import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

class AppRate {
  static const String androidId = 'your value';
  static const String iosId = 'your value';

  static void openAppPage() {
    final url = Uri.parse(
      Platform.isAndroid
        ? 'market://details?id=$androidId'
        : 'https://apps.apple.com/app/id$iosId',
    );
    launchUrl(url,
      mode: LaunchMode.externalApplication,
    );
  }
}
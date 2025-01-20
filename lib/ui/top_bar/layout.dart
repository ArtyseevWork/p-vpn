import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double height = 70;
  static const double padding = 6;
  static const double iconPadding = 15;
  static const double premiumMargin = 8;

  double logoHeight = 40;
  double premiumHeight = 30;
  double premiumPadding = 9;
  double premiumFontSize = 15;
  double premiumTextMargin = 6;
  double premiumIconHeight = 16;

  Layout() {
    if (ScreenSize.isSmallPhone()) {
      _setSmallPhoneSizes();
    }
    if (ScreenSize.isMediumPhone()) {
      _setMediumPhoneSizes();
    }
    if (ScreenSize.isTablet()) {
      _setTabletSizes();
    }
  }

  void _setSmallPhoneSizes() {
    logoHeight = 32;
    premiumHeight = 26;
    premiumPadding = 8;
    premiumFontSize = 13;
    premiumTextMargin = 6;
    premiumIconHeight = 12;
  }

  void _setMediumPhoneSizes() {
    logoHeight = 36;
    premiumHeight = 26;
    premiumPadding = 8;
    premiumFontSize = 13;
    premiumTextMargin = 6;
    premiumIconHeight = 12;
  }

  void _setTabletSizes() {

  }
}
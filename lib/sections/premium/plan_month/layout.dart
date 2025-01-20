import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double titleLineHeight = 1.2;
  static const double titleMarginBottom = 16;
  static const double textWidth = 180;
  static const double textFontSize = 14;
  static const double textLineHeight = 1.3;
  static const double buttonMaxWidth = 414;
  static const double buttonMarginBottom = 12;
  static const double hintFontSize = 12;

  double titleFontSize = 24;
  double iconMarginBottom = 40;
  double buttonMarginHorizontal = 40;

  double iconMarginTop = ScreenSize.height * 0.08;
  double iconWidth = ScreenSize.width * 0.45;
  double infoMarginTop = 0;
  double infoMarginLeft = ScreenSize.width * 0.45;

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
    infoMarginTop = iconMarginTop + iconWidth * 0.5;
  }

  void _setSmallPhoneSizes() {
    titleFontSize = 20;
    buttonMarginHorizontal = 24;
  }

  void _setMediumPhoneSizes() {
    titleFontSize = 22;
  }

  void _setTabletSizes() {
    iconMarginBottom = 0;
  }
}
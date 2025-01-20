import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double textLineHeight = 1.2;

  double textFontSize = 20;
  double textMarginTop = 16;
  double textMarginBottom = 24;

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
    textFontSize = 16;
    textMarginTop = 12;
    textMarginBottom = 20;
  }

  void _setMediumPhoneSizes() {
    textFontSize = 18;
  }

  void _setTabletSizes() {

  }
}
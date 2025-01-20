import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double articlePadding = 24;

  double titleMarginTop = 32;
  double titleMarginBottom = 24;
  double titleFontSize = 24;

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
    titleMarginTop = 24;
    titleMarginBottom = 16;
    titleFontSize = 20;
  }

  void _setMediumPhoneSizes() {
    titleFontSize = 22;
  }

  void _setTabletSizes() {

  }
}
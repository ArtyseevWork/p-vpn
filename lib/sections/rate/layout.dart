import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double starWidth = 40;
  static const double starMargin = 8;
  static const double starsMarginBottom = 16;
  static const double todoFontSize = 14;

  double titleMarginBottom = 40;
  double titleFontSize = 24;
  double marginBottom = 80;

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
    titleMarginBottom = 32;
    titleFontSize = 20;
    marginBottom = 60;
  }

  void _setMediumPhoneSizes() {
    titleFontSize = 22;
  }

  void _setTabletSizes() {

  }
}
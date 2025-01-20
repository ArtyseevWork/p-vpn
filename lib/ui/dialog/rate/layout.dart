import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double todoFontSize = 14;

  double marginVertical = 16;
  double titleMarginBottom = 24;
  double titleFontSize = 24;
  double starWidth = 40;
  double starMargin = 8;
  double starsMarginBottom = 16;

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
    marginVertical = 12;
    titleMarginBottom = 20;
    titleFontSize = 20;
    starWidth = 32;
    starMargin = 7;
    starsMarginBottom = 13;
  }

  void _setMediumPhoneSizes() {
    titleFontSize = 22;
  }

  void _setTabletSizes() {

  }
}
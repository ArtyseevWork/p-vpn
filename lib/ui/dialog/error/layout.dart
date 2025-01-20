import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double textLineHeight = 1.3;

  double iconSize = 80;
  double iconMargin = 20;
  double titleFontSize = 24;
  double titleMargin = 8;
  double textFontSize = 18;
  double marginBottom = 24;

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
    iconSize = 64;
    iconMargin = 18;
    titleFontSize = 20;
    titleMargin = 6;
    textFontSize = 16;
    marginBottom = 20;
  }

  void _setMediumPhoneSizes() {
    titleFontSize = 22;
  }

  void _setTabletSizes() {

  }
}
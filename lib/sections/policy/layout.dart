import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double acceptMaxWidth = 350;

  double titleFontSize = 24;
  double titleMarginBottom = 24;
  double articleMarginBottom = 24;
  double acceptMarginBottom = 24;
  double declineFontSize = 16;

  double height = ScreenSize.height * 0.84;
  double? maxWidth;

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
    height = ScreenSize.height * 0.9;
    titleFontSize = 20;
    titleMarginBottom = 16;
    articleMarginBottom = 20;
    acceptMarginBottom = 20;
    declineFontSize = 14;
  }

  void _setMediumPhoneSizes() {
    height = ScreenSize.height * 0.9;
    titleFontSize = 22;
  }

  void _setTabletSizes() {
    height = ScreenSize.height * 0.7;
    maxWidth = 600;
  }
}
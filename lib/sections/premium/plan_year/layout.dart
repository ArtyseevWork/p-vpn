import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double buttonMaxWidth = 414;
  static const double buttonMarginBottom = 12;

  double contentWidth = 280;
  double iconWidth = 178;
  double iconMargin = 40;
  double titleFontSize = 22;
  double textFontSize = 22;
  double textMarginBottom = 40;
  double buttonMarginHorizontal = 40;

  double saluteHeight = ScreenSize.height * 0.4;
  double marginTop = ScreenSize.height * 0.2;

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
    contentWidth = 220;
    iconWidth = 112;
    iconMargin = 24;
    titleFontSize = 18;
    textFontSize = 18;
    textMarginBottom = 24;
    buttonMarginHorizontal = 24;
  }

  void _setMediumPhoneSizes() {
    textMarginBottom = 28;
  }

  void _setTabletSizes() {

  }
}
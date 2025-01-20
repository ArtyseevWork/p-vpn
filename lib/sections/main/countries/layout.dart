import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double countryListPadding = 24;
  static const double countryPaddingHorizontal = 24;
  static const double countryBorderRadius = 12;
  static const double countryIconHeight = 24;
  static const double countryIconMargin = 16;
  static const double countryBorderWidth = 2;
  static const double countryMoreTextMargin = 10;
  static const double loaderIconHeight = 24;
  static const double trafficIconHeight = 16;
  static const double premiumIconHeight = 24;

  double titleMargin = 40;
  double titleFontSize = 24;
  double countryHeight = 56;
  double countryDividerHeight = 16;
  double countryFontSize = 20;
  double countryMoreFontSize = 12;

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
    titleMargin = 24;
    titleFontSize = 20;
    countryHeight = 48;
    countryDividerHeight = 12;
    countryFontSize = 16;
    countryMoreFontSize = 11;
  }

  void _setMediumPhoneSizes() {
    titleMargin = 32;
    titleFontSize = 22;
    countryFontSize = 18;
  }

  void _setTabletSizes() {

  }
}
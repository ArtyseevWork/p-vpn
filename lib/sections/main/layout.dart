import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double stagePaddingHorizontal = 24;
  static const double todoFontSize = 14;
  static const double todoMarginBottom = 4;
  static const double switchBorderWidth = 3;
  static const double trafficValueLineHeight = 1.2;
  static const double trafficIconMargin = 20;
  static const double trafficMarginBottom = 16;
  static const double countryHeight = 48;
  static const double countryPaddingHorizontal = 24;
  static const double countryBorderRadius = 12;
  static const double countryIconHeight = 24;
  static const double countryIconMargin = 16;
  static const double sideMenuMarginTop = 20;
  static const double sideMenuItemHeight = 64;
  static const double sideMenuIconHeight = 20;
  static const double sideMenuIconMargin = 16;
  static const double sideMenuTextMargin = 12;
  static const double premiumMarginLeft = 16;
  static const double premiumBgMargin = 4;
  static const double premiumIconSize = 72;
  static const double premiumTextMargin = 18;
  static const double premiumLineHeight = 1.4;

  double earthMarginTop = 56;
  double earthMarginBottom = 56;
  double earthHeight = 164;
  double stageFontSize = 24;
  double stageLetterSpacing = 0;
  double stageMarginBottom = 32;
  double switchWidth = 204;
  double switchHeight = 96;
  double switchIconWidth = 46;
  double switchMarginBottom = 48;
  double trafficWidth = 366;
  double trafficHeight = 60;
  double trafficValueFontSize = 24;
  double trafficDetailsFontSize = 14;
  double trafficIconHeight = 24;
  double countryWidth = 302;
  double countryFontSize = 20;
  double sideMenuWidth = 308;
  double sideMenuFontSize = 22;
  double premiumWidth = 348;
  double premiumMarginBottom = 120;
  double premiumFontSize = 16;
  double animatedEarthHeight = 0;
  double animatedEarthMarginTop = 0;
  double animatedEarthMarginBottom = 0;

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
    stageLetterSpacing = stageFontSize * 0.03;
    animatedEarthHeight = earthHeight * 1.18;
    animatedEarthMarginTop = earthMarginTop - earthHeight * 0.07;
    animatedEarthMarginBottom = earthMarginBottom - earthHeight * 0.11;
  }

  void _setSmallPhoneSizes() {
    earthMarginTop = 24;
    earthMarginBottom = 24;
    earthHeight = 96;
    stageFontSize = 20;
    stageMarginBottom = 24;
    switchWidth = 136;
    switchHeight = 64;
    switchIconWidth = 32;
    switchMarginBottom = 40;
    trafficWidth = 270;
    trafficHeight = 54;
    trafficValueFontSize = 20;
    trafficDetailsFontSize = 12;
    trafficIconHeight = 22;
    countryWidth = 270;
    countryFontSize = 16;
    sideMenuWidth = 268;
    sideMenuFontSize = 20;
    premiumWidth = 308;
    premiumMarginBottom = 60;
    premiumFontSize = 14;
  }

  void _setMediumPhoneSizes() {
    earthMarginTop = 36;
    earthMarginBottom = 36;
    earthHeight = 130;
    stageFontSize = 22;
    switchWidth = 174;
    switchHeight = 82;
    switchIconWidth = 42;
    switchMarginBottom = 42;
    trafficWidth = 300;
    trafficHeight = 56;
    trafficValueFontSize = 20;
    trafficDetailsFontSize = 14;
    trafficIconHeight = 22;
    countryWidth = 294;
  }

  void _setTabletSizes() {
    earthMarginTop = 84;
    earthHeight = 182;
    stageMarginBottom = 40;
    switchMarginBottom = 56;
    sideMenuWidth = 364;
  }
}
import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double contentPadding = 24;
  static const double contentMaxWidth = 414;
  static const double titleBgMargin = 4;
  static const double titleContentMargin = 7;
  static const double titleTextLineHeight = 1.2;
  static const double tariffSwitchBorderWidth = 2;
  static const double tariffSwitchCircleMargin = 3;

  double marginTop = 24;
  double marginBig = 40;
  double marginSmall = 16;
  double titleIconSize = 72;
  double titleTextFontSize = 22;
  double titleDescriptionFontSize = 14;
  double adIconHeight = 40;
  double adIconPadding = 6;
  double adIconMargin = 2;
  double adTextFontSize = 21;
  double adDescriptionFontSize = 14;
  double tariffPaddingVertical = 12;
  double tariffPaddingHorizontal = 16;
  double tariffBorderRadius = 12;
  double tariffTextFontSize = 20;
  double tariffDescriptionFontSize = 14;
  double tariffSwitchWidth = 42;
  double tariffSwitchHeight = 24;
  double tariffSwitchCircleSize = 0;

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
    tariffSwitchCircleSize = tariffSwitchHeight
      - 2 * tariffSwitchBorderWidth
      - 2 * tariffSwitchCircleMargin;
  }

  void _setSmallPhoneSizes() {
    marginTop = 4;
    marginBig = 24;
    marginSmall = 12;
    titleIconSize = 62;
    titleTextFontSize = 20;
    titleDescriptionFontSize = 11;
    adIconHeight = 28;
    adIconPadding = 2;
    adIconMargin = 5;
    adTextFontSize = 18;
    adDescriptionFontSize = 11;
    tariffPaddingVertical = 10;
    tariffPaddingHorizontal = 14;
    tariffBorderRadius = 10;
    tariffTextFontSize = 18;
    tariffDescriptionFontSize = 11;
    tariffSwitchWidth = 35;
    tariffSwitchHeight = 20;
  }

  void _setMediumPhoneSizes() {
    marginTop = 14;
    marginBig = 28;
    titleIconSize = 64;
    titleTextFontSize = 20;
    adIconHeight = 34;
    adIconPadding = 2;
    adIconMargin = 2;
    adTextFontSize = 18;
  }

  void _setTabletSizes() {
    marginTop = 60;
  }
}
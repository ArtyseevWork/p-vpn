import 'package:pvpn/util/screen_size.dart';

class Layout {
  double appButtonHeight = 60;
  double appButtonFontSize = 24;

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
    appButtonHeight = 48;
    appButtonFontSize = 20;
  }

  void _setMediumPhoneSizes() {
    appButtonFontSize = 22;
  }

  void _setTabletSizes() {

  }
}
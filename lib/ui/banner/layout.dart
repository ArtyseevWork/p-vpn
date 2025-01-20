import 'package:pvpn/util/screen_size.dart';

class Layout {
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

  }

  void _setMediumPhoneSizes() {

  }

  void _setTabletSizes() {

  }
}
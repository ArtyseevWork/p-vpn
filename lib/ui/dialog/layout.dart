import 'package:pvpn/util/screen_size.dart';

class Layout {
  static const double maxWidth = 382;
  static const double marginHorizontal = 24;
  static const double borderRadius = 12;

  double paddingVertical = 32;
  double paddingHorizontal = 24;
  double borderWidth = 3;
  double iconCloseSize = 36;
  double iconClosePadding = 10;

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
    paddingVertical = 20;
    paddingHorizontal = 16;
    borderWidth = 2;
    iconCloseSize = 30;
    iconClosePadding = 8;
  }

  void _setMediumPhoneSizes() {
    iconCloseSize = 30;
    iconClosePadding = 8;
  }

  void _setTabletSizes() {

  }
}
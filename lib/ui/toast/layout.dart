import 'package:pvpn/util/screen_size.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';

class Layout {
  static const double _minMargin = 24;
  static const double _maxWidth = 420;
  static const double _systemPadding = 14;

  static const double fontSize = 20;
  static const double borderRadius = 16;
  static const double paddingHorizontal = 10;
  static const double countdownSize = 16;

  double marginHorizontal = _minMargin;
  double marginBottom = ScreenSize.height - TopBarUI().height -
    (2 * _systemPadding + fontSize) - _minMargin;

  Layout() {
    if (ScreenSize.width > _maxWidth + 2 * _minMargin) {
      marginHorizontal = (ScreenSize.width - _maxWidth) / 2;
    }
  }
}
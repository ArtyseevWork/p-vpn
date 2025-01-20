import 'dart:math';

import 'package:pvpn/util/screen_size.dart';
import 'package:pvpn/util/app.dart';

class Layout {
  double logoWidth = 0;

  Layout() {
    logoWidth = min(ScreenSize.width, Sizes.phoneMaxWidth) * 0.6;
  }
}
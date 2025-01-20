import 'package:flutter/cupertino.dart';

import 'app.dart';

class ScreenSize {
  static late double width;
  static late double height;
  static late double ratio;

  static void init(MediaQueryData media) {
    Size size = media.size;
    EdgeInsets padding = media.padding;
    width = size.width;
    height = size.height - padding.top - padding.bottom;
    ratio = width / height;
  }

  static bool isTablet() =>
    width > Sizes.phoneMaxWidth;

  static bool isMediumPhone() =>
    (width < Sizes.phoneBigWidth ||
    height < Sizes.phoneBigHeight) &&
    width >= Sizes.phoneMediumWidth &&
    height >= Sizes.phoneMediumHeight;

  static bool isSmallPhone() =>
    width < Sizes.phoneMediumWidth ||
    height < Sizes.phoneMediumHeight;
}
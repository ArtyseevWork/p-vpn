import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/util/app_rate.dart';
import 'package:pvpn/ui/dialog/widgets.dart';

import 'layout.dart';

class DialogRate {
  final Layout _layout = Layout();

  Widget get({
    required VoidCallback onClose,
  }) => DialogUI().get(
    content: _content(onClose),
    onClose: onClose,
  );

  Widget _content(VoidCallback onClose) => Column(
    children: [
      SizedBox(height: _layout.marginVertical),
      _title,
      SizedBox(height: _layout.titleMarginBottom),
      _rateButton(onClose),
      SizedBox(height: _layout.marginVertical),
    ],
  );

  Widget _rateButton(VoidCallback onClose) => GestureDetector(
    onTap: () {
      AppRate.openAppPage();
      onClose();
    },
    behavior: HitTestBehavior.translucent,
    child: Column(
      children: [
        _stars,
        SizedBox(height: _layout.starsMarginBottom),
        _todo,
      ],
    ),
  );

  Widget get _title => Text(
    Localizer.get('rate_title'),
    style: TextStyle(
      fontSize: _layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get _stars => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _star('filled'),
      _star('filled'),
      _star('filled'),
      _star('empty'),
      _star('empty'),
    ],
  );

  Widget _star(String type) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: _layout.starMargin,
    ),
    child: SvgPicture.asset('assets/images/icons/star_$type.svg',
      width: _layout.starWidth,
    ),
  );

  Widget get _todo => Text(
    Localizer.get('rate_todo'),
    style: const TextStyle(
      fontSize: Layout.todoFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
}
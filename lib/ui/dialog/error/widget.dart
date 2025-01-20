import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/ui/general/widgets.dart';
import 'package:pvpn/ui/dialog/widgets.dart';

import 'layout.dart';

class DialogError {
  final Layout _layout = Layout();

  Widget get({
    required VoidCallback onClose,
  }) => DialogUI().get(
    content: _content(onClose),
  );

  Widget _content(VoidCallback onClose) => Column(
    children: [
      Row(
        children: [
          SvgPicture.asset('assets/images/error.svg',
            width: _layout.iconSize,
            height: _layout.iconSize,
          ),
          SizedBox(width: _layout.iconMargin),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title,
              SizedBox(height: _layout.titleMargin),
              _text,
            ],
          ),
        ],
      ),
      SizedBox(height: _layout.marginBottom),
      UI().appButton(
        name: 'dialog_error_button',
        action: onClose,
      ),
    ],
  );

  Widget get _title => Text(
    Localizer.get('dialog_error_title'),
    style: TextStyle(
      fontSize: _layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get _text => Text(
    Localizer.get('dialog_error_text'),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      height: Layout.textLineHeight,
      fontSize: _layout.textFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
}

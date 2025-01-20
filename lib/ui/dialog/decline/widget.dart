import 'package:flutter/material.dart';

import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/ui/general/widgets.dart';
import 'package:pvpn/ui/dialog/widgets.dart';

import 'layout.dart';

class DialogDecline {
  final Layout _layout = Layout();

  Widget get({
    required VoidCallback onClose,
    required VoidCallback onOk,
  }) => DialogUI().get(
    content: _content(onOk),
    onClose: onClose,
  );

  Widget _content(
    VoidCallback onOk
  ) => Column(
    children: [
      SizedBox(height: _layout.textMarginTop),
      _text,
      SizedBox(height: _layout.textMarginBottom),
      UI().appButton(
        name: 'dialog_decline_button',
        action: onOk,
      ),
    ],
  );

  Widget get _text => Text(
    Localizer.get('dialog_decline_text'),
    textAlign: TextAlign.center,
    style: TextStyle(
      height: Layout.textLineHeight,
      fontSize: _layout.textFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
}
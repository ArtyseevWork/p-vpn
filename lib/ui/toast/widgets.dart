import 'package:flutter/material.dart';

import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/values/colors.dart';
import 'package:pvpn/ui/countdown.dart';

import 'layout.dart';

class ToastUI {
  final Layout _layout = Layout();

  void show(BuildContext context, {
    required String text,
    int duration = 5,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      _build(text, duration),
    );
  }

  SnackBar _build(String text, int duration) => SnackBar(
    margin: EdgeInsets.only(
      left: _layout.marginHorizontal,
      right: _layout.marginHorizontal,
      bottom: _layout.marginBottom,
    ),
    backgroundColor: clrToastBackground,
    dismissDirection: DismissDirection.none,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Layout.borderRadius)
      )
    ),
    content: _content(text, duration),
    duration: Duration(seconds: duration),
  );

  Widget _content(String text, int duration) => Row(
    children: [
      _message(text),
      const Spacer(),
      Countdown(
        seconds: duration,
        size: Layout.countdownSize,
      )
    ],
  );

  Widget _message(String text) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: Layout.paddingHorizontal,
    ),
    child: Text(
      Localizer.get(text),
      style: const TextStyle(
        height: 1,
        fontSize: Layout.fontSize,
        fontWeight: FontWeight.w500,
        color: clrToastText,
      ),
    ),
  );
}
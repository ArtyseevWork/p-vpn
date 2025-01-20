import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:pvpn/values/colors.dart';
import 'package:pvpn/values/strings/localizer.dart';

import 'layout.dart';

class UI {
  final Layout _layout = Layout();

  static Widget get background => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          clrBackgroundTop,
          clrBackgroundBottom,
        ],
      ),
    )
  );

  static Widget get darkenedScreen => Container(
    color: clrDarkenedScreen,
  );

  static Widget get blurredScreen => BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: darkenedScreen,
  );

  Widget appButton({
    required String name,
    required VoidCallback action,
  }) => GestureDetector(
    onTap: action,
    child: Container(
      alignment: Alignment.center,
      height: _layout.appButtonHeight,
      decoration: BoxDecoration(
        color: clrAppButton,
        borderRadius: BorderRadius.circular(
          _layout.appButtonHeight / 2
        ),
      ),
      child: Text(
        Localizer.get(name),
        style: TextStyle(
          fontSize: _layout.appButtonFontSize,
          fontWeight: FontWeight.w500,
          color: clrAppButtonText,
        ),
      ),
    ),
  );
}
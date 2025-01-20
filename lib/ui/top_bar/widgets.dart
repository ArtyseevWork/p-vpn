import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pvpn/util/premium.dart';
import 'package:pvpn/values/colors.dart';
import 'package:pvpn/values/strings/localizer.dart';

import 'layout.dart';

class TopBarUI {
  final Layout _layout = Layout();
  double get height => Layout.height;

  Widget container({
    required List<Widget> children,
  }) {
    return Container(
      height: Layout.height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: Layout.padding,
      ),
      decoration: _decoration,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset('assets/images/logo.svg',
            height: _layout.logoHeight,
          ),
          Row(children: children),
        ],
      ),
    );
  }

  Widget transparent({
    required List<Widget> children,
  }) {
    return Container(
      height: Layout.height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: Layout.padding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  BoxDecoration get _decoration => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        clrTopBarLeft,
        clrTopBarRight,
      ],
    ),
  );

  Widget icon({
    required String icon,
    required VoidCallback action,
  }) => GestureDetector(
    onTap: action,
    behavior: HitTestBehavior.translucent,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Layout.iconPadding
      ),
      child: SvgPicture.asset('assets/images/icons/$icon.svg',
        width:  Layout.height,
        height: Layout.height,
      ),
    ),
  );

  Widget buttonPremium({required VoidCallback action}) {
    if (Premium.isFreePlan) {
      return icon(
        icon: 'premium',
        action: action,
      );
    }
    return _premium(action);
  }

  Widget get premium => _premium(() => {});

  Widget _premium(VoidCallback action) => GestureDetector(
    onTap: action,
    behavior: HitTestBehavior.translucent,
    child: Container(
      height: _layout.premiumHeight,
      margin: const EdgeInsets.symmetric(
        horizontal: Layout.premiumMargin,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _layout.premiumPadding,
      ),
      decoration: _premiumDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _premiumText,
          SizedBox(width: _layout.premiumTextMargin),
          _premiumIcon,
        ],
      ),
    ),
  );

  BoxDecoration get _premiumDecoration => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        clrPremiumBgLeft,
        clrPremiumBgRight,
      ],
    ),
    border: Border.all(color: clrPremiumBorder),
    borderRadius: BorderRadius.circular(
      _layout.premiumHeight / 2,
    ),
  );

  Widget get _premiumText => Text(
    Localizer.get('premium_button'),
    style: TextStyle(
      fontSize: _layout.premiumFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget get _premiumIcon => SvgPicture.asset(
    'assets/images/icons/more_premium.svg',
    height: _layout.premiumIconHeight,
  );
}
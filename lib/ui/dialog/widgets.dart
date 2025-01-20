import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'package:pvpn/values/colors.dart';

import '../general/widgets.dart';
import 'layout.dart';

class DialogUI {
  final Layout _layout = Layout();

  Widget get({
    required Widget content,
    bool blurBackground = true,
    double? height,
    double? maxWidth,
    VoidCallback? onClose,
  }) => Stack(
    children: [
      if (blurBackground)
        UI.blurredScreen,
      Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height,
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? Layout.maxWidth,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: Layout.marginHorizontal,
              ),
              decoration: _decoration,
              child: _content(
                content: content,
                onClose: onClose,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  BoxDecoration get _decoration => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        clrDialogBgLeft,
        clrDialogBgRight,
      ],
    ),
    border: GradientBoxBorder(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          clrDialogBorderTop,
          clrDialogBorderBottom,
        ],
      ),
      width: _layout.borderWidth,
    ),
    borderRadius: BorderRadius.circular(
      Layout.borderRadius
    ),
  );

  Widget _content({
    required Widget content,
    VoidCallback? onClose,
  }) => Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
          vertical: _layout.paddingVertical,
          horizontal: _layout.paddingHorizontal,
        ),
        child: content,
      ),
      if (onClose != null)
        _iconClose(onClose),
    ],
  );

  Widget _iconClose(
    VoidCallback onClose
  ) => GestureDetector(
    onTap: onClose,
    behavior: HitTestBehavior.translucent,
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: _layout.iconClosePadding,
        horizontal: _layout.iconClosePadding,
      ),
      child: SvgPicture.asset('assets/images/icons/close.svg',
        width:  _layout.iconCloseSize,
        height: _layout.iconCloseSize,
      ),
    ),
  );
}
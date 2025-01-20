import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pvpn/router.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/util/premium.dart';
import 'package:pvpn/ui/general/widgets.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';
import 'package:pvpn/ui/toast/widgets.dart';

import '../plan_year/page.dart';
import 'layout.dart';

class PlanMonthPage extends StatefulWidget {
  const PlanMonthPage({super.key});

  @override
  State<PlanMonthPage> createState() => _PlanMonthPageState();
}

class _PlanMonthPageState extends State<PlanMonthPage> {
  Layout layout = Layout();
  TopBarUI topBarUI = TopBarUI();
  ToastUI toastUI = ToastUI();

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void onUpgradePlan() {
    Premium.tariffPlan = Premium.planYear;
    AppRouter.replace(context, const PlanYearPage());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              topBar,
              Stack(
                children: [
                  content,
                  info,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get topBar => topBarUI.container(
    children: [
      topBarUI.icon(
        icon: 'arrow_back',
        action: () => Navigator.pop(context),
      ),
      const Spacer(),
      topBarUI.premium,
    ],
  );

  Widget get content => Column(
    children: [
      SizedBox(height: layout.iconMarginTop),
      icon,
      SizedBox(height: layout.iconMarginBottom),
      buttonUpgrade,
      const SizedBox(height: Layout.buttonMarginBottom),
      hint,
    ],
  );

  Widget get icon => Row(
    children: [
      SvgPicture.asset('assets/images/psst.svg',
        width: layout.iconWidth,
      ),
      const Spacer(),
    ],
  );

  Widget get buttonUpgrade => Container(
    constraints: const BoxConstraints(
      maxWidth: Layout.buttonMaxWidth,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: layout.buttonMarginHorizontal,
    ),
    child: UI().appButton(
      name: 'plan_month_button',
      action: onUpgradePlan,
    ),
  );

  Widget get hint => Text(
    Localizer.get('plan_month_hint'),
    style: const TextStyle(
      fontSize: Layout.hintFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget get info => Positioned(
    top: layout.infoMarginTop,
    left: layout.infoMarginLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: Layout.titleMarginBottom),
        text,
      ],
    ),
  );

  Widget get title => Text(
    Localizer.get('plan_month_title'),
    style: TextStyle(
      height: Layout.titleLineHeight,
      fontSize: layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get text => SizedBox(
    width: Layout.textWidth,
    child: Text(
      Localizer.get('plan_month_text'),
      style: const TextStyle(
        height: Layout.textLineHeight,
        fontSize: Layout.textFontSize,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pvpn/router.dart';
import 'package:pvpn/sections/main/page.dart';

import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/ui/general/widgets.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';

import 'layout.dart';

class PlanYearPage extends StatefulWidget {
  const PlanYearPage({super.key});

  @override
  State<PlanYearPage> createState() => _PlanYearPageState();
}

class _PlanYearPageState extends State<PlanYearPage> {
  Layout layout = Layout();
  TopBarUI topBarUI = TopBarUI();

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void onGoHome() {
    AppRouter.restart(context, const MainPage());
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
                alignment: Alignment.topCenter,
                children: [
                  salute,
                  content,
                ],
              ),
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

  Widget get salute => SvgPicture.asset(
    'assets/images/salute.svg',
    height: layout.saluteHeight,
    fit: BoxFit.cover,
  );

  Widget get content => Column(
    children: [
      SizedBox(
        width: layout.contentWidth,
        child: Column(
          children: [
            SizedBox(height: layout.marginTop),
            title,
            SizedBox(height: layout.iconMargin),
            icon,
            SizedBox(height: layout.iconMargin),
            text,
            SizedBox(height: layout.textMarginBottom),
          ]
        ),
      ),
      buttonHome,
    ],
  );

  Widget get title => Text(
    Localizer.get('plan_year_title'),
    style: TextStyle(
      fontSize: layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get icon => SvgPicture.asset(
    'assets/images/premium.svg',
    width: layout.iconWidth,
  );

  Widget get text => Text(
    Localizer.get('plan_year_text'),
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: layout.textFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get buttonHome => Container(
    constraints: const BoxConstraints(
      maxWidth: Layout.buttonMaxWidth,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: layout.buttonMarginHorizontal,
    ),
    child: UI().appButton(
      name: 'plan_year_button',
      action: onGoHome,
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pvpn/router.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/values/colors.dart';
import 'package:pvpn/util/premium.dart';
import 'package:pvpn/ui/general/widgets.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';
import 'package:pvpn/ui/toast/widgets.dart';

import '../../main/page.dart';
import 'layout.dart';

class PlanFreePage extends StatefulWidget {
  const PlanFreePage({super.key});

  @override
  State<PlanFreePage> createState() => _PlanFreePageState();
}

class _PlanFreePageState extends State<PlanFreePage> {
  Layout layout = Layout();
  TopBarUI topBarUI = TopBarUI();
  ToastUI toastUI = ToastUI();
  int selectedPlan = Premium.planMonth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void onClose() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      AppRouter.restart(context, const MainPage());
    }
  }

  void onGetPremium() {
    Premium.tariffPlan = selectedPlan;
    toastUI.show(context, text: 'toast_tariff_has_changed');
    onClose();
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
              SizedBox(height: layout.marginTop),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: Layout.contentMaxWidth,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: Layout.contentPadding,
                ),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get topBar => topBarUI.transparent(
    children: [
      const Spacer(),
      topBarUI.icon(
        icon: 'close',
        action: onClose,
      ),
    ]
  );

  Widget get content => Column(
    children: [
      title,
      marginBig,
      adItem(
        icon: 'premium_ad_one',
        text: 'premium_ad_one_text',
        description: 'premium_ad_one_description',
      ),
      marginSmall,
      adItem(
        icon: 'premium_ad_two',
        text: 'premium_ad_two_text',
        description: 'premium_ad_two_description',
      ),
      marginSmall,
      adItem(
        icon: 'premium_ad_three',
        text: 'premium_ad_three_text',
        description: 'premium_ad_three_description',
      ),
      marginBig,
      tariff(
        text: 'premium_plan_month_text',
        description: 'premium_plan_month_description',
        isSelected: selectedPlan == Premium.planMonth,
        onSelect: () => setState(() {
          selectedPlan = Premium.planMonth;
        }),
      ),
      marginSmall,
      tariff(
        text: 'premium_plan_year_text',
        description: 'premium_plan_year_description',
        isSelected: selectedPlan == Premium.planYear,
        onSelect: () => setState(() {
          selectedPlan = Premium.planYear;
        }),
      ),
      marginSmall,
      UI().appButton(
        name: 'premium_get',
        action: onGetPremium,
      ),
    ],
  );

  Widget get title => SizedBox(
    height: layout.titleIconSize,
    child: Stack(
      children: [
        titleBackground,
        titleContent,
      ],
    ),
  );

  Widget get titleBackground => Container(
    margin: const EdgeInsets.symmetric(
      vertical: Layout.titleBgMargin,
    ),
    decoration: titleDecoration,
  );

  BoxDecoration get titleDecoration => BoxDecoration(
    border: Border.all(color: clrPremiumBorder),
    borderRadius: BorderRadius.circular(
      layout.titleIconSize / 2
    ),
  );

  Widget get titleContent => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset('assets/images/icons/premium_get.svg',
        height: layout.titleIconSize,
      ),
      const SizedBox(width: Layout.titleContentMargin),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText,
          titleDescription,
        ],
      ),
    ],
  );

  Widget get titleText => Text(
    Localizer.get('premium_title_text'),
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      height: Layout.titleTextLineHeight,
      fontSize: layout.titleTextFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get titleDescription => Text(
    Localizer.get('premium_title_description'),
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: layout.titleDescriptionFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget adItem({
    required String icon,
    required String text,
    required String description,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          adIcon(icon),
          SizedBox(width: layout.adIconMargin),
          adText(text),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(
          left: layout.adIconHeight + layout.adIconMargin,
        ),
        child: adDescription(description),
      ),
    ],
  );

  Widget adIcon(String icon) => Container(
    width: layout.adIconHeight,
    height: layout.adIconHeight,
    padding: EdgeInsets.symmetric(
      vertical: layout.adIconPadding,
    ),
    child: SvgPicture.asset('assets/images/icons/$icon.svg'),
  );

  Widget adText(String text) => Text(
    Localizer.get(text),
    style: TextStyle(
      fontSize: layout.adTextFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget adDescription(String description) => Text(
    Localizer.get(description),
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: layout.adDescriptionFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget tariff({
    required String text,
    required String description,
    required bool isSelected,
    required VoidCallback onSelect,
  }) => GestureDetector(
    onTap: onSelect,
    behavior: HitTestBehavior.translucent,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: layout.tariffPaddingVertical,
        horizontal: layout.tariffPaddingHorizontal,
      ),
      decoration: tariffDecoration(isSelected),
      child: tariffContent(
        text: text,
        description: description,
        isSelected: isSelected,
      ),
    ),
  );

  BoxDecoration tariffDecoration(bool isSelected) => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        clrCountryBgLeft,
        clrCountryBgRight,
      ],
    ),
    border: tariffBorder(isSelected),
    borderRadius: BorderRadius.circular(
      layout.tariffBorderRadius
    ),
  );
  
  BoxBorder? tariffBorder(bool isSelected) {
    if (isSelected) {
      return Border.all(color: clrTariffBorder);
    }
    return null;
  }
  
  Widget tariffContent({
    required String text,
    required String description,
    required bool isSelected,
  }) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tariffText(text),
          tariffDescription(description),
        ],
      ),
      const Spacer(),
      tariffSwitch(isSelected),
    ],
  );

  Widget tariffText(String text) => Text(
    Localizer.get(text),
    style: TextStyle(
      fontSize: layout.tariffTextFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget tariffDescription(String description) => Text(
    Localizer.get(description),
    style: TextStyle(
      fontSize: layout.tariffDescriptionFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget tariffSwitch(bool isSelected) => Container(
    width: layout.tariffSwitchWidth,
    height: layout.tariffSwitchHeight,
    alignment: isSelected ? Alignment.centerRight : Alignment.centerLeft,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: Layout.tariffSwitchBorderWidth,
      ),
      borderRadius: BorderRadius.circular(
        layout.tariffSwitchHeight / 2
      ),
    ),
    child: Container(
      width: layout.tariffSwitchCircleSize,
      height: layout.tariffSwitchCircleSize,
      margin: const EdgeInsets.all(
        Layout.tariffSwitchCircleMargin
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? clrAppButton : Colors.white,
      ),
    ),
  );

  Widget get marginBig => SizedBox(height: layout.marginBig);
  Widget get marginSmall => SizedBox(height: layout.marginSmall);
}
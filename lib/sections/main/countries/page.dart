import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'package:pvpn/core/mvvm/observer.dart';
import 'package:pvpn/router.dart';
import 'package:pvpn/values/colors.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/util/app.dart';
import 'package:pvpn/util/app_state.dart';
import 'package:pvpn/util/premium.dart';
import 'package:pvpn/util/screen_size.dart';
import 'package:pvpn/util/ad_helper.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';
import 'package:pvpn/ui/banner/widgets.dart';

import '../view_model.dart';
import '../model.dart';
import 'layout.dart';

class CountriesPage extends StatefulWidget {
  final MainViewModel model;

  const CountriesPage({
    super.key,
    required this.model,
  });

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> implements EventObserver {
  Layout layout = Layout();
  TopBarUI topBarUI = TopBarUI();
  List<String> countries = [];
  //BannerAd? _bannerAd;
  //bool _bannerAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    widget.model.subscribe(this);
    countries = widget.model.countries;
    notify();
    //if (Premium.isFreePlan) {
    //  showBannerAd();
    //}
  }

  @override
  void deactivate() {
    widget.model.unsubscribe(this);
    super.deactivate();
  }

  @override
  void dispose() {
    //_bannerAd?.dispose();
    super.dispose();
  }

  @override
  void notify() {
    setState(() {});
  }

  void onSmartLocation() {
    if (widget.model.onSmartLocation()) {
      Navigator.pop(context);
    }
  }

  void connectTo(int countryIndex) {
    if (widget.model.connectTo(countryIndex)) {
      Navigator.pop(context);
    }
  }
/*
  void showBannerAd() {
    _bannerAd = AdHelper().getBannerAd();
    if (_bannerAd != null) {
      setState(() {
        _bannerAdIsLoaded = true;
      });
      return;
    }
    if (!VpnAppState.connected) {
      _loadBannerAd();
    }
  }

  void _loadBannerAd() async {
    AdSize? adSize = await
    AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      ScreenSize.width.truncate()
    );

    adSize ??= ScreenSize.isTablet()
      ? AdSize.largeBanner
      : AdSize.banner;

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: adSize,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }
*/
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
              titleMargin,
              title,
              titleMargin,
              countryList,
              //if (Premium.isFreePlan && _bannerAdIsLoaded && _bannerAd != null)
              //  BannerUI.get(_bannerAd!),
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
      if (Options.showInAppPurchases) topBarUI.buttonPremium(
        action: () => AppRouter.push(context,
          page: Premium.getTariffPlanPage(),
          callback: notify,
        ),
      ),
    ]
  );

  Widget get title => Text(
    Localizer.get('countries_title'),
    style: TextStyle(
      fontSize: layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get countryList => Expanded(
    child: Container(
      constraints: const BoxConstraints(
        maxWidth: Sizes.contentMaxWidth
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Layout.countryListPadding
      ),
      child: ListView.separated(
        padding: EdgeInsets.only(
          bottom: layout.countryDividerHeight,
        ),
        itemCount: countries.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return countryItem(index - 1);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: layout.countryDividerHeight
          );
        }
      ),
    ),
  );

  Widget countryItem(int index) {
    if (MainModel.countryIsSmart(index)) {
      return smartLocation;
    }
    if (MainModel.countryIsPremium(index)) {
      return premiumCountry(index);
    }
    if (index == widget.model.countryIndex) {
      return activeCountry(index);
    }
    return defaultCountry(index);
  }

  Widget activeCountry(int index) {
    if (widget.model.connected) {
      return connectedCountry(index);
    }
    if (widget.model.connecting) {
      return connectingCountry(index);
    }
    if (widget.model.disconnecting) {
      return disconnectingCountry(index);
    }
    return defaultCountry(index);
  }

  Widget get smartLocation => country(
    onTap: onSmartLocation,
    decoration: decorationDefault,
    icon: smartLocationIcon,
    name: 'smart_location',
  );

  Widget defaultCountry(int index) => country(
    onTap: () => connectTo(index),
    decoration: decorationDefault,
    icon: countryFlagIcon(countries[index]),
    name: '${countries[index]}_name',
  );

  Widget premiumCountry(int index) => country(
    onTap: () => AppRouter.push(context,
      page: Premium.getTariffPlanPage(),
      callback: notify,
    ),
    decoration: decorationDefault,
    icon: countryFlagIcon(countries[index]),
    name: '${countries[index]}_name',
    moreIcon: 'more_premium',
    moreIconHeight: Layout.premiumIconHeight,
  );

  Widget connectedCountry(int index) => country(
    onTap: widget.model.onDisconnect,
    decoration: decorationConnected,
    icon: countryFlagIcon(countries[index]),
    name: '${countries[index]}_name',
    moreText: 'countries_connected',
    moreIcon: 'traffic',
    moreIconHeight: Layout.trafficIconHeight,
  );

  Widget connectingCountry(int index) => country(
    onTap: widget.model.onDisconnect,
    decoration: decorationProcessing,
    icon: countryFlagIcon(countries[index]),
    name: '${countries[index]}_name',
    moreText: 'countries_connecting',
    moreIcon: 'loader',
    moreIconHeight: Layout.loaderIconHeight,
  );

  Widget disconnectingCountry(int index) => country(
    onTap: () => {},
    decoration: decorationProcessing,
    icon: countryFlagIcon(countries[index]),
    name: '${countries[index]}_name',
    moreText: 'countries_disconnecting',
    moreIcon: 'loader',
    moreIconHeight: Layout.loaderIconHeight,
  );

  Widget country({
    required VoidCallback onTap,
    required BoxDecoration decoration,
    required Widget icon,
    required String name,
    String moreText = '',
    String moreIcon = '',
    double moreIconHeight = 0,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: layout.countryHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: Layout.countryPaddingHorizontal
      ),
      decoration: decoration,
      child: Row(
        children: [
          icon,
          countryIconMargin,
          countryName(name),
          const Spacer(),
          if (moreText.isNotEmpty) ...[
            countryMoreText(moreText),
            countryMoreTextMargin,
          ],
          if (moreIcon.isNotEmpty) SvgPicture.asset(
            'assets/images/icons/$moreIcon.svg',
            height: moreIconHeight,
          ),
        ],
      ),
    ),
  );

  BoxDecoration get decorationDefault => countryDecoration(
    colorLeft: clrCountryBgLeft,
    colorRight: clrCountryBgRight,
  );

  BoxDecoration get decorationConnected => countryDecoration(
    colorLeft: clrConnectedBgLeft,
    colorRight: clrConnectedBgRight,
  );

  BoxDecoration get decorationProcessing => countryDecoration(
    colorLeft: clrProcessingBgLeft,
    colorRight: clrProcessingBgRight,
    border: processingBorder,
  );

  BoxDecoration countryDecoration({
    required Color colorLeft,
    required Color colorRight,
    BoxBorder? border,
  }) => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        colorLeft,
        colorRight,
      ],
    ),
    border: border,
    borderRadius: BorderRadius.circular(
      Layout.countryBorderRadius
    ),
  );

  GradientBoxBorder get processingBorder {
    return const GradientBoxBorder(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomLeft,
        colors: [
          clrCountryBorderTop,
          clrCountryBorderBottom,
        ],
      ),
      width: Layout.countryBorderWidth,
    );
  }

  Widget get smartLocationIcon => SvgPicture.asset(
    'assets/images/icons/web.svg',
    height: Layout.countryIconHeight,
  );

  Widget countryFlagIcon(String country) => Image.asset(
    'assets/images/flags/$country.png',
    height: Layout.countryIconHeight,
  );

  Widget countryName(String name) => Text(
    Localizer.get(name),
    style: TextStyle(
      fontSize: layout.countryFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget countryMoreText(String text) => Text(
    Localizer.get(text),
    style: TextStyle(
      fontSize: layout.countryMoreFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget get titleMargin => SizedBox(height: layout.titleMargin);
  Widget get countryIconMargin => const SizedBox(width: Layout.countryIconMargin);
  Widget get countryMoreTextMargin => const SizedBox(width: Layout.countryMoreTextMargin);
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:pvpn/router.dart';
import 'package:pvpn/util/premium.dart';
import 'package:pvpn/util/app.dart';
//import 'package:pvpn/util/app_state.dart';
import 'package:pvpn/util/app_rate.dart';
//import 'package:pvpn/util/screen_size.dart';
//import 'package:pvpn/util/ad_helper.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';
//import 'package:pvpn/ui/banner/widgets.dart';

import 'layout.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  Layout layout = Layout();
  TopBarUI topBarUI = TopBarUI();
  //BannerAd? _bannerAd;
  //bool _bannerAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    //if (Premium.isFreePlan) {
    //  showBannerAd();
    //}
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    //_bannerAd?.dispose();
    super.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topBar,
            Expanded(child: content),
            //if (Premium.isFreePlan && _bannerAdIsLoaded && _bannerAd != null)
            //  BannerUI.get(_bannerAd!),
          ],
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
          callback: () => setState(() {}),
        ),
      ),
    ],
  );

  Widget get content => GestureDetector(
    onTap: AppRate.openAppPage,
    behavior: HitTestBehavior.translucent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title,
        SizedBox(height: layout.titleMarginBottom),
        stars,
        const SizedBox(height: Layout.starsMarginBottom),
        todo,
        SizedBox(height: layout.marginBottom),
      ],
    ),
  );

  Widget get title => Text(
    Localizer.get('rate_title'),
    style: TextStyle(
      fontSize: layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get stars => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      star('filled'),
      star('filled'),
      star('filled'),
      star('empty'),
      star('empty'),
    ],
  );

  Widget star(String type) => Container(
    margin: const EdgeInsets.symmetric(
      horizontal: Layout.starMargin,
    ),
    child: SvgPicture.asset('assets/images/icons/star_$type.svg',
      width: Layout.starWidth,
    ),
  );

  Widget get todo => Text(
    Localizer.get('rate_todo'),
    style: const TextStyle(
      fontSize: Layout.todoFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
}
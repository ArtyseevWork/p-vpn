//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';

import 'package:pvpn/core/mvvm/observer.dart';
import 'package:pvpn/router.dart';
import 'package:pvpn/sections/main/countries/page.dart';
import 'package:pvpn/sections/rate/page.dart';
//import 'package:pvpn/util/app_state.dart';
import 'package:pvpn/values/colors.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/util/app.dart';
import 'package:pvpn/util/premium.dart';
import 'package:pvpn/util/screen_size.dart';
//import 'package:pvpn/util/ad_helper.dart';
import 'package:pvpn/ui/general/widgets.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';
import 'package:pvpn/ui/dialog/error/widget.dart';
import 'package:pvpn/ui/dialog/rate/widget.dart';
import 'package:pvpn/ui/toast/widgets.dart';
//import 'package:pvpn/ui/banner/widgets.dart';

import '../article/page.dart';
import 'view_model.dart';
import 'layout.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
  with SingleTickerProviderStateMixin
  implements EventObserver
{
  static const double swipeSensitivity = 10;
  static const Duration swipeDuration = Duration(milliseconds: 200);
  static const Duration screenChangeDuration = Duration(milliseconds: 400);
  //static const Duration disconnectionDelay = Duration(milliseconds: 500);
  static const double screenMinOpacity = 0.4;

  late final AnimationController _switchOnController;
  final MainViewModel _model = MainViewModelSingleton().vm;
  Layout layout = Layout();
  TopBarUI topBarUI = TopBarUI();
  ToastUI toastUI = ToastUI();
  bool animationIsRunning = false;
  //BannerAd? _bannerAd;
  //bool _bannerAdIsLoaded = false;
  //bool _showInterstitialAd = true;

  @override
  void initState() {
    super.initState();
    _model.subscribe(this);
    _model.onLoad();
    _switchOnController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _switchOnController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _switchOnController.forward(from: 0);
      }
    });
    _switchOnController.addListener(() {
      setState(() {});
    });
    _switchOnController.forward();
 /*
    if (Premium.isFreePlan) {
      showBannerAd();
    }
 */
  }

  @override
  void deactivate() {
    _model.unsubscribe(this);
    _switchOnController.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    //_bannerAd?.dispose();
    super.dispose();
  }

  @override
  void notify() {
    if (_model.showConnectionError) {
      toastUI.show(context, text: 'toast_connection_error');
      _model.showConnectionError = false;
    }
/*
    if ((_model.connecting || _model.disconnecting)
      && _showInterstitialAd && Premium.isFreePlan
    ) {
      _showInterstitialAd = false;
      showInterstitialAd();
    }
    if (_model.connected || _model.disconnected) {
      _showInterstitialAd = true;
    }
*/
    setState(() {});
  }
/*
  void showInterstitialAd() {
    InterstitialAd? ad = AdHelper().getInterstitialAd();
    if (ad == null) {
      _loadInterstitialAd();
    } else {
      ad.show();
    }
  }

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

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {}
          );
          // Keep a reference to the ad so you can show it later.
          ad.show();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {},
      )
    );
  }
*/
  void onCountryButton() {
    _model.onCountryButton();
    AppRouter.push(context,
      page: CountriesPage(model: _model),
      callback: notify,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                topBar,
                Expanded(child: content),
              ],
            ),
          ),
          if (_model.showErrorDialog)
            DialogError().get(onClose: _model.onErrorClose),

          if (_model.showRateDialog)
            DialogRate().get(onClose: _model.onRateClose),
        ],
      ),
    );
  }

  Widget get topBar => topBarUI.container(
    children: [
      topBarUI.icon(
        icon: _model.showSideMenu ? 'close' : 'menu',
        action: _model.onToggleSideMenu,
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

  Widget get content => Stack(
    children: [
/*
      if (Premium.isFreePlan && _bannerAdIsLoaded && _bannerAd != null) Column(
        children: [
          const Spacer(),
          BannerUI.get(_bannerAd!),
        ],
      ),
*/
      animatedScreen(
        show: _model.disconnected,
        screen: screenDisconnected,
      ),
      animatedScreen(
        show: _model.connecting,
        screen: screenConnecting,
      ),
      animatedScreen(
        show: _model.connected,
        screen: screenConnected,
      ),
      animatedScreen(
        show: _model.disconnecting,
        screen: screenDisconnecting,
      ),
      if (_model.showSideMenu)
        blurredScreen,
      sideMenu,
    ],
  );

  Widget animatedScreen({
    required bool show,
    required Widget screen,
  }) => AnimatedOpacity(
    opacity: show ? 1 : screenMinOpacity,
    duration: screenChangeDuration,
    child: Visibility(
      visible: show,
      child: screen,
    ),
  );

  Widget get screenDisconnected => screenStableStage(
    earthImage: 'assets/images/off.svg',
    stage: 'main_disconnected',
    todo: 'main_connect',
    switchButton: switchButtonOff,
  );

  Widget get screenConnected => screenStableStage(
    earthImage: 'assets/images/on.svg',
    stage: 'main_connected',
    todo: 'main_disconnect',
    switchButton: switchButtonOn,
  );

  Widget get screenConnecting => screenProcessingStage(
    'main_connecting'
  );

  Widget get screenDisconnecting => screenProcessingStage(
    'main_disconnecting'
  );

  Widget get blurredScreen => Positioned(
    top: topBarUI.height,
    height: ScreenSize.height - topBarUI.height,
    child: UI.blurredScreen,
  );

  Widget screenStableStage({
    required String earthImage,
    required String stage,
    required String todo,
    required Widget switchButton,
  }) => Align(
    alignment: Alignment.topCenter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        earthMarginTop,
        SvgPicture.asset(earthImage,
          height: layout.earthHeight,
        ),
        earthMarginBottom,
        stageText(stage),
        stageMarginBottom,
        todoText(todo),
        todoMarginBottom,
        switchButton,
        switchMarginBottom,
        traffic,
        trafficMarginBottom,
        countryButton,
      ],
    ),
  );

  Widget get switchButtonOff => switchButton(
    onTap: _model.onConnect,
    decoration: switchOffDecoration,
    icon: 'assets/images/icons/switch_off.svg'
  );

  Widget get switchButtonOn => switchButton(
    onTap: () {
      _model.onDelayedDisconnect();
/*
      if (Premium.isFreePlan) {
        Timer(disconnectionDelay, () {
          showBannerAd();
        });
      }
*/
    },
    decoration: switchOnDecoration,
    icon: 'assets/images/icons/switch_on.svg'
  );

  Widget switchButton({
    required VoidCallback onTap,
    required BoxDecoration decoration,
    required String icon,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: layout.switchWidth,
      height: layout.switchHeight,
      alignment: Alignment.center,
      decoration: decoration,
      child: SvgPicture.asset(icon,
        width: layout.switchIconWidth,
      ),
    ),
  );

  BoxDecoration get switchOffDecoration => BoxDecoration(
    color: clrSwitchBgPassive,
    border: const GradientBoxBorder(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          clrSwitchBorderTop,
          clrSwitchBorderBottom,
        ],
      ),
      width: Layout.switchBorderWidth,
    ),
    borderRadius: BorderRadius.circular(
      layout.switchHeight / 2
    ),
  );

  BoxDecoration get switchOnDecoration => BoxDecoration(
    gradient: LinearGradient(
      colors: const [
        clrSwitchBgTop,
        clrSwitchBgBottom,
      ],
      transform: GradientRotation(_switchOnController.value * 6),
    ),
    border: Border.all(
      color: Colors.white,
      width: Layout.switchBorderWidth,
    ),
    borderRadius: BorderRadius.circular(
      layout.switchHeight / 2
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.75),
        spreadRadius: 1,
        blurRadius: 5,
      ),
    ],
  );

  Widget get traffic => SizedBox(
    height: layout.trafficHeight,
    width: layout.trafficWidth,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        trafficBlock(
          value: _model.trafficIn,
          details: 'main_traffic_in',
          icon: 'arrow_down',
        ),
        Container(
          width: 1,
          color: clrTrafficDivider,
        ),
        trafficBlock(
          value: _model.trafficOut,
          details: 'main_traffic_out',
          icon: 'arrow_up',
        ),
      ],
    ),
  );

  Widget trafficBlock({
    required String value,
    required String details,
    required String icon,
  }) => Container(
    height: layout.trafficHeight,
    width: layout.trafficWidth / 2 - 1,
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        trafficData(value, details),
        trafficIconMargin,
        SvgPicture.asset('assets/images/icons/$icon.svg',
          height: layout.trafficIconHeight,
        ),
      ],
    ),
  );

  Widget trafficData(String value, String details) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      trafficValue(value),
      trafficDetails(details),
    ],
  );

  Widget trafficValue(String value) => Text(value,
    style: TextStyle(
      height: Layout.trafficValueLineHeight,
      fontSize: layout.trafficValueFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget trafficDetails(String details) => Text(
    Localizer.get(details),
    style: TextStyle(
      fontSize: layout.trafficDetailsFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget get countryButton => GestureDetector(
    onTap: onCountryButton,
    child: Container(
      width: layout.countryWidth,
      height: Layout.countryHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: Layout.countryPaddingHorizontal
      ),
      decoration: countryButtonDecoration,
      child: _model.country.isEmpty ?
        smartLocation :
        currentCountry,
    ),
  );

  BoxDecoration get countryButtonDecoration => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        clrCountryBgLeft,
        clrCountryBgRight,
      ],
    ),
    borderRadius: BorderRadius.circular(
      Layout.countryBorderRadius
    ),
  );

  Widget get smartLocation => countryButtonContent(
    icon: smartLocationIcon,
    name: 'smart_location',
    opacity: 0.7,
  );

  Widget get currentCountry => countryButtonContent(
    icon: countryFlagIcon(_model.country),
    name: '${_model.country}_name',
    opacity: 1,
  );

  Widget countryButtonContent({
    required Widget icon,
    required String name,
    required double opacity,
  }) => Opacity(
    opacity: opacity,
    child: Row(
      children: [
        icon,
        countryIconMargin,
        countryName(name),
        const Spacer(),
        SvgPicture.asset('assets/images/icons/arrow_next.svg',
          height: Layout.countryIconHeight,
        ),
      ],
    ),
  );

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

  Widget screenProcessingStage(String stage) => Align(
    alignment: Alignment.topCenter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        animatedEarthMarginTop,
        SizedBox(
          height: layout.animatedEarthHeight,
          child: Lottie.asset('assets/animations/connection.json'),
        ),
        animatedEarthMarginBottom,
        stageText(stage),
      ],
    ),
  );

  Widget stageText(String name) => Text(
    Localizer.get(name),
    style: TextStyle(
      fontSize: layout.stageFontSize,
      fontWeight: FontWeight.w500,
      letterSpacing: layout.stageLetterSpacing,
      color: Colors.white,
    ),
  );

  Widget todoText(String todo) => Text(
    Localizer.get(todo),
    style: const TextStyle(
      fontSize: Layout.todoFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget get sideMenu => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onPanUpdate: (details) {
      if (animationIsRunning) {
        return;
      }
      if (details.delta.dx < -swipeSensitivity && _model.showSideMenu
       || details.delta.dx > swipeSensitivity && !_model.showSideMenu
      ) {
        animationIsRunning = true;
        _model.onToggleSideMenu();
      }
    },
    child: Stack(
      children: [
        AnimatedPositioned(
          duration: swipeDuration,
          left: _model.showSideMenu ? 0 : -layout.sideMenuWidth,
          onEnd: () => animationIsRunning = false,
          child: Container(
            width: layout.sideMenuWidth,
            height: ScreenSize.height - topBarUI.height,
            decoration: sideMenuDecoration,
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: clrSideMenuTopLine
                ),
                sideMenuMarginTop,
                sideMenuItemServer,
                if (Options.showInAppPurchases)
                  sideMenuItemTariff,
                sideMenuItemRate,
                sideMenuItemAbout,
                sideMenuItemTerms,
              ],
            ),
          ),
        ),
        if (Premium.isFreePlan && Options.showInAppPurchases)
          sideMenuPremium,
      ],
    ),
  );

  BoxDecoration get sideMenuDecoration => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        clrSideMenuBgLeft,
        clrSideMenuBgRight,
      ],
    ),
  );

  Widget get sideMenuItemServer => sideMenuItem(
    name: 'server',
    onTap: () {
      _model.onToggleSideMenu();
      _model.onCountryButton();
      AppRouter.push(context,
        page: CountriesPage(model: _model)
      );
    },
  );

  Widget get sideMenuItemTariff => sideMenuItem(
    name: 'tariff',
    onTap: () {
      _model.onToggleSideMenu();
      AppRouter.push(context,
        page: Premium.getTariffPlanPage(),
      );
    }
  );

  Widget get sideMenuItemRate => sideMenuItem(
    name: 'rate',
    onTap: () {
      _model.onToggleSideMenu();
      AppRouter.push(context,
        page: const RatePage(),
      );
    },
  );

  Widget get sideMenuItemAbout => sideMenuItem(
    name: 'about',
    onTap: () {
      _model.onToggleSideMenu();
      AppRouter.push(context,
        page: const ArticlePage(
          title: 'article_about_title',
          article: 'en_about',
        ),
      );
    }
  );

  Widget get sideMenuItemTerms => sideMenuItem(
    name: 'terms',
    onTap: () {
      _model.onToggleSideMenu();
      AppRouter.push(context,
        page: const ArticlePage(
          title: 'article_terms_title',
          article: 'en_terms',
        ),
      );
    },
  );

  Widget sideMenuItem({
    required String name,
    required VoidCallback onTap,
  }) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.translucent,
    child: SizedBox(
      height: Layout.sideMenuItemHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sideMenuIconMargin,
          SvgPicture.asset('assets/images/icons/menu_$name.svg',
            height: Layout.sideMenuIconHeight,
          ),
          sideMenuTextMargin,
          sideMenuText('main_menu_$name'),
        ],
      ),
    ),
  );

  Widget sideMenuText(String name) => Text(
    Localizer.get(name),
    overflow: TextOverflow.fade,
    style: TextStyle(
      fontSize: layout.sideMenuFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  Widget get sideMenuPremium => Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: EdgeInsets.only(
        left: Layout.premiumMarginLeft,
        bottom: layout.premiumMarginBottom,
      ),
      child: GestureDetector(
        onTap: () => AppRouter.push(context,
          page: Premium.getTariffPlanPage(),
          callback: _model.onToggleSideMenu,
        ),
        child: AnimatedScale(
          duration: swipeDuration,
          scale: _model.showSideMenu ? 1 : 0,
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: layout.premiumWidth,
            height: Layout.premiumIconSize,
            child: Stack(
              children: [
                premiumBackground,
                premiumContent,
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget get premiumBackground => Container(
    margin: const EdgeInsets.symmetric(
      vertical: Layout.premiumBgMargin,
    ),
    decoration: premiumDecoration,
  );

  BoxDecoration get premiumDecoration => BoxDecoration(
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
      Layout.premiumIconSize / 2
    ),
  );

  Widget get premiumContent => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      premiumTextMargin,
      Expanded(child: premiumText),
      premiumTextMargin,
      SvgPicture.asset('assets/images/icons/premium_get.svg',
        height: Layout.premiumIconSize,
      ),
    ],
  );

  Widget get premiumText => Text(
    Localizer.get('main_menu_premium'),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      height: Layout.premiumLineHeight,
      fontSize: layout.premiumFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get earthMarginTop => SizedBox(height: layout.earthMarginTop);
  Widget get earthMarginBottom => SizedBox(height: layout.earthMarginBottom);
  Widget get stageMarginBottom => SizedBox(height: layout.stageMarginBottom);
  Widget get todoMarginBottom => const SizedBox(height: Layout.todoMarginBottom);
  Widget get switchMarginBottom => SizedBox(height: layout.switchMarginBottom);
  Widget get trafficMarginBottom => const SizedBox(height: Layout.trafficMarginBottom);
  Widget get trafficIconMargin => const SizedBox(width: Layout.trafficIconMargin);
  Widget get countryIconMargin => const SizedBox(width: Layout.countryIconMargin);
  Widget get sideMenuMarginTop => const SizedBox(height: Layout.sideMenuMarginTop);
  Widget get sideMenuIconMargin => const SizedBox(width: Layout.sideMenuIconMargin);
  Widget get sideMenuTextMargin => const SizedBox(width: Layout.sideMenuTextMargin);
  Widget get premiumTextMargin => const SizedBox(width: Layout.premiumTextMargin);
  Widget get animatedEarthMarginTop => SizedBox(height: layout.animatedEarthMarginTop);
  Widget get animatedEarthMarginBottom => SizedBox(height: layout.animatedEarthMarginBottom);
}

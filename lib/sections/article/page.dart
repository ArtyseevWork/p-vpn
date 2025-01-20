import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:pvpn/router.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/util/app.dart';
//import 'package:pvpn/util/app_state.dart';
import 'package:pvpn/util/premium.dart';
//import 'package:pvpn/util/screen_size.dart';
//import 'package:pvpn/util/ad_helper.dart';
import 'package:pvpn/ui/top_bar/widgets.dart';
//import 'package:pvpn/ui/banner/widgets.dart';

import 'layout.dart';

class ArticlePage extends StatefulWidget {
  final String title;
  final String article;

  const ArticlePage({
    super.key,
    required this.title,
    required this.article,
  });

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Layout layout = Layout();
  TopBarUI topBarUI = TopBarUI();
  String html = '';
  //BannerAd? _bannerAd;
  //bool _bannerAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    onLoad();
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

  void onLoad() async {
    html = await rootBundle.loadString('assets/articles/${widget.article}.html');
    setState(() {});
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
              SizedBox(height: layout.titleMarginTop),
              title,
              SizedBox(height: layout.titleMarginBottom),
              article,
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
          callback: () => setState(() {}),
        ),
      ),
    ],
  );

  Widget get title => Text(
    Localizer.get(widget.title),
    style: TextStyle(
      fontSize: layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get article => Expanded(
    child: Container(
      constraints: const BoxConstraints(
        maxWidth: Sizes.contentMaxWidth
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Layout.articlePadding,
      ),
      child: SingleChildScrollView(
        child: Html(
          data: html,
          onLinkTap: (url, _, __) {
            launchUrl(Uri.parse(url ?? ''));
          }
        ),
      ),
    ),
  );
}
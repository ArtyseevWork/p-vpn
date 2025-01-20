import 'dart:async';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pvpn/util/app_state.dart';
import 'package:pvpn/util/screen_size.dart';
import 'app.dart';

class AdHelper {
  static final AdHelper _instance = AdHelper._internal();
  final int _bannerAdCount = 2;
  final int _interstitialAdCount = 0;
  final int _maxBannerAdCount = 5;
  final int _adExpiredMinutes = 45;

  bool _bannerAdIsLoading = false;

  AdHelper._internal();

  factory AdHelper() {
    return _instance;
  }

  final List<VpnBannerAd> _bannerAds = [];
  final List<InterstitialAd> _interstitialAds = [];
  late AdSize? _bannerAdSize;

  Future<void> loadAds({required Function onFinish}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    VpnAppState.connected = preferences.getBool(PreferencesKeys.isConnected) ?? false;
    await _setBannerAdSize();
    if (VpnAppState.connected) {
      onFinish();
      return;
    }
    await _preloadBannerAds();
    await _preloadInterstitialAds();
    _runBannerAdLoader();
    onFinish();
  }

  _setBannerAdSize() async {
    _bannerAdSize = await
      AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        ScreenSize.width.truncate()
      );
    _bannerAdSize ??= ScreenSize.isTablet()
      ? AdSize.largeBanner
      : AdSize.banner;
  }

  Future<void> _preloadBannerAds() async {
    for (int i = 0; i < _bannerAdCount; i++) {
      var ad = await _preloadBannerAd();
      if (ad != null) {
        _bannerAds.add(VpnBannerAd(ad, DateTime.now()));
      }
    }
  }

  Future<void> _preloadInterstitialAds() async {
    for (int i = 0; i < _interstitialAdCount; i++) {
      var ad = await _preloadInterstitialAd();
      if (ad != null) {
        _interstitialAds.add(ad);
      }
    }
  }

  Future<BannerAd?> _preloadBannerAd() async {
    final Completer<BannerAd?> completer = Completer<BannerAd?>();

    BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: _bannerAdSize!,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (ad is BannerAd) {
            completer.complete(ad);
          } else {
            ad.dispose();
            completer.completeError('Loaded ad is not a BannerAd');
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          completer.completeError(err);
        },
      ),
    ).load();

    return completer.future;
  }

  Future<InterstitialAd?> _preloadInterstitialAd() async {
    final Completer<InterstitialAd?> completer = Completer<InterstitialAd?>();

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
          );
          completer.complete(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          completer.completeError(error);
        },
      ),
    );

    return completer.future;
  }

  void _runBannerAdLoader() {
    if (_bannerAdIsLoading) {
      return;
    }
    _bannerAdIsLoading = true;
    _loadNextBannerAd();
  }

  void _loadNextBannerAd() {
    BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: _bannerAdSize!,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (ad is BannerAd) {
            _bannerAds.add(VpnBannerAd(ad, DateTime.now()));
            if (!VpnAppState.connected && _bannerAds.length < _maxBannerAdCount) {
              _loadNextBannerAd();
            } else {
              _bannerAdIsLoading = false;
            }
          } else {
            _bannerAdIsLoading = false;
            ad.dispose();
          }
        },
        onAdFailedToLoad: (ad, err) {
          _bannerAdIsLoading = false;
          ad.dispose();
        },
      ),
    ).load();
  }

  BannerAd? getBannerAd() {
    DateTime now = DateTime.now();
    for (int i = _bannerAds.length - 1; i >= 0; i--) {
      DateTime timestamp = _bannerAds[i].timestamp;
      if (now.difference(timestamp).inMinutes > _adExpiredMinutes) {
        _bannerAds.removeAt(i);
      }
    }
    BannerAd? ad;
    if (_bannerAds.isEmpty) {
      ad = null;
    } else {
      VpnBannerAd preloadedAd = _bannerAds.removeAt(0);
      ad = preloadedAd.ad;
    }
    if (!VpnAppState.connected) {
      _runBannerAdLoader();
    }
    return ad;
  }

  InterstitialAd? getInterstitialAd() {
    if (_interstitialAds.isEmpty) {
      return null;
    } else {
      return _interstitialAds.removeAt(0);
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'your value';
    } else if (Platform.isIOS) {
      return 'your value';
    }
    return '';
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'your value';
    } else if (Platform.isIOS) {
      return 'your value';
    }
    return '';
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'your value';
    } else if (Platform.isIOS) {
      return 'your value';
    }
    return '';
  }
}

class VpnBannerAd {
  late BannerAd ad;
  late DateTime timestamp;

  VpnBannerAd(this.ad, this.timestamp);
}
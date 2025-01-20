import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pvpn/core/mvvm/observer.dart';
import 'package:pvpn/router.dart';
//import 'package:pvpn/util/ad_helper.dart';
import 'package:pvpn/util/screen_size.dart';
import 'package:pvpn/ui/general/widgets.dart';

import '../policy/page.dart';
import '../main/page.dart';
import 'view_model.dart';
import 'layout.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements EventObserver {
  final SplashViewModel _model = SplashViewModel();

  @override
  void initState() {
    super.initState();
    _model.subscribe(this);
    _model.onLoad();
  }

  @override
  void deactivate() {
    _model.unsubscribe(this);
    super.deactivate();
  }

  @override
  void notify() {
    /*
    AdHelper().loadAds(
      onFinish: () {
        AppRouter.restart(context,
          _model.firstLogin ? const PolicyPage() : const MainPage()
        );
      }
    );
    */
    Timer(const Duration(milliseconds: 2500), () =>
      AppRouter.restart(context,
        _model.firstLogin ? const PolicyPage() : const MainPage()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    ScreenSize.init(MediaQuery.of(context));
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:[
          UI.background,
          SvgPicture.asset('assets/images/logo.svg',
            width: Layout().logoWidth,
          ),
        ],
      ),
    );
  }
}

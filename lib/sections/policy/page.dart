import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:pvpn/router.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/util/app.dart';
import 'package:pvpn/ui/general/widgets.dart';
import 'package:pvpn/ui/dialog/widgets.dart';
import 'package:pvpn/ui/dialog/decline/widget.dart';

import '../premium/plan_free/page.dart';
import '../main/page.dart';
import 'layout.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  Layout layout = Layout();
  bool showDeclineDialog = false;
  String html = '';

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void onLoad() async {
    html = await rootBundle.loadString('assets/articles/en_privacy.html');
    setState(() {});
  }

  void toggleDeclineDialog() => setState(() {
    showDeclineDialog = !showDeclineDialog;
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:[
          UI.background,
          DialogUI().get(
            content: content,
            blurBackground: false,
            height: layout.height,
            maxWidth: layout.maxWidth,
          ),
          if (showDeclineDialog) DialogDecline().get(
            onClose: () => exit(0),
            onOk: toggleDeclineDialog,
          ),
        ],
      ),
    );
  }

  Widget get content => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      title,
      SizedBox(height: layout.titleMarginBottom),
      article,
      SizedBox(height: layout.articleMarginBottom),
      acceptButton,
      SizedBox(height: layout.acceptMarginBottom),
      decline,
    ],
  );

  Widget get title => Text(
    Localizer.get('privacy_title'),
    style: TextStyle(
      fontSize: layout.titleFontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  Widget get article => Expanded(
    child: SingleChildScrollView(
      child: Html(data: html),
    ),
  );

  Widget get acceptButton => Container(
    constraints: const BoxConstraints(
      maxWidth: Layout.acceptMaxWidth,
    ),
    child: UI().appButton(
      name: 'privacy_accept',
      action: () => AppRouter.restart(context,
        Options.showInAppPurchases
          ? const PlanFreePage()
          : const MainPage()
      ),
    ),
  );

  Widget get decline => GestureDetector(
    onTap: toggleDeclineDialog,
    child: Text(
      Localizer.get('privacy_decline'),
      style: TextStyle(
        height: 1,
        fontSize: layout.declineFontSize,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}
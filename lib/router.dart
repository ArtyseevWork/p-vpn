import 'package:flutter/material.dart';

class AppRouter {
  static const Duration _transitionDuration = Duration(milliseconds: 300);

  static Widget _transitionAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(
      begin: begin,
      end: end
    ).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static _pageRouterBuilder(Widget page) => PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: _transitionAnimation,
    transitionDuration: _transitionDuration,
  );

  static void restart(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      _pageRouterBuilder(page),
      (route) => false,
    );
  }

  static void replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      _pageRouterBuilder(page),
    );
  }

  static void push(
    BuildContext context, {
    required Widget page,
    VoidCallback? callback,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.push(
      context,
      _pageRouterBuilder(page),
    ).then((_) {
        if (callback != null) {
          callback();
        }
      }
    );
  }
}
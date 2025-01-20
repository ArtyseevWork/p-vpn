import 'dart:async';
import 'dart:io' show Platform;

import 'package:pvpn/core/mvvm/view_model.dart';
import 'package:pvpn/util/connection.dart';

import 'model.dart';

class MainViewModel extends ViewModel {
  final MainModel _model = MainModel();
  final Duration _reconnectionDelay = const Duration(seconds: 1);
  final Duration _disconnectionDelay = const Duration(seconds: 2);
  final Duration _restartingDelay = const Duration(seconds: 3);
  //final Duration _sessionCloseDelay = const Duration(hours: 5);
  late Timer _reconnectionTimer;
  bool _reconnecting = false;
  bool _disconnecting = false;
  bool showSideMenu = false;
  bool showErrorDialog = false;
  bool showRateDialog = false;
  bool showConnectionError = false;
  bool loaded = false;
  //Timer? _sessionTimer;
  //bool _sessionStarted = false;

  void onLoad() async {
    if (loaded) {
      return;
    }
    await _model.onLoad(
      onStatusChanged: notify,
      onStageChanged: onStageChanged,
    );
    if (Platform.isIOS && _model.isConnected) {
      _restart();
    }
    showRateDialog = _model.loginCount == 1;
    loaded = true;
    notify();
  }

  void onStageChanged() {
    _model.onStageChanged();
    if (_model.error) {
      _model.disconnect();
      showErrorDialog = true;
    }
/*
    if (!_model.connected && _sessionStarted) {
      _stopSessionTimer();
    }
    if (_model.connected && !_sessionStarted) {
      _startSessionTimer();
    }
*/
    notify();
  }
/*
  void _startSessionTimer() {
    _sessionStarted = true;
    _sessionTimer = Timer(_sessionCloseDelay, () {
      _stopSessionTimer();
      _model.disconnect();
    });
  }

  void _stopSessionTimer() {
    _sessionStarted = false;
    if (_sessionTimer != null) {
      _sessionTimer!.cancel();
    }
  }
*/
  void onToggleSideMenu() {
    showSideMenu = !showSideMenu;
    notify();
  }

  void onConnect() async {
    if (await Connection.check()) {
      _model.connect();
    } else {
      showConnectionError = true;
      notify();
    }
  }

  void onDisconnect() {
    _model.disconnect();
  }

  void onDelayedDisconnect() {
    _disconnecting = true;
    _model.disconnect();
    Timer(_disconnectionDelay, () {
      _disconnecting = false;
      notify();
    });
  }

  void onCountryButton() {
    _model.putActiveCountryAsFirst();
  }

  bool onSmartLocation() {
    return connectTo(MainModel.smartCountryIndex);
  }

  bool connectTo(int countryIndex) {
    if (_model.disconnected) {
      _model.connectTo(countryIndex);
      return true;
    }
    if (_model.connected) {
      _reconnecting = true;
      _model.disconnect();
      _reconnect(countryIndex);
      return true;
    }
    return false;
  }

  void _reconnect(int countryIndex) {
    _reconnectionTimer = Timer.periodic(
      _reconnectionDelay, (Timer timer) {
        if (_model.disconnected) {
          _reconnectionTimer.cancel();
          _model.connectTo(countryIndex);
          Timer(_reconnectionDelay, () {
            _reconnecting = false;
            notify();
          });
        }
      }
    );
  }

  void _restart() {
    _reconnecting = true;
    _model.disconnect();
    Timer(_restartingDelay, () async {
      await _model.initEngine(
        onStatusChanged: notify,
        onStageChanged: onStageChanged,
      );
      onConnect();
      Timer(_reconnectionDelay, () {
        _reconnecting = false;
        notify();
      });
    });
  }

  void onErrorClose() {
    showErrorDialog = false;
    notify();
  }

  void onRateClose() {
    showRateDialog = false;
    notify();
  }

  List<String> get countries => _model.countries;
  int get countryIndex => _model.countryIndex;
  String get country => _model.country;

  bool get connecting =>
    _model.connecting || _reconnecting;

  bool get connected =>
    _model.connected &&
    !_reconnecting &&
    !_disconnecting;

  bool get disconnected =>
    _model.disconnected &&
    !_reconnecting &&
    !_disconnecting;

  bool get disconnecting =>
    (_model.disconnecting || _disconnecting) &&
    !_reconnecting;

  String get trafficIn => _model.trafficIn;
  String get trafficOut => _model.trafficOut;
}

class MainViewModelSingleton {
  late MainViewModel vm;

  static final MainViewModelSingleton _instance =
    MainViewModelSingleton._();

  factory MainViewModelSingleton() {
    return _instance;
  }

  MainViewModelSingleton._() {
    vm = MainViewModel();
  }
}
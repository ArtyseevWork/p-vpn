import 'dart:math';

import 'package:flutter/services.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pvpn/util/app.dart';
import 'package:pvpn/util/app_state.dart';
import 'package:pvpn/values/strings/localizer.dart';
import 'package:pvpn/util/premium.dart';

class Server {
  final String userName;
  final String password;

  Server(
    this.userName,
    this.password,
  );
}

class Country {
  final String code;
  final List<Server> _servers = [];
  int _serverIndex = 0;

  Country(this.code);

  Country add(Server server) {
    _servers.add(server);
    return this;
  }

  void selectServer() {
    _serverIndex = Random().nextInt(_servers.length);
  }

  String get name => '${code}_name';
  String get certificate => 'assets/certificates/$code/$_serverIndex.ovpn';
  String get userName => _servers[_serverIndex].userName;
  String get password => _servers[_serverIndex].password;
}

class Countries {
  List<Country> get list => [
    Country('cz').add(Server('openvpn', '7neD9zv8VH98')),
    Country('fr').add(Server('openvpn', 'RP97LIGtyuDU')),
    Country('br').add(Server('openvpn', 'Mg14JjKUwyz8')),
    Country('ca').add(Server('openvpn', 'HOCmjdNj2F7a')),
    Country('gb').add(Server('openvpn', 'yMUzNrCnxTbQ')),
    Country('fi').add(Server('openvpn', 'ehSNyhiisJBw')),
    Country('de').add(Server('openvpn', 'G0KBQEIf4eJD')),
    Country('hk').add(Server('openvpn', 'rsjdaxMi5lbH')),
    Country('jp').add(Server('openvpn', '9EmFv4fHxfWk')),
    Country('us').add(Server('openvpn', 'pijfuRbwfJBr')),
  ];
}

class MainModel {
  static const int freeCountryCount = 2;
  static const int smartCountryIndex = -1;

  final List<Country> _countries = Countries().list;
  int _countryIndex = smartCountryIndex;

  late final SharedPreferences _preferences;
  late final int _loginCount;
  late OpenVPN _engine;
  VpnStatus? _status;
  VPNStage? _stage;
  VPNStage? _previousStage;
  bool _isConnected = false;

  Future<void> onLoad({
    required VoidCallback onStatusChanged,
    required VoidCallback onStageChanged,
  }) async {
    _preferences = await SharedPreferences.getInstance();
    _loginCount = _preferences.getInt(PreferencesKeys.loginCount) ?? 0;
    String lastCountry = _preferences.getString(PreferencesKeys.lastCountry) ?? '';
    _countryIndex = _countries.indexWhere((el) => el.code == lastCountry);
    _preferences.setInt(PreferencesKeys.loginCount, _loginCount + 1);
    _isConnected = _preferences.getBool(PreferencesKeys.isConnected) ?? false;

    await initEngine(
      onStatusChanged: onStatusChanged,
      onStageChanged: onStageChanged,
    );
  }

  Future<void> initEngine({
    required VoidCallback onStatusChanged,
    required VoidCallback onStageChanged,
  }) async {
    _engine = OpenVPN(
      onVpnStatusChanged: (data) {
        _status = data;
        onStatusChanged();
      },
      onVpnStageChanged: (data, raw) {
        _previousStage = _stage;
        _stage = data;
        onStageChanged();
      },
    );
    await _engine.initialize(
      groupIdentifier: EngineParams.groupIdentifier,
      providerBundleIdentifier: EngineParams.providerBundleIdentifier,
      localizedDescription: EngineParams.localizedDescription,
      lastStage: (stage) => _stage = stage,
      lastStatus: (status) => _status = status,
    );
    //_engine.requestPermission();
  }

  void connect() async {
    if (_countryIndex == smartCountryIndex) {
      _selectCountry();
    }
    Country country = _countries[_countryIndex];
    country.selectServer();
    String config = await rootBundle.loadString(country.certificate);
    _engine.connect(config,
      Localizer.get(country.name),
      username: country.userName,
      password: country.password,
      certIsRequired: true,
    );
  }

  void disconnect() {
    _engine.disconnect();
    _preferences.setString(PreferencesKeys.lastCountry, '');
  }

  void connectTo(int countryIndex) {
    _countryIndex = countryIndex;
    if (_countryIndex != smartCountryIndex) {
      _writeSelectedCountry();
    }
    connect();
  }

  void putActiveCountryAsFirst() {
    if (_countryIndex == smartCountryIndex) {
      return;
    }
    Country country = _countries[_countryIndex];
    _countries[_countryIndex] = _countries[0];
    _countries[0] = country;
    _countryIndex = 0;
  }

  void onStageChanged() {
    VpnAppState.connected = connected;
    _preferences.setBool(PreferencesKeys.isConnected, connected);
  }

  void _selectCountry() {
    if (Premium.isFreePlan && Options.showInAppPurchases) {
      _countryIndex = Random().nextInt(freeCountryCount);
    } else {
      _countryIndex = Random().nextInt(_countries.length);
    }
    _writeSelectedCountry();
  }

  void _writeSelectedCountry() {
    String code = _countries[_countryIndex].code;
    _preferences.setString(PreferencesKeys.lastCountry, code);
  }

  String _toMB(String key) {
    if (disconnected) {
      return '0.00';
    }
    double bytes = double.parse(_status?.toJson()[key] ?? '0');
    double megabytes = bytes / 1024 / 1024;
    return megabytes.toStringAsFixed(2);
  }

  List<String> get countries {
    return _countries.map((el) => el.code).toList();
  }

  int get loginCount => _loginCount;
  int get countryIndex => _countryIndex;
  bool get isConnected => _isConnected;

  String get country {
    if (_countryIndex == smartCountryIndex) {
      return '';
    }
    return _countries[_countryIndex].code;
  }

  bool get connected => _stage == VPNStage.connected;

  bool get disconnected =>
    _stage == null ||
    _stage == VPNStage.disconnected ||
    _stage == VPNStage.unknown;

  bool get disconnecting =>
    _stage == VPNStage.disconnecting ||
    _stage == VPNStage.exiting;

  bool get error =>
    _stage == VPNStage.error ||
    _stage == VPNStage.denied ||
    _failed;

  bool get _failed =>
    _stage == VPNStage.unknown &&
    _previousStage == VPNStage.wait_connection;

  bool get connecting =>
    !connected &&
    !disconnected &&
    !disconnecting &&
    !error;

  String get trafficIn => _toMB('byte_in');
  String get trafficOut => _toMB('byte_out');

  static bool countryIsSmart(int index) {
    return index == smartCountryIndex;
  }

  static bool countryIsPremium(int index) {
    return index >= freeCountryCount
      && Premium.isFreePlan
      && Options.showInAppPurchases;
  }
}

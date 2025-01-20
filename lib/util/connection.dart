import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  static Future<bool> check() async {
    final result = await (Connectivity().checkConnectivity());
    return result != ConnectivityResult.none;
  }
}
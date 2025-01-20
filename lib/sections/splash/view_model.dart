import 'package:pvpn/core/mvvm/view_model.dart';
import 'model.dart';

class SplashViewModel extends ViewModel {
  final SplashModel _model = SplashModel();

  void onLoad() async {
    await _model.onLoad();
    notify();
  }

  bool get firstLogin => _model.loginCount == 0;
}
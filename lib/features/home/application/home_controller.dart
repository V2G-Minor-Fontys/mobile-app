import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = Provider<HomeController>((ref) {
  return HomeController();
});

class HomeController extends ChangeNotifier {
  bool _isDischarging = false;
  bool get isDischarging => _isDischarging;

  void updateIsDischarging() {
    _isDischarging = !_isDischarging;
    notifyListeners();
  }
}
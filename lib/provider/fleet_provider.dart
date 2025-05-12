import 'package:flutter/material.dart';

class FleetProvider extends ChangeNotifier {
  bool _hasVehicles = false;
  bool _hasDrivers = false;
  final double _profit = 1274.0;

  bool get hasVehicles => _hasVehicles;
  bool get hasDrivers => _hasDrivers;
  double get profit => _profit;

  void addVehicle() {
    _hasVehicles = true;
    notifyListeners();
  }

  void addDriver() {
    _hasDrivers = true;
    notifyListeners();
  }
}

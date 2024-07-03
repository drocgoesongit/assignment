import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppState extends ChangeNotifier {
  bool _isInternetConnected = false;
  bool _isLocationPermissionGranted = false;
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  bool get isInternetConnected => _isInternetConnected;
  bool get isLocationPermissionGranted => _isLocationPermissionGranted;
  int get selectedIndex => _selectedIndex;
  PageController get pageController => _pageController;

  Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      _isInternetConnected =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      _isInternetConnected = false;
    }
    notifyListeners();
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    _isLocationPermissionGranted = status.isGranted;
    notifyListeners();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    _isLocationPermissionGranted = status.isGranted;
    notifyListeners();
  }

  void onTabTapped(int index) {
    _selectedIndex = index;
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class BottomNavBarRiderProvider extends ChangeNotifier {
  int currentTab = 0;

  int get currentIndex => currentTab;

  void updateTab(int newTab) {
    currentTab = newTab;
    notifyListeners();
  }
}

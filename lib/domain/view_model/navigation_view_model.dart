import 'package:flutter/cupertino.dart';

class NavigationViewModel extends ChangeNotifier{
  late int _index;

  int get pageNumber => _index;

  NavigationViewModel() {
    _index = 0;
  }

  void setPage(int number) {
    _index = number;
    notifyListeners();
  }
}
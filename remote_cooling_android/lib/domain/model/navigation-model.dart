import 'package:flutter/cupertino.dart';

class NavigationModel extends ChangeNotifier{
  late int _index;

  int get pageNumber => _index;

  NavigationModel() {
    _index = 0;
  }

  void setPage(int number) {
    _index = number;
    notifyListeners();
  }
}
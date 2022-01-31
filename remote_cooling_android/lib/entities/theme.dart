import 'package:flutter/material.dart';

import '../constants.dart';

ThemeData cinimexTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColorLight: Constants.mainOrange,
  primaryColor: Constants.mainBlue,
  toggleableActiveColor: Constants.mainOrange,
  scaffoldBackgroundColor: Constants.mainBlue,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Constants.mainOrange,
      onPrimary: Constants.mainBlack,
    ),
  ),
);

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Constants.mainOrange;
  }
  return Constants.mainBlack;
}

ThemeData lightTheme = ThemeData.light();
ThemeData darkTheme = ThemeData.dark();

Map<String, ThemeData> themeDictionary = {
  'Тёмная': darkTheme,
  'Светлая': lightTheme,
  'Cinimex': cinimexTheme
};

ThemeData getTheme(String themeName) {
  return themeDictionary[themeName]!;
}
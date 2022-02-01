import 'package:flutter/material.dart';

import '../cinimex-colors.dart';

ThemeData cinimexTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColorLight: CinimexColors.mainOrange,
  primaryColor: CinimexColors.mainBlue,
  toggleableActiveColor: CinimexColors.mainOrange,
  scaffoldBackgroundColor: CinimexColors.mainBlue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CinimexColors.mainOrange
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: CinimexColors.mainOrange),
    selectedLabelStyle: TextStyle(color: CinimexColors.mainOrange),
    selectedItemColor: CinimexColors.mainOrange,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: CinimexColors.mainOrange,
      onPrimary: CinimexColors.mainBlack,
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
    return CinimexColors.mainOrange;
  }
  return CinimexColors.mainBlack;
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
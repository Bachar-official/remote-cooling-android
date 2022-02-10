import 'package:flutter/material.dart';

import 'colors.dart';

Color cmxBlack = CinimexColors.mainBlack;
Color cmxBlue = CinimexColors.mainBlue;
Color cmxOrange = CinimexColors.mainOrange;

ThemeData cinimexTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: cmxBlack,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20
    ),
  ),
  colorScheme: ColorScheme(
      primary: Colors.blue,
      primaryVariant: Colors.blue,
      secondary: Colors.blue,
      secondaryVariant: cmxBlack,
      surface: Colors.white,
      background: cmxBlack,
      error: cmxBlack,
      onPrimary: Colors.white,
      onSecondary: cmxBlack,
      onSurface: Colors.white,
      onBackground: cmxBlack,
      onError: Colors.redAccent,
      brightness: Brightness.dark
  ),
  primaryColorLight: cmxOrange,
  primaryColor: cmxBlue,
  toggleableActiveColor: cmxOrange,
  scaffoldBackgroundColor: cmxBlue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: cmxOrange
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: cmxBlack,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(color: cmxOrange),
    selectedLabelStyle: TextStyle(color: cmxOrange),
    selectedItemColor: cmxOrange,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: cmxOrange,
      onPrimary: cmxBlack,
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
    return cmxOrange;
  }
  return cmxBlack;
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
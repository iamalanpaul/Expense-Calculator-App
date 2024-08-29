import 'package:flutter/material.dart';
import '../widgets/expense.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 105, 183, 238));
var kDarkColorScheme =
    ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 5, 99, 125)
    );

void main() {
  runApp(
    MaterialApp(
      //theme: ThemeData().copyWith(useMaterial3: true, scaffoldBackgroundColor: const Color.fromARGB(255, 227, 98, 24)), for giving backgrnd color
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
         elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          //same as copyWith
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        )),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          //same as copyWith
          backgroundColor: kColorScheme.primaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ), // copy with also gives default settings so that all parameters need not be set
      //themeMode: ThemeMode.system, is the default setting for controlling light and dark theme
      home: const Expense(),
    ),
  );
}

import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.primary,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kColorScheme.primary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: kColorScheme.primary),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kColorScheme.primary),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kColorScheme.primary,
          selectionColor: kColorScheme.primaryContainer,
          selectionHandleColor: kColorScheme.primary,
        ),
      ),
      home: Expenses(),
    ),
  );
}

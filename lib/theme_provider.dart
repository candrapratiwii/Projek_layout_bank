import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // Light theme
  final ThemeData _lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[50],
    cardColor: Colors.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF1E88E5), // Blue shade
      secondary: Color(0xFF42A5F5),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      background: Colors.grey[50]!,
      surface: Colors.white,
      error: Colors.red[700]!,
    ),
    appBarTheme: AppBarTheme(
      elevation: 2,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black87),
    ),
    dividerColor: Colors.grey[300],
    shadowColor: Colors.black26,
  );

  // Dark theme
  final ThemeData _darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF121212),
    cardColor: Color(0xFF1E1E1E),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF90CAF9), // Light blue
      secondary: Color(0xFF64B5F6),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
      error: Colors.red[300]!,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
      bodyLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white70),
    ),
    dividerColor: Colors.grey[800],
    shadowColor: Colors.black45,
  );

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  // Toggle between light and dark themes
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemeToPrefs();
    notifyListeners();
  }

  // Load theme setting from SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  // Save theme setting to SharedPreferences
  Future<void> _saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }
}
import 'package:bookexample/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.light
    ),
    
    scaffoldBackgroundColor: Colors.white,
    
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      
      indicatorColor:Colors.transparent,
      
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.3,
          );
        }
        return const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        );
      }),
      
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            size: 26,
            color: AppColors.brandPrimary,
          );
        }
        return const IconThemeData(
          size: 24,
          color: Colors.grey,
        );
      }),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brandPrimary,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

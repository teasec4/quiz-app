import 'package:bookexample/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      secondary: AppColors.brandSecondary,
      brightness: Brightness.light,
      // puting more contrast 
      //dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  ).copyWith(
    error: AppColors.error,
    tertiary: AppColors.success,
  );
  
  // Theme.of(context).colorScheme.error
  // Theme.of(context).colorScheme.tertiary
    
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    
    colorScheme: colorScheme,
    
    scaffoldBackgroundColor: colorScheme.surface,
    
    cardColor: colorScheme.surfaceContainerHighest,
    
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primaryContainer,
      centerTitle: true,
    ),
    
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      hoverElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
          return IconThemeData(
            size: 26,
            color: colorScheme.primary,
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
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    ),
    
  );
}

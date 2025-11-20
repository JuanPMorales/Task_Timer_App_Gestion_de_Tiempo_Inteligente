/// Tema principal de la aplicación Task Timer.
///
/// Define el ThemeData completo con dark mode por defecto siguiendo
/// las especificaciones del PRD. Integra AppColors y AppTextStyles
/// para crear una experiencia visual consistente.
///
/// Criterios de diseño:
/// - Dark mode por defecto (azul oscuro #0A0E2A)
/// - Material Design 3 (Material You)
/// - Accesibilidad WCAG 2.1 AA
/// - Transiciones y animaciones suaves
library;

import 'package:flutter/material.dart';
import 'package:task_timer/core/theme/app_colors.dart';
import 'package:task_timer/core/theme/app_text_styles.dart';

/// Clase que contiene la configuración completa del tema de la aplicación.
///
/// Proporciona un ThemeData configurado con todos los estilos, colores
/// y propiedades necesarias para mantener consistencia visual en toda la app.
class AppTheme {
  // Constructor privado para prevenir instanciación
  AppTheme._();

  // ============================================================================
  // TEMA PRINCIPAL (DARK MODE)
  // ============================================================================

  /// Tema dark mode por defecto de la aplicación
  ///
  /// Utiliza la paleta de colores azul oscuro y todos los estilos
  /// tipográficos definidos en AppTextStyles.
  static ThemeData get darkTheme {
    return ThemeData(
      // ========================================================================
      // CONFIGURACIÓN BASE
      // ========================================================================
      useMaterial3: true,
      brightness: Brightness.dark,

      // ========================================================================
      // ESQUEMA DE COLORES
      // ========================================================================
      colorScheme: ColorScheme.dark(
        // Colores primarios
        primary: AppColors.primaryLight,
        onPrimary: AppColors.textOnPrimary,
        primaryContainer: AppColors.primaryLightDark,
        onPrimaryContainer: AppColors.textPrimary,

        // Colores secundarios
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.textOnPrimary,
        secondaryContainer: AppColors.surface,
        onSecondaryContainer: AppColors.textPrimary,

        // Colores de superficie
        surface: AppColors.background,

        // Colores semánticos
        error: AppColors.error,
        onError: AppColors.textPrimary,
        errorContainer: AppColors.error.withValues(alpha: 0.2),
        onErrorContainer: AppColors.error,

        // Bordes y divisores
        outline: AppColors.border,
        outlineVariant: AppColors.divider,

        // Fondos y sombras
        shadow: AppColors.shadowMedium,
        scrim: AppColors.overlayDark,
      ),

      // ========================================================================
      // COLORES ESPECÍFICOS
      // ========================================================================
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.backgroundSecondary,
      cardColor: AppColors.surface,
      dividerColor: AppColors.divider,
      disabledColor: AppColors.textDisabled,
      highlightColor: AppColors.overlayHover,
      splashColor: AppColors.overlayPressed,

      // ========================================================================
      // TIPOGRAFÍA
      // ========================================================================
      textTheme: const TextTheme(
        // Headings
        displayLarge: AppTextStyles.heading1,
        displayMedium: AppTextStyles.heading2,
        displaySmall: AppTextStyles.heading3,

        // Body
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,

        // Labels
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,

        // Títulos y subtítulos
        titleLarge: AppTextStyles.taskName,
        titleMedium: AppTextStyles.taskDuration,
        titleSmall: AppTextStyles.upNext,
      ),

      // ========================================================================
      // APP BAR
      // ========================================================================
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.heading2,
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),
      ),

      // ========================================================================
      // CARDS
      // ========================================================================
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: AppColors.shadowMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // ========================================================================
      // BOTONES
      // ========================================================================

      // Elevated Button (botón principal)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.textOnPrimary,
          textStyle: AppTextStyles.buttonPrimary,
          elevation: 2,
          shadowColor: AppColors.shadowMedium,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(88, 44), // Accesibilidad táctil
        ),
      ),

      // Outlined Button (botón secundario)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: AppTextStyles.buttonSecondary,
          side: const BorderSide(
            color: AppColors.primaryLight,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(88, 44),
        ),
      ),

      // Text Button (botón de texto)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: AppTextStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(64, 44),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // ========================================================================
      // INPUTS Y FORMULARIOS
      // ========================================================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        // Bordes
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryLight,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),

        // Estilos de texto
        labelStyle: AppTextStyles.inputLabel,
        hintStyle: AppTextStyles.inputHint,
        errorStyle: AppTextStyles.error,

        // Íconos
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
      ),

      // ========================================================================
      // DIÁLOGOS Y BOTTOM SHEETS
      // ========================================================================
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceElevated,
        elevation: 8,
        shadowColor: AppColors.shadowStrong,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: AppTextStyles.heading3,
        contentTextStyle: AppTextStyles.bodyLarge,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceElevated,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        modalBackgroundColor: AppColors.surfaceElevated,
        modalElevation: 8,
      ),

      // ========================================================================
      // SNACKBARS
      // ========================================================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: AppTextStyles.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),

      // ========================================================================
      // ICONOS Y CHIPS
      // ========================================================================
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primaryLight,
        disabledColor: AppColors.textDisabled,
        labelStyle: AppTextStyles.labelSmall,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // ========================================================================
      // PROGRESS INDICATORS
      // ========================================================================
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: AppColors.border,
        circularTrackColor: AppColors.border,
      ),

      // ========================================================================
      // SLIDER Y SWITCH
      // ========================================================================
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryLight,
        inactiveTrackColor: AppColors.border,
        thumbColor: AppColors.primaryLight,
        overlayColor: AppColors.overlayHover,
        valueIndicatorColor: AppColors.primaryLight,
        valueIndicatorTextStyle: AppTextStyles.labelSmall.copyWith(
          color: AppColors.textOnPrimary,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight.withValues(alpha: 0.5);
          }
          return AppColors.border;
        }),
      ),

      // ========================================================================
      // DIVIDERS Y LIST TILES
      // ========================================================================
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      listTileTheme: ListTileThemeData(
        tileColor: AppColors.surface,
        selectedTileColor: AppColors.primaryLight.withValues(alpha: 0.1),
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
        titleTextStyle: AppTextStyles.bodyLarge,
        subtitleTextStyle: AppTextStyles.bodySmall,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ========================================================================
      // TOOLTIPS
      // ========================================================================
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.bodySmall,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  // ============================================================================
  // UTILIDADES
  // ============================================================================

  /// Duración estándar para animaciones rápidas (150ms)
  static const Duration fastAnimation = Duration(milliseconds: 150);

  /// Duración estándar para animaciones normales (300ms)
  static const Duration normalAnimation = Duration(milliseconds: 300);

  /// Duración estándar para animaciones lentas (500ms)
  static const Duration slowAnimation = Duration(milliseconds: 500);

  /// Curva de animación estándar (easeInOut)
  static const Curve standardCurve = Curves.easeInOut;

  /// Curva de animación rápida (easeOut)
  static const Curve fastCurve = Curves.easeOut;

  /// Radio de borde estándar para cards y botones
  static const double standardRadius = 12;

  /// Radio de borde grande para modales y diálogos
  static const double largeRadius = 20;

  /// Espaciado pequeño (8px)
  static const double smallSpacing = 8;

  /// Espaciado estándar (16px)
  static const double standardSpacing = 16;

  /// Espaciado grande (24px)
  static const double largeSpacing = 24;
}

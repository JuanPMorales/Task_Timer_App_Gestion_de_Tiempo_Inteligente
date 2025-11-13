/// Estilos de texto de Task Timer App
///
/// Define los estilos tipográficos utilizados en toda la aplicación.
library;

import 'package:flutter/material.dart';
import 'package:task_timer/core/theme/app_colors.dart';

/// Clase que contiene todos los estilos de texto de la aplicación.
class AppTextStyles {
  AppTextStyles._(); // Constructor privado

  // Headings (Títulos)
  /// Título principal de pantallas (ej: "Task Timer")
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  /// Títulos secundarios
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  /// Títulos de secciones
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body Text (Texto de cuerpo)
  /// Texto principal normal
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Texto secundario
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// Texto pequeño
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Labels (Etiquetas)
  /// Etiquetas de botones y campos
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  /// Etiquetas medianas
  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  /// Etiquetas pequeñas
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  // Timer Styles (Estilos del cronómetro)
  /// Tiempo principal del timer (mm:ss)
  static const TextStyle timerDisplay = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    letterSpacing: 2,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Duración de tarea en tarjeta
  static const TextStyle taskDuration = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 1,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // Special Styles (Estilos especiales)
  /// Texto de instrucción (ej: "Slide to Start")
  static const TextStyle instruction = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontStyle: FontStyle.italic,
  );

  /// Texto de error
  static const TextStyle error = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
  );

  /// Texto de éxito
  static const TextStyle success = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
  );

  // Task Card Styles
  /// Nombre de tarea en tarjeta
  static const TextStyle taskName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Subtítulo "Up next"
  static const TextStyle upNext = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}

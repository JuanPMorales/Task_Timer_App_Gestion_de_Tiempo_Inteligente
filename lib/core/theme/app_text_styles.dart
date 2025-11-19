/// Estilos tipográficos de la aplicación Task Timer.
///
/// Define todos los estilos de texto utilizados en la aplicación siguiendo
/// las especificaciones del PRD. Incluye headings, body text, labels y
/// estilos especiales para timer y task cards.
///
/// Criterios de diseño:
/// - Escala tipográfica modular (1.25 ratio)
/// - Line height optimizado para legibilidad
/// - Letter spacing ajustado por tamaño
/// - Soporte para números tabulares en timers
/// - Respeta configuración de accesibilidad del sistema
library;

import 'package:flutter/material.dart';
import 'package:task_timer/core/theme/app_colors.dart';

/// Clase que contiene todos los estilos de texto de la aplicación.
///
/// Proporciona estilos consistentes y accesibles para todos los componentes.
/// Los estilos están optimizados para dark mode y cumplen con WCAG 2.1 AA.
class AppTextStyles {
  // Constructor privado para prevenir instanciación
  AppTextStyles._();

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

  // Button Styles
  /// Texto de botón principal
  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.5,
  );

  /// Texto de botón secundario
  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  /// Texto de botón de texto (text button)
  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryLight,
    letterSpacing: 0.3,
  );

  // Input Styles
  /// Texto de input/campo de formulario
  static const TextStyle input = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Hint text en inputs
  static const TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  /// Label de input
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  // ============================================================================
  // UTILIDADES
  // ============================================================================

  /// Crea una variante del estilo con color personalizado
  ///
  /// Ejemplo:
  /// ```dart
  /// final blueHeading = AppTextStyles.withColor(
  ///   AppTextStyles.heading1,
  ///   AppColors.primaryLight,
  /// );
  /// ```
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Crea una variante del estilo con peso personalizado
  ///
  /// Ejemplo:
  /// ```dart
  /// final lightBody = AppTextStyles.withWeight(
  ///   AppTextStyles.bodyLarge,
  ///   FontWeight.w300,
  /// );
  /// ```
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Crea una variante del estilo con tamaño personalizado
  ///
  /// Ejemplo:
  /// ```dart
  /// final largeTimer = AppTextStyles.withSize(
  ///   AppTextStyles.timerDisplay,
  ///   72,
  /// );
  /// ```
  static TextStyle withSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }

  /// Crea una variante del estilo con opacidad aplicada
  ///
  /// Ejemplo:
  /// ```dart
  /// final fadedText = AppTextStyles.withOpacity(
  ///   AppTextStyles.bodyLarge,
  ///   0.5,
  /// );
  /// ```
  static TextStyle withOpacity(TextStyle style, double opacity) {
    final color = style.color;
    if (color == null) return style;

    return style.copyWith(
      color: Color.fromRGBO(
        (color.r * 255).round(),
        (color.g * 255).round(),
        (color.b * 255).round(),
        opacity,
      ),
    );
  }

  /// Aplica sombra de texto para mayor legibilidad
  ///
  /// Útil para texto sobre imágenes o fondos con bajo contraste
  static TextStyle withShadow(TextStyle style) {
    return style.copyWith(
      shadows: [
        const Shadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          color: AppColors.shadowMedium,
        ),
      ],
    );
  }
}

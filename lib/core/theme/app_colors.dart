/// Paleta de colores de la aplicación Task Timer.
///
/// Define todos los colores utilizados en la aplicación siguiendo
/// las especificaciones del PRD. Incluye colores primarios, secundarios,
/// semánticos y variantes para dark mode.
///
/// Criterios de diseño:
/// - Accesibilidad WCAG 2.1 AA (contraste mínimo 4.5:1 para texto normal)
/// - Dark mode por defecto (azul oscuro + azul claro)
/// - Colores personalizables para tareas
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Clase que contiene todos los colores utilizados en la aplicación.
class AppColors {
  // Constructor privado para prevenir instanciación
  AppColors._();

  // ============================================================================
  // COLORES PRIMARIOS
  // ============================================================================

  /// Color primario principal - Azul oscuro profundo
  /// Usado como fondo principal de la aplicación
  static const Color primaryDark = Color(0xFF0A0E2A);

  /// Color primario claro - Azul brillante
  /// Usado para elementos destacados, botones y acentos
  static const Color primaryLight = Color(0xFF3BCDFE);

  /// Variante más oscura del azul claro
  /// Para estados hover o pressed
  static const Color primaryLightDark = Color(0xFF2BA8D6);

  // ============================================================================
  // COLORES DE FONDO
  // ============================================================================

  /// Fondo principal de la aplicación
  static const Color background = primaryDark;

  /// Fondo secundario (para cards, modales)
  /// Ligeramente más claro que el fondo principal
  static const Color backgroundSecondary = Color(0xFF141938);

  /// Fondo terciario (para secciones elevadas)
  static const Color backgroundTertiary = Color(0xFF1E2447);

  // ============================================================================
  // COLORES DE SUPERFICIE
  // ============================================================================

  /// Color de superficie para cards y contenedores
  static const Color surface = Color(0xFF1A1F42);

  /// Color de superficie elevada (modales, diálogos)
  static const Color surfaceElevated = Color(0xFF242B52);

  // ============================================================================
  // COLORES DE TEXTO
  // ============================================================================

  /// Texto principal - Blanco con alta opacidad
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Texto secundario - Blanco con opacidad media
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% opacity

  /// Texto terciario - Blanco con baja opacidad
  static const Color textTertiary = Color(0x99FFFFFF); // 60% opacity

  /// Texto deshabilitado
  static const Color textDisabled = Color(0x61FFFFFF); // 38% opacity

  /// Texto sobre fondo claro (para botones con primaryLight)
  static const Color textOnPrimary = Color(0xFF0A0E2A);

  // ============================================================================
  // COLORES SEMÁNTICOS
  // ============================================================================

  /// Color de éxito - Verde
  static const Color success = Color(0xFF4CAF50);

  /// Color de advertencia - Amarillo/Naranja
  static const Color warning = Color(0xFFFFA726);

  /// Color de error - Rojo
  static const Color error = Color(0xFFEF5350);

  /// Color de información - Azul
  static const Color info = Color(0xFF42A5F5);

  // ============================================================================
  // COLORES DE DEGRADADO
  // ============================================================================

  /// Inicio del degradado azul (más claro)
  static const Color gradientStart = Color(0xFF3BCDFE);

  /// Fin del degradado azul (más oscuro)
  static const Color gradientEnd = Color(0xFF1A73E8);

  /// Degradado lineal para TaskCard
  /// De azul claro a azul oscuro (izquierda a derecha)
  static const LinearGradient taskCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  /// Degradado lineal para Timer Screen
  /// Degradado sutil de fondo
  static const LinearGradient timerBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0A0E2A),
      Color(0xFF141938),
      Color(0xFF1E2447),
    ],
  );

  // ============================================================================
  // COLORES PERSONALIZABLES PARA TAREAS
  // ============================================================================

  /// Azul por defecto (predeterminado)
  static const Color taskBlue = Color(0xFF3BCDFE);

  /// Verde para tareas de naturaleza/salud
  static const Color taskGreen = Color(0xFF4CAF50);

  /// Naranja para tareas urgentes
  static const Color taskOrange = Color(0xFFFFA726);

  /// Púrpura para tareas creativas
  static const Color taskPurple = Color(0xFFAB47BC);

  /// Rosa para tareas personales
  static const Color taskPink = Color(0xFFEC407A);

  /// Lista de colores predefinidos para selección de usuario
  static const List<Color> taskColors = [
    taskBlue,
    taskGreen,
    taskOrange,
    taskPurple,
    taskPink,
  ];

  /// Lista de colores en formato hexadecimal (para serialización)
  static const List<String> taskColorsHex = [
    '#3BCDFE', // Azul
    '#4CAF50', // Verde
    '#FFA726', // Naranja
    '#AB47BC', // Púrpura
    '#EC407A', // Rosa
  ];

  // ============================================================================
  // COLORES DE ESTADO DEL TIMER
  // ============================================================================

  /// Timer detenido
  static const Color timerStopped = Color(0xFF757575);

  /// Timer en curso
  static const Color timerRunning = primaryLight;

  /// Timer pausado
  static const Color timerPaused = warning;

  /// Timer completado
  static const Color timerCompleted = success;

  // ============================================================================
  // COLORES DE BORDES Y DIVISORES
  // ============================================================================

  /// Bordes sutiles
  static const Color border = Color(0x33FFFFFF); // 20% opacity

  /// Divisores entre elementos
  static const Color divider = Color(0x1FFFFFFF); // 12% opacity

  // ============================================================================
  // COLORES DE SOMBRAS
  // ============================================================================

  /// Sombra ligera para elevación
  static const Color shadowLight = Color(0x1A000000); // 10% opacity

  /// Sombra media para cards
  static const Color shadowMedium = Color(0x33000000); // 20% opacity

  /// Sombra fuerte para modales
  static const Color shadowStrong = Color(0x4D000000); // 30% opacity

  // ============================================================================
  // COLORES DE OVERLAY
  // ============================================================================

  /// Overlay oscuro para modales (scrim)
  static const Color overlayDark = Color(0xB3000000); // 70% opacity

  /// Overlay para estados de hover
  static const Color overlayHover = Color(0x14FFFFFF); // 8% opacity

  /// Overlay para estados de pressed
  static const Color overlayPressed = Color(0x1FFFFFFF); // 12% opacity

  // ============================================================================
  // UTILIDADES
  // ============================================================================

  /// Convierte un string hexadecimal a Color
  ///
  /// Ejemplo:
  /// ```dart
  /// final color = AppColors.fromHex('#3BCDFE');
  /// ```
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Convierte un Color a string hexadecimal
  ///
  /// Ejemplo:
  /// ```dart
  /// final hex = AppColors.toHex(Colors.blue); // '#2196F3'
  /// ```
  static String toHex(Color color) {
    final r = (color.r * 255).round().toRadixString(16).padLeft(2, '0');
    final g = (color.g * 255).round().toRadixString(16).padLeft(2, '0');
    final b = (color.b * 255).round().toRadixString(16).padLeft(2, '0');
    return '#$r$g$b'.toUpperCase();
  }

  /// Verifica si un color cumple con el contraste WCAG AA
  /// contra el fondo principal
  ///
  /// Retorna true si el contraste es ≥ 4.5:1
  static bool isAccessible(Color color) {
    final contrast = _calculateContrast(color, background);
    return contrast >= 4.5;
  }

  /// Calcula el ratio de contraste entre dos colores
  /// Basado en WCAG 2.1
  static double _calculateContrast(Color color1, Color color2) {
    final l1 = _relativeLuminance(color1);
    final l2 = _relativeLuminance(color2);
    final lighter = l1 > l2 ? l1 : l2;
    final darker = l1 > l2 ? l2 : l1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Calcula la luminancia relativa de un color
  static double _relativeLuminance(Color color) {
    final r = _linearize((color.r * 255).round() / 255);
    final g = _linearize((color.g * 255).round() / 255);
    final b = _linearize((color.b * 255).round() / 255);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Linealiza un componente de color
  static double _linearize(double component) {
    if (component <= 0.03928) {
      return component / 12.92;
    }
    return math.pow((component + 0.055) / 1.055, 2.4).toDouble();
  }
}

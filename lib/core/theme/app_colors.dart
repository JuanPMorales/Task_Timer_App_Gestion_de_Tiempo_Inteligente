/// Paleta de colores de Task Timer App
///
/// Define los colores primarios, secundarios y semánticos
/// siguiendo las especificaciones del PRD.
library;

import 'package:flutter/material.dart';

/// Clase que contiene todos los colores utilizados en la aplicación.
class AppColors {
  AppColors._(); // Constructor privado para prevenir instanciación

  // Colores Primarios (Azules)
  /// Color azul oscuro principal - Fondo oscuro
  static const Color primaryDark = Color(0xFF0A0E2A);

  /// Color azul claro principal - Acentos
  static const Color primaryLight = Color(0xFF3BCDFE);

  // Gradientes
  /// Gradiente azul para tarjetas y elementos
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primaryDark],
  );

  // Colores Semánticos
  /// Color para mensajes de éxito
  static const Color success = Color(0xFF4CAF50);

  /// Color para mensajes de advertencia
  static const Color warning = Color(0xFFFFA726);

  /// Color para mensajes de error
  static const Color error = Color(0xFFF44336);

  /// Color para información
  static const Color info = Color(0xFF2196F3);

  // Colores de Texto
  /// Texto principal en modo oscuro
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Texto secundario en modo oscuro
  static const Color textSecondary = Color(0xFFB0B0B0);

  /// Texto deshabilitado
  static const Color textDisabled = Color(0xFF757575);

  // Colores de Fondo
  /// Fondo principal de la app
  static const Color background = primaryDark;

  /// Fondo de tarjetas y superficies
  static const Color surface = Color(0xFF1A1F3A);

  // Colores para Tareas (personalizables)
  /// Lista de colores predefinidos para tareas
  static const List<Color> taskColors = [
    Color(0xFF3BCDFE), // Azul claro (default)
    Color(0xFF00BCD4), // Cyan
    Color(0xFF2196F3), // Azul
    Color(0xFF9C27B0), // Púrpura
    Color(0xFFFF9800), // Naranja
  ];

  // Colores de Estado
  /// Timer detenido
  static const Color timerStopped = Color(0xFF757575);

  /// Timer en curso
  static const Color timerRunning = primaryLight;

  /// Timer pausado
  static const Color timerPaused = warning;

  /// Timer completado
  static const Color timerCompleted = success;

  /// Convierte un string hexadecimal a Color
  ///
  /// Ejemplo: `#3BCDFE` → `Color(0xFF3BCDFE)`
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Convierte un Color a string hexadecimal
  ///
  /// Ejemplo: `Color(0xFF3BCDFE)` → `#3BCDFE`
  static String toHex(Color color) {
    // ignore: deprecated_member_use
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}

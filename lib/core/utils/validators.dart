/// Validadores de datos de entrada
///
/// Proporciona funciones de validación para nombres de tareas,
/// duraciones y otros campos del formulario.
library;

import 'package:task_timer/core/constants/app_constants.dart';

/// Clase de utilidades para validación de datos
class Validators {
  Validators._(); // Constructor privado

  /// Valida el nombre de una tarea
  ///
  /// Retorna un mensaje de error si es inválido, `null` si es válido.
  ///
  /// Reglas:
  /// - No puede estar vacío
  /// - Debe tener entre 1 y 50 caracteres
  /// - Solo letras, números, espacios y guiones
  static String? validateTaskName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre de la tarea no puede estar vacío';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < AppConstants.minTaskNameLength) {
      return 'El nombre debe tener al menos ${AppConstants.minTaskNameLength} carácter';
    }

    if (trimmedValue.length > AppConstants.maxTaskNameLength) {
      return 'El nombre no puede exceder ${AppConstants.maxTaskNameLength} caracteres';
    }

    if (!AppConstants.taskNameRegex.hasMatch(trimmedValue)) {
      return 'El nombre solo puede contener letras, números, espacios y guiones';
    }

    return null;
  }

  /// Valida la duración de una tarea en segundos
  ///
  /// Retorna un mensaje de error si es inválido, `null` si es válido.
  ///
  /// Reglas:
  /// - Debe estar entre 60 segundos (1 min) y 86400 segundos (24 horas)
  static String? validateDuration(int? seconds) {
    if (seconds == null) {
      return 'La duración es requerida';
    }

    if (seconds < AppConstants.minTaskDurationSeconds) {
      return 'La duración mínima es 1 minuto';
    }

    if (seconds > AppConstants.maxTaskDurationSeconds) {
      return 'La duración máxima es 24 horas';
    }

    return null;
  }

  /// Valida un color en formato hexadecimal
  ///
  /// Retorna un mensaje de error si es inválido, `null` si es válido.
  ///
  /// Formato esperado: `#RRGGBB` (ej: `#3BCDFE`)
  static String? validateHexColor(String? value) {
    if (value == null || value.isEmpty) {
      return 'El color es requerido';
    }

    if (!AppConstants.hexColorRegex.hasMatch(value)) {
      return 'Formato de color inválido. Use #RRGGBB (ej: #3BCDFE)';
    }

    return null;
  }

  /// Valida que un string no esté vacío
  ///
  /// Retorna un mensaje de error si está vacío, `null` si es válido.
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName no puede estar vacío';
    }
    return null;
  }

  /// Valida que un número esté en un rango específico
  ///
  /// Retorna un mensaje de error si está fuera del rango, `null` si es válido.
  static String? validateNumberRange(
    int? value,
    int min,
    int max,
    String fieldName,
  ) {
    if (value == null) {
      return '$fieldName es requerido';
    }

    if (value < min || value > max) {
      return '$fieldName debe estar entre $min y $max';
    }

    return null;
  }

  /// Valida una duración en formato mm:ss
  ///
  /// Retorna un mensaje de error si es inválido, `null` si es válido.
  ///
  /// Formato esperado: `mm:ss` (ej: `30:00`)
  static String? validateMMSS(String? value) {
    if (value == null || value.isEmpty) {
      return 'El tiempo es requerido';
    }

    final parts = value.split(':');
    if (parts.length != 2) {
      return 'Formato inválido. Use mm:ss (ej: 30:00)';
    }

    final minutes = int.tryParse(parts[0]);
    final seconds = int.tryParse(parts[1]);

    if (minutes == null || seconds == null) {
      return 'Los valores deben ser números';
    }

    if (minutes < 0 || seconds < 0 || seconds >= 60) {
      return 'Valores fuera de rango';
    }

    final totalSeconds = minutes * 60 + seconds;
    return validateDuration(totalSeconds);
  }

  /// Valida que un ID sea válido (no nulo, no vacío)
  ///
  /// Retorna `true` si es válido, `false` si no lo es.
  static bool validateId(String? id) {
    return id != null && id.isNotEmpty;
  }

  /// Valida que un timestamp sea válido
  ///
  /// Retorna `true` si es válido, `false` si no lo es.
  static bool validateTimestamp(DateTime? timestamp) {
    if (timestamp == null) return false;

    // Validar que el timestamp no sea demasiado antiguo (más de 10 años)
    final tenYearsAgo = DateTime.now().subtract(const Duration(days: 3650));
    if (timestamp.isBefore(tenYearsAgo)) return false;

    // Validar que el timestamp no sea en el futuro (con margen de 1 minuto)
    final oneMinuteFromNow = DateTime.now().add(const Duration(minutes: 1));
    if (timestamp.isAfter(oneMinuteFromNow)) return false;

    return true;
  }

  /// Sanitiza un string eliminando espacios extra y caracteres especiales
  ///
  /// Retorna el string limpio.
  static String sanitizeString(String value) {
    return value.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Valida un campo de texto genérico con longitud mínima y máxima
  ///
  /// Retorna un mensaje de error si es inválido, `null` si es válido.
  static String? validateTextLength(
    String? value,
    int minLength,
    int maxLength,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName no puede estar vacío';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < minLength) {
      return '$fieldName debe tener al menos $minLength caracteres';
    }

    if (trimmedValue.length > maxLength) {
      return '$fieldName no puede exceder $maxLength caracteres';
    }

    return null;
  }
}

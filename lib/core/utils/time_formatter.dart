/// Utilidades de formato de tiempo
///
/// Proporciona funciones para convertir y formatear duraciones
/// y timestamps según los requerimientos de la app.
library;

/// Clase de utilidades para formateo de tiempo
class TimeFormatter {
  TimeFormatter._(); // Constructor privado

  /// Formatea segundos a formato mm:ss
  ///
  /// Ejemplo: `125` → `"02:05"`
  static String formatSeconds(int seconds) {
    if (seconds < 0) return '00:00';

    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Formatea segundos a formato hh:mm:ss
  ///
  /// Ejemplo: `3725` → `"01:02:05"`
  static String formatSecondsWithHours(int seconds) {
    if (seconds < 0) return '00:00:00';

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Formatea segundos a formato legible (ej: "2h 5m")
  ///
  /// Ejemplo: `7500` → `"2h 5m"`
  static String formatSecondsHumanReadable(int seconds) {
    if (seconds < 0) return '0m';
    if (seconds < 60) return '${seconds}s';

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;

    if (hours > 0) {
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    }

    return '${minutes}m';
  }

  /// Convierte minutos a segundos
  ///
  /// Ejemplo: `5` → `300`
  static int minutesToSeconds(int minutes) => minutes * 60;

  /// Convierte horas a segundos
  ///
  /// Ejemplo: `2` → `7200`
  static int hoursToSeconds(int hours) => hours * 3600;

  /// Convierte segundos a minutos (redondeado hacia arriba)
  ///
  /// Ejemplo: `125` → `3`
  static int secondsToMinutes(int seconds) => (seconds / 60).ceil();

  /// Convierte segundos a horas (redondeado hacia arriba)
  ///
  /// Ejemplo: `7500` → `3`
  static int secondsToHours(int seconds) => (seconds / 3600).ceil();

  /// Formatea DateTime a formato ISO 8601
  ///
  /// Ejemplo: `DateTime.now()` → `"2025-11-13T10:30:00.000Z"`
  static String formatDateTimeToISO(DateTime dateTime) {
    return dateTime.toUtc().toIso8601String();
  }

  /// Parsea string ISO 8601 a DateTime
  ///
  /// Ejemplo: `"2025-11-13T10:30:00.000Z"` → `DateTime`
  static DateTime? parseDateTimeFromISO(String isoString) {
    try {
      return DateTime.parse(isoString);
    } catch (e) {
      return null;
    }
  }

  /// Calcula el tiempo transcurrido desde un timestamp
  ///
  /// Retorna la diferencia en segundos entre ahora y el timestamp dado.
  static int calculateElapsedSeconds(DateTime startTime) {
    return DateTime.now().difference(startTime).inSeconds;
  }

  /// Calcula el tiempo restante basado en inicio y duración
  ///
  /// Retorna segundos restantes. Si es negativo, retorna 0.
  static int calculateRemainingSeconds(
    DateTime startTime,
    int durationSeconds,
  ) {
    final elapsed = calculateElapsedSeconds(startTime);
    final remaining = durationSeconds - elapsed;
    return remaining < 0 ? 0 : remaining;
  }

  /// Convierte formato mm:ss a segundos
  ///
  /// Ejemplo: `"02:30"` → `150`
  static int? parseMMSSToSeconds(String mmss) {
    try {
      final parts = mmss.split(':');
      if (parts.length != 2) return null;

      final minutes = int.parse(parts[0]);
      final seconds = int.parse(parts[1]);

      if (minutes < 0 || seconds < 0 || seconds >= 60) return null;

      return minutes * 60 + seconds;
    } catch (e) {
      return null;
    }
  }

  /// Formatea una duración a texto descriptivo
  ///
  /// Ejemplo: `3600` → `"1 hora"`, `90` → `"1 minuto 30 segundos"`
  static String formatDurationDescriptive(int seconds) {
    if (seconds < 0) return '0 segundos';

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    final parts = <String>[];

    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? "hora" : "horas"}');
    }
    if (minutes > 0) {
      parts.add('$minutes ${minutes == 1 ? "minuto" : "minutos"}');
    }
    if (secs > 0 || parts.isEmpty) {
      parts.add('$secs ${secs == 1 ? "segundo" : "segundos"}');
    }

    return parts.join(' ');
  }
}

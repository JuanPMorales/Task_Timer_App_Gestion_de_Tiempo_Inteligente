/// Constantes globales de Task Timer App
///
/// Define valores constantes utilizados en toda la aplicación
/// como límites, timeouts y configuraciones.
library;

/// Constantes de la aplicación
class AppConstants {
  AppConstants._(); // Constructor privado

  // Información de la App
  /// Nombre de la aplicación
  static const String appName = 'Task Timer';

  /// Versión actual
  static const String version = '1.0.0';

  // Límites de Tareas
  /// Longitud mínima del nombre de tarea
  static const int minTaskNameLength = 1;

  /// Longitud máxima del nombre de tarea
  static const int maxTaskNameLength = 50;

  /// Duración mínima de tarea en segundos (1 minuto)
  static const int minTaskDurationSeconds = 60;

  /// Duración máxima de tarea en segundos (24 horas)
  static const int maxTaskDurationSeconds = 86400;

  // Límites de Base de Datos
  /// Versión actual de la base de datos
  static const int databaseVersion = 1;

  /// Nombre del archivo de base de datos
  static const String databaseName = 'task_timer.db';

  /// Máximo de tareas antes de advertir al usuario
  static const int maxTasksWarning = 100;

  // Configuración del Timer
  /// Intervalo de actualización del timer en milisegundos
  static const int timerTickIntervalMs = 1000;

  /// Duración de la vibración al completar (milisegundos)
  static const int vibrationDurationMs = 500;

  /// Duración de la animación de completado (milisegundos)
  static const int completionAnimationDurationMs = 1500;

  // Timeouts y Delays
  /// Timeout para operaciones de base de datos (segundos)
  static const int databaseTimeoutSeconds = 30;

  /// Delay para mensajes de feedback (milisegundos)
  static const int feedbackDelayMs = 2000;

  /// Delay para animaciones de entrada (milisegundos)
  static const int entryAnimationDelayMs = 300;

  // Configuración de UI
  /// Altura mínima de elementos táctiles (según Material Design)
  static const double minTouchTargetSize = 48;

  /// Radio de bordes redondeados
  static const double borderRadius = 16;

  /// Espaciado pequeño
  static const double spacingSmall = 8;

  /// Espaciado mediano
  static const double spacingMedium = 16;

  /// Espaciado grande
  static const double spacingLarge = 24;

  /// Espaciado extra grande
  static const double spacingExtraLarge = 32;

  // Animaciones
  /// Duración de animaciones rápidas (milisegundos)
  static const int fastAnimationMs = 200;

  /// Duración de animaciones normales (milisegundos)
  static const int normalAnimationMs = 300;

  /// Duración de animaciones lentas (milisegundos)
  static const int slowAnimationMs = 500;

  // Background Service (Android)
  /// ID de notificación para foreground service
  static const int foregroundServiceNotificationId = 1001;

  /// Canal de notificación para timer
  static const String timerNotificationChannelId = 'task_timer_channel';

  /// Nombre del canal de notificación
  static const String timerNotificationChannelName = 'Task Timer';

  /// Descripción del canal de notificación
  static const String timerNotificationChannelDescription =
      'Notificaciones del cronómetro de tareas';

  // Batería
  /// Nivel de batería crítico (%) para pausar timer
  static const int criticalBatteryLevel = 5;

  // Validaciones
  /// Regex para validar nombres de tareas (letras, números, espacios, guiones)
  static final RegExp taskNameRegex = RegExp(r'^[a-zA-Z0-9\s\-áéíóúÁÉÍÓÚñÑ]+$');

  /// Regex para validar colores hexadecimales
  static final RegExp hexColorRegex = RegExp(r'^#([0-9A-Fa-f]{6})$');

  // Mensajes de Error
  /// Mensaje genérico de error
  static const String genericErrorMessage =
      'Ha ocurrido un error. Por favor, intenta de nuevo.';

  /// Mensaje de error de base de datos
  static const String databaseErrorMessage =
      'Error al acceder a la base de datos.';

  /// Mensaje de error de validación
  static const String validationErrorMessage =
      'Por favor, verifica los datos ingresados.';

  // Mensajes de Éxito
  /// Tarea creada exitosamente
  static const String taskCreatedMessage = 'Tarea creada exitosamente';

  /// Tarea actualizada exitosamente
  static const String taskUpdatedMessage = 'Tarea actualizada exitosamente';

  /// Tarea eliminada exitosamente
  static const String taskDeletedMessage = 'Tarea eliminada exitosamente';

  /// Timer completado
  static const String timerCompletedMessage = '¡Tiempo completado!';

  // Keys de Storage (para preferencias)
  /// Key para última tarea seleccionada
  static const String lastSelectedTaskKey = 'last_selected_task';

  /// Key para modo de tema (futuro)
  static const String themeModeKey = 'theme_mode';

  /// Key para sonido habilitado
  static const String soundEnabledKey = 'sound_enabled';

  /// Key para vibración habilitada
  static const String vibrationEnabledKey = 'vibration_enabled';
}

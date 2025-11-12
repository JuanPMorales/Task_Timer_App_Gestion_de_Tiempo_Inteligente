// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Task Timer';

  @override
  String get tasks => 'Tareas';

  @override
  String get timer => 'Temporizador';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get settings => 'Configuración';

  @override
  String get createTask => 'Crear Tarea';

  @override
  String get editTask => 'Editar Tarea';

  @override
  String get deleteTask => 'Eliminar Tarea';

  @override
  String get taskTitle => 'Título';

  @override
  String get taskDescription => 'Descripción';

  @override
  String get taskEstimatedTime => 'Tiempo Estimado';

  @override
  String get taskPriority => 'Prioridad';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityLow => 'Baja';

  @override
  String get start => 'Iniciar';

  @override
  String get pause => 'Pausar';

  @override
  String get resume => 'Reanudar';

  @override
  String get stop => 'Detener';

  @override
  String get complete => 'Completar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirm => 'Confirmar';

  @override
  String pomodoroMinutes(int minutes) {
    return '$minutes minutos';
  }

  @override
  String completedTasks(int count) {
    return 'Tareas Completadas: $count';
  }

  @override
  String totalTime(int hours, int minutes) {
    return 'Tiempo Total: ${hours}h ${minutes}m';
  }

  @override
  String get taskCompletedNotification => '¡Tarea completada!';

  @override
  String get pomodoroCompletedNotification =>
      '¡Pomodoro completado! Tiempo de descanso.';

  @override
  String get noTasksFound => 'No hay tareas';

  @override
  String get createFirstTask => 'Crea tu primera tarea';

  @override
  String get deleteConfirmation => '¿Estás seguro de eliminar esta tarea?';

  @override
  String get requiredField => 'Este campo es requerido';

  @override
  String get invalidTime => 'Tiempo inválido';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get thisWeek => 'Esta Semana';

  @override
  String get thisMonth => 'Este Mes';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get vibration => 'Vibración';

  @override
  String get about => 'Acerca de';
}

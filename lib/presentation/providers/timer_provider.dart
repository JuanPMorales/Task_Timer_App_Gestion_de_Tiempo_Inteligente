import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Estados posibles del temporizador
enum TimerStatus {
  /// Temporizador detenido (no iniciado o reseteado)
  stopped,

  /// Temporizador en ejecución
  running,

  /// Temporizador pausado
  paused,

  /// Temporizador completado (tiempo agotado)
  completed,
}

/// Estado inmutable del temporizador
@immutable
class TimerState {
  const TimerState({
    required this.status,
    required this.remainingSeconds,
    required this.totalSeconds,
    this.taskId,
    this.error,
  });

  /// Constructor para estado inicial
  const TimerState.initial()
      : status = TimerStatus.stopped,
        remainingSeconds = 0,
        totalSeconds = 0,
        taskId = null,
        error = null;

  /// Estado actual del temporizador
  final TimerStatus status;

  /// Tiempo restante en segundos
  final int remainingSeconds;

  /// Duración total configurada en segundos
  final int totalSeconds;

  /// ID de la tarea asociada (puede ser null si no hay tarea)
  final String? taskId;

  /// Indica si hay un error
  final String? error;

  /// Crea una copia del estado con valores modificados
  TimerState copyWith({
    TimerStatus? status,
    int? remainingSeconds,
    int? totalSeconds,
    String? taskId,
    String? error,
  }) {
    return TimerState(
      status: status ?? this.status,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      taskId: taskId ?? this.taskId,
      error: error ?? this.error,
    );
  }

  /// Porcentaje de progreso (0.0 a 1.0)
  double get progress {
    if (totalSeconds == 0) return 0;
    return 1.0 - (remainingSeconds / totalSeconds);
  }

  /// Indica si el temporizador está activo (corriendo o pausado)
  bool get isActive =>
      status == TimerStatus.running || status == TimerStatus.paused;

  @override
  String toString() {
    return 'TimerState(status: $status, remaining: $remainingSeconds/$totalSeconds, taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimerState &&
        other.status == status &&
        other.remainingSeconds == remainingSeconds &&
        other.totalSeconds == totalSeconds &&
        other.taskId == taskId &&
        other.error == error;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        remainingSeconds.hashCode ^
        totalSeconds.hashCode ^
        taskId.hashCode ^
        error.hashCode;
  }
}

/// Notifier que gestiona el estado y lógica del temporizador
class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(const TimerState.initial());

  /// Timer interno de Dart
  Timer? _timer;

  /// Callback opcional cuando el temporizador se completa
  void Function()? _onCompleted;

  /// Inicia el temporizador con una duración específica
  ///
  /// [durationInSeconds] - Duración total en segundos
  /// [taskId] - ID opcional de la tarea asociada
  /// [onCompleted] - Callback opcional al completar
  void start({
    required int durationInSeconds,
    String? taskId,
    void Function()? onCompleted,
  }) {
    if (durationInSeconds <= 0) {
      state = state.copyWith(
        error: 'La duración debe ser mayor a 0 segundos',
      );
      return;
    }

    // Cancelar timer anterior si existe
    _timer?.cancel();

    // Guardar callback
    _onCompleted = onCompleted;

    // Configurar estado inicial
    state = TimerState(
      status: TimerStatus.running,
      remainingSeconds: durationInSeconds,
      totalSeconds: durationInSeconds,
      taskId: taskId,
    );

    // Iniciar timer periódico (cada segundo)
    _startTicking();
  }

  /// Inicia el tick del temporizador
  void _startTicking() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        // Decrementar tiempo restante
        state = state.copyWith(
          remainingSeconds: state.remainingSeconds - 1,
        );
      } else {
        // Tiempo agotado, completar
        _complete();
      }
    });
  }

  /// Pausa el temporizador
  void pause() {
    if (state.status != TimerStatus.running) {
      return;
    }

    _timer?.cancel();
    state = state.copyWith(status: TimerStatus.paused);
  }

  /// Reanuda el temporizador desde pausa
  void resume() {
    if (state.status != TimerStatus.paused) {
      return;
    }

    state = state.copyWith(status: TimerStatus.running);
    _startTicking();
  }

  /// Completa manualmente el temporizador
  void complete() {
    _complete();
  }

  /// Lógica interna de completar
  void _complete() {
    _timer?.cancel();
    state = state.copyWith(
      status: TimerStatus.completed,
      remainingSeconds: 0,
    );

    // Ejecutar callback si existe
    _onCompleted?.call();
  }

  /// Detiene y resetea el temporizador
  void stop() {
    _timer?.cancel();
    _onCompleted = null;
    state = const TimerState.initial();
  }

  /// Añade tiempo adicional al temporizador
  ///
  /// [additionalSeconds] - Segundos a añadir
  void addTime(int additionalSeconds) {
    if (!state.isActive || additionalSeconds <= 0) {
      return;
    }

    state = state.copyWith(
      remainingSeconds: state.remainingSeconds + additionalSeconds,
      totalSeconds: state.totalSeconds + additionalSeconds,
    );
  }

  /// Limpia recursos al destruir el notifier
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Provider global del temporizador
///
/// Usa [StateNotifierProvider] para gestionar el estado complejo del timer.
/// Este provider es accesible desde cualquier parte de la app.
///
/// Ejemplo de uso:
/// ```dart
/// // Iniciar timer de 25 minutos (Pomodoro)
/// ref.read(timerStateProvider.notifier).start(
///   durationInSeconds: 25 * 60,
///   taskId: 'task-123',
///   onCompleted: () => print('Timer completado!'),
/// );
///
/// // Pausar
/// ref.read(timerStateProvider.notifier).pause();
///
/// // Reanudar
/// ref.read(timerStateProvider.notifier).resume();
///
/// // Obtener estado actual
/// final timerState = ref.watch(timerStateProvider);
/// print('Restante: ${timerState.remainingSeconds}s');
/// ```
final timerStateProvider =
    StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

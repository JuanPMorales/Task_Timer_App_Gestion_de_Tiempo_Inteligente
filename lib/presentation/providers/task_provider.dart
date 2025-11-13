/// Provider para gestión de estado de tareas
///
/// Implementa la lógica de negocio para CRUD de tareas usando Riverpod.
/// Este provider será completado cuando se implementen las entidades
/// y repositorios del módulo de tareas (Sprint 2).
///
/// Arquitectura:
/// TaskListScreen → TaskProvider → TaskRepository → Database
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO(sprint-2): Importar entidades cuando estén implementadas
// import 'package:task_timer/domain/entities/task.dart';
// import 'package:task_timer/domain/repositories/task_repository.dart';

/// Estado de la lista de tareas
///
/// Maneja el estado de carga, datos y errores de las tareas.
class TaskListState {
  const TaskListState({
    this.tasks = const [],
    this.isLoading = false,
    this.error,
  });

  /// Lista de tareas activas (no archivadas)
  // TODO(sprint-2): Cambiar a List<Task> cuando Task esté implementada
  final List<dynamic> tasks;

  /// Indica si se están cargando las tareas
  final bool isLoading;

  /// Mensaje de error si ocurre algún problema
  final String? error;

  /// Crea una copia del estado con nuevos valores
  TaskListState copyWith({
    List<dynamic>? tasks,
    bool? isLoading,
    String? error,
  }) {
    return TaskListState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Notifier para gestionar el estado de las tareas
///
/// Proporciona métodos para crear, actualizar, eliminar y consultar tareas.
class TaskListNotifier extends StateNotifier<TaskListState> {
  TaskListNotifier() : super(const TaskListState());

  // TODO(sprint-2): Inyectar TaskRepository
  // final TaskRepository _repository;
  // TaskListNotifier(this._repository) : super(const TaskListState());

  /// Carga todas las tareas desde la base de datos
  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true);

    try {
      // TODO(sprint-2): Implementar con repository real
      // final tasks = await _repository.getAll();
      // state = state.copyWith(tasks: tasks, isLoading: false);

      // Placeholder: lista vacía
      state = state.copyWith(tasks: [], isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar tareas: $e',
      );
    }
  }

  /// Crea una nueva tarea
  ///
  /// Parámetros:
  /// - [name]: Nombre de la tarea
  /// - [durationSeconds]: Duración en segundos
  /// - [color]: Color hexadecimal (ej: '#3BCDFE')
  Future<void> createTask({
    required String name,
    required int durationSeconds,
    required String color,
  }) async {
    try {
      // TODO(sprint-2): Implementar validaciones
      // if (name.trim().isEmpty) {
      //   throw ValidationException('El nombre no puede estar vacío');
      // }

      // TODO(sprint-2): Crear tarea con repository
      // final task = Task(
      //   id: uuid.v4(),
      //   name: name,
      //   durationSeconds: durationSeconds,
      //   color: color,
      //   createdAt: DateTime.now(),
      // );
      // await _repository.create(task);

      // Recargar lista
      await loadTasks();
    } catch (e) {
      state = state.copyWith(error: 'Error al crear tarea: $e');
      rethrow;
    }
  }

  /// Actualiza una tarea existente
  ///
  /// Parámetros:
  /// - [taskId]: ID de la tarea a actualizar
  /// - [name]: Nuevo nombre (opcional)
  /// - [durationSeconds]: Nueva duración (opcional)
  /// - [color]: Nuevo color (opcional)
  Future<void> updateTask({
    required String taskId,
    String? name,
    int? durationSeconds,
    String? color,
  }) async {
    try {
      // TODO(sprint-2): Implementar con repository
      // final currentTask = state.tasks.firstWhere((t) => t.id == taskId);
      // final updatedTask = currentTask.copyWith(
      //   name: name ?? currentTask.name,
      //   durationSeconds: durationSeconds ?? currentTask.durationSeconds,
      //   color: color ?? currentTask.color,
      // );
      // await _repository.update(updatedTask);

      await loadTasks();
    } catch (e) {
      state = state.copyWith(error: 'Error al actualizar tarea: $e');
      rethrow;
    }
  }

  /// Elimina una tarea
  ///
  /// Parámetros:
  /// - [taskId]: ID de la tarea a eliminar
  Future<void> deleteTask(String taskId) async {
    try {
      // TODO(sprint-2): Implementar con repository
      // await _repository.delete(taskId);

      await loadTasks();
    } catch (e) {
      state = state.copyWith(error: 'Error al eliminar tarea: $e');
      rethrow;
    }
  }

  /// Archiva una tarea (eliminación lógica)
  ///
  /// Parámetros:
  /// - [taskId]: ID de la tarea a archivar
  Future<void> archiveTask(String taskId) async {
    try {
      // TODO(sprint-2): Implementar con repository
      // await _repository.archive(taskId);

      await loadTasks();
    } catch (e) {
      state = state.copyWith(error: 'Error al archivar tarea: $e');
      rethrow;
    }
  }

  /// Limpia el mensaje de error actual
  void clearError() {
    state = state.copyWith();
  }
}

/// Provider global para la lista de tareas
///
/// Este provider gestiona el estado de todas las tareas de la aplicación.
/// Utiliza [StateNotifierProvider] para proporcionar reactividad automática.
///
/// Uso en widgets:
/// ```dart
/// class TaskListScreen extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final taskState = ref.watch(taskListProvider);
///     final taskNotifier = ref.read(taskListProvider.notifier);
///
///     if (taskState.isLoading) {
///       return CircularProgressIndicator();
///     }
///
///     return ListView.builder(
///       itemCount: taskState.tasks.length,
///       itemBuilder: (context, index) {
///         final task = taskState.tasks[index];
///         return TaskCard(task: task);
///       },
///     );
///   }
/// }
/// ```
final taskListProvider =
    StateNotifierProvider<TaskListNotifier, TaskListState>((ref) {
  // TODO(sprint-2): Inyectar dependencias
  // final repository = ref.watch(taskRepositoryProvider);
  // return TaskListNotifier(repository);

  return TaskListNotifier();
});

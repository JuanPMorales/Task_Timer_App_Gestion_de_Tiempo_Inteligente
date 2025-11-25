import 'package:task_timer/data/models/task_model.dart';

/// Interfaz para la fuente de datos local de tareas
///
/// Define los métodos para interactuar con la base de datos local (SQLite).
/// Lanza excepciones en caso de error, que serán manejadas por el repositorio.
abstract class TaskLocalDataSource {
  /// Crea una nueva tarea en la base de datos
  Future<void> createTask(TaskModel task);

  /// Obtiene todas las tareas de la base de datos
  Future<List<TaskModel>> getAllTasks();

  /// Obtiene una tarea por su ID
  Future<TaskModel?> getTaskById(int id);

  /// Actualiza una tarea existente
  Future<void> updateTask(TaskModel task);

  /// Elimina una tarea por su ID
  Future<void> deleteTask(int id);
}

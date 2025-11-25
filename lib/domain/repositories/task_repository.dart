import 'package:dartz/dartz.dart' hide Task;
import 'package:task_timer/core/errors/failures.dart';
import 'package:task_timer/domain/entities/task.dart';

/// Interfaz del repositorio de tareas
///
/// Define los métodos que deben implementar las fuentes de datos (SQLite, API, etc.)
/// para gestionar las tareas. Utiliza [Either] para el manejo de errores funcional.
abstract class TaskRepository {
  /// Crea una nueva tarea
  Future<Either<Failure, void>> createTask(Task task);

  /// Obtiene todas las tareas
  Future<Either<Failure, List<Task>>> getAllTasks();

  /// Obtiene una tarea por su ID
  Future<Either<Failure, Task?>> getTaskById(int id);

  /// Actualiza una tarea existente
  Future<Either<Failure, void>> updateTask(Task task);

  /// Elimina una tarea por su ID
  Future<Either<Failure, void>> deleteTask(int id);
}

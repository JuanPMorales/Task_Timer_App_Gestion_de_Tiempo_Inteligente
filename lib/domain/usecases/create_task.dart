import 'package:dartz/dartz.dart' hide Task;
import 'package:task_timer/core/errors/failures.dart';
import 'package:task_timer/domain/entities/task.dart';
import 'package:task_timer/domain/repositories/task_repository.dart';

/// Caso de uso para crear una nueva tarea
///
/// Encapsula la lógica de negocio necesaria para la creación de tareas.
/// Delega la persistencia al [TaskRepository].
class CreateTaskUseCase {
  CreateTaskUseCase(this.repository);

  final TaskRepository repository;

  /// Ejecuta el caso de uso
  ///
  /// Recibe una entidad [Task] y retorna un [Either] con un [Failure] o void.
  Future<Either<Failure, void>> call(Task task) {
    return repository.createTask(task);
  }
}

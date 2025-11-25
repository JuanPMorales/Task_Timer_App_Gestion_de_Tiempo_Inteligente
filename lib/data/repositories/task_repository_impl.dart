import 'package:dartz/dartz.dart' hide Task;
import 'package:task_timer/core/errors/exceptions.dart';
import 'package:task_timer/core/errors/failures.dart';
import 'package:task_timer/data/datasources/task_local_datasource.dart';
import 'package:task_timer/data/models/task_model.dart';
import 'package:task_timer/domain/entities/task.dart';
import 'package:task_timer/domain/repositories/task_repository.dart';

/// Implementación del repositorio de tareas
///
/// Coordina la interacción entre la capa de dominio y la fuente de datos local.
/// Se encarga de:
/// 1. Convertir Entidades <-> Modelos
/// 2. Manejar excepciones y convertirlas en Failures (Either)
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({required this.localDataSource});
  final TaskLocalDataSource localDataSource;

  @override
  Future<Either<Failure, void>> createTask(Task task) async {
    final validation = _validateTask(task);
    if (validation.isLeft()) {
      return validation;
    }

    try {
      final taskModel = TaskModel.fromEntity(task);
      await localDataSource.createTask(taskModel);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      await localDataSource.deleteTask(id);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getAllTasks() async {
    try {
      final taskModels = await localDataSource.getAllTasks();
      // Los modelos son subclases de Task, así que esto es válido,
      // pero por pureza podríamos mapearlos explícitamente si fuera necesario.
      // Dado que TaskModel extends Task, podemos retornarlos directamente.
      return Right(taskModels);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task?>> getTaskById(int id) async {
    try {
      final taskModel = await localDataSource.getTaskById(id);
      return Right(taskModel);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(Task task) async {
    final validation = _validateTask(task);
    if (validation.isLeft()) {
      return validation;
    }

    try {
      final taskModel = TaskModel.fromEntity(task);
      await localDataSource.updateTask(taskModel);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Either<Failure, void> _validateTask(Task task) {
    final errors = <String, String>{};

    if (task.name.trim().isEmpty) {
      errors['name'] = 'El nombre no puede estar vacío';
    }

    if (task.duration <= 0) {
      errors['duration'] = 'La duración debe ser mayor a 0';
    }

    if (errors.isNotEmpty) {
      return Left(ValidationFailure('Datos de tarea inválidos', errors));
    }

    return const Right(null);
  }
}

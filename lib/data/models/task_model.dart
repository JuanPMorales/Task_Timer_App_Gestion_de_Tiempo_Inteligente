import 'package:task_timer/domain/entities/task.dart';

/// Modelo de datos para la entidad Task
///
/// Extiende la entidad de dominio [Task] para agregar funcionalidades
/// de serialización (JSON/Map) necesarias para la capa de datos (SQLite/API).
class TaskModel extends Task {
  const TaskModel({
    required super.name,
    required super.duration,
    required super.color,
    required super.createdAt,
    super.id,
    super.archived,
  });

  /// Crea una instancia de [TaskModel] a partir de una entidad [Task]
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      name: task.name,
      duration: task.duration,
      color: task.color,
      createdAt: task.createdAt,
      archived: task.archived,
    );
  }

  /// Crea una instancia de [TaskModel] a partir de un Map (JSON/SQLite)
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      duration: map['duration'] as int,
      color: map['color'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      // SQLite guarda bools como 0 o 1
      archived: (map['archived'] as int) == 1,
    );
  }

  /// Convierte el modelo a un Map compatible con SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'color': color,
      'created_at': createdAt.toIso8601String(),
      'archived': archived ? 1 : 0,
    };
  }

  /// Crea una copia del modelo con los campos modificados
  @override
  TaskModel copyWith({
    int? id,
    String? name,
    int? duration,
    int? color,
    DateTime? createdAt,
    bool? archived,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      archived: archived ?? this.archived,
    );
  }
}

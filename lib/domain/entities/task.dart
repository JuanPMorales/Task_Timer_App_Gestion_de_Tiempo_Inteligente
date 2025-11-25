import 'package:flutter/foundation.dart';

/// Entidad de dominio que representa una tarea
///
/// Contiene la información esencial de una tarea independiente de la capa de datos o presentación.
@immutable
class Task {
  const Task({
    required this.name,
    required this.duration,
    required this.color,
    required this.createdAt,
    this.id,
    this.archived = false,
  });

  /// Identificador único de la tarea (null si es nueva y no se ha guardado)
  final int? id;

  /// Nombre descriptivo de la tarea
  final String name;

  /// Duración de la tarea en segundos
  final int duration;

  /// Color asociado a la tarea (valor ARGB)
  final int color;

  /// Fecha de creación de la tarea
  final DateTime createdAt;

  /// Indica si la tarea ha sido archivada
  final bool archived;

  /// Crea una copia de la tarea con los campos modificados
  Task copyWith({
    int? id,
    String? name,
    int? duration,
    int? color,
    DateTime? createdAt,
    bool? archived,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      archived: archived ?? this.archived,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.name == name &&
        other.duration == duration &&
        other.color == color &&
        other.createdAt == createdAt &&
        other.archived == archived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        duration.hashCode ^
        color.hashCode ^
        createdAt.hashCode ^
        archived.hashCode;
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name, duration: $duration, color: $color, createdAt: $createdAt, archived: $archived)';
  }
}

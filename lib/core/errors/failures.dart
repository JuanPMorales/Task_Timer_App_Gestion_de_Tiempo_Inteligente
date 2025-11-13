/// Fallos (Failures) para la capa de dominio
///
/// Representa errores de negocio en la capa de dominio,
/// independientes de la implementación técnica.
library;

/// Fallo base abstracto
abstract class Failure {
  /// Constructor
  const Failure(this.message);

  /// Mensaje descriptivo del fallo
  final String message;

  @override
  String toString() => 'Failure: $message';
}

/// Fallo de validación de datos
class ValidationFailure extends Failure {
  /// Constructor
  const ValidationFailure(super.message, [this.fieldErrors]);

  /// Campos con errores
  final Map<String, String>? fieldErrors;

  @override
  String toString() {
    if (fieldErrors != null && fieldErrors!.isNotEmpty) {
      final errors =
          fieldErrors!.entries.map((e) => '${e.key}: ${e.value}').join(', ');
      return 'ValidationFailure: $message ($errors)';
    }
    return 'ValidationFailure: $message';
  }
}

/// Fallo de base de datos
class DatabaseFailure extends Failure {
  /// Constructor
  const DatabaseFailure(super.message);

  @override
  String toString() => 'DatabaseFailure: $message';
}

/// Fallo de entidad no encontrada
class NotFoundFailure extends Failure {
  /// Constructor
  const NotFoundFailure(super.message);

  @override
  String toString() => 'NotFoundFailure: $message';
}

/// Fallo de estado inválido
class InvalidStateFailure extends Failure {
  /// Constructor
  const InvalidStateFailure(super.message);

  @override
  String toString() => 'InvalidStateFailure: $message';
}

/// Fallo de operación no permitida
class OperationNotAllowedFailure extends Failure {
  /// Constructor
  const OperationNotAllowedFailure(super.message);

  @override
  String toString() => 'OperationNotAllowedFailure: $message';
}

/// Fallo de permiso denegado
class PermissionDeniedFailure extends Failure {
  /// Constructor
  const PermissionDeniedFailure(super.message);

  @override
  String toString() => 'PermissionDeniedFailure: $message';
}

/// Fallo de timeout
class TimeoutFailure extends Failure {
  /// Constructor
  const TimeoutFailure(super.message);

  @override
  String toString() => 'TimeoutFailure: $message';
}

/// Fallo de corrupción de datos
class DataCorruptionFailure extends DatabaseFailure {
  /// Constructor
  const DataCorruptionFailure(super.message);

  @override
  String toString() => 'DataCorruptionFailure: $message';
}

/// Fallo desconocido
class UnknownFailure extends Failure {
  /// Constructor
  const UnknownFailure(super.message);

  @override
  String toString() => 'UnknownFailure: $message';
}

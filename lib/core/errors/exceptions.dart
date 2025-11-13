/// Excepciones personalizadas de Task Timer
///
/// Define las excepciones específicas de la aplicación
/// para un mejor manejo de errores.
library;

/// Excepción base para todas las excepciones de la app
abstract class AppException implements Exception {
  /// Constructor
  const AppException(this.message, [this.cause]);

  /// Mensaje de error
  final String message;

  /// Causa original del error (opcional)
  final dynamic cause;

  @override
  String toString() =>
      'AppException: $message${cause != null ? ' (Causa: $cause)' : ''}';
}

/// Excepción de validación de datos
class ValidationException extends AppException {
  /// Constructor
  const ValidationException(super.message, [super.cause]);

  @override
  String toString() => 'ValidationException: $message';
}

/// Excepción de base de datos
class DatabaseException extends AppException {
  /// Constructor
  const DatabaseException(super.message, [super.cause]);

  @override
  String toString() => 'DatabaseException: $message';
}

/// Excepción de entidad no encontrada
class NotFoundException extends AppException {
  /// Constructor
  const NotFoundException(this.entityType, this.entityId)
      : super('$entityType con ID $entityId no encontrado');

  /// Tipo de entidad no encontrada (ej: 'Task', 'TimerSession')
  final String entityType;

  /// ID de la entidad buscada
  final String entityId;

  @override
  String toString() => 'NotFoundException: $message';
}

/// Excepción de estado inválido
class InvalidStateException extends AppException {
  /// Constructor
  InvalidStateException(this.expectedState, this.currentState)
      : super(
          'Estado inválido: se esperaba "$expectedState", pero el estado actual es "$currentState"',
        );

  /// Estado esperado
  final String expectedState;

  /// Estado actual
  final String currentState;

  @override
  String toString() => 'InvalidStateException: $message';
}

/// Excepción de operación no permitida
class OperationNotAllowedException extends AppException {
  /// Constructor
  const OperationNotAllowedException(super.message, [super.cause]);

  @override
  String toString() => 'OperationNotAllowedException: $message';
}

/// Excepción de permiso denegado
class PermissionDeniedException extends AppException {
  /// Constructor
  PermissionDeniedException(this.permission)
      : super('Permiso denegado: $permission');

  /// Nombre del permiso denegado
  final String permission;

  @override
  String toString() => 'PermissionDeniedException: $message';
}

/// Excepción de timeout
class TimeoutException extends AppException {
  /// Constructor
  // ignore: inference_failure_on_untyped_parameter
  TimeoutException(this.timeoutSeconds, [cause])
      : super(
          'La operación excedió el tiempo límite de $timeoutSeconds segundos',
          cause,
        );

  /// Duración del timeout en segundos
  final int timeoutSeconds;

  @override
  String toString() => 'TimeoutException: $message';
}

/// Excepción de corrupción de datos
class DataCorruptionException extends DatabaseException {
  /// Constructor
  const DataCorruptionException(super.message, [super.cause]);

  @override
  String toString() => 'DataCorruptionException: $message';
}

/// Excepción de servicio no disponible
class ServiceUnavailableException extends AppException {
  /// Constructor
  ServiceUnavailableException(this.serviceName)
      : super('Servicio no disponible: $serviceName');

  /// Nombre del servicio no disponible
  final String serviceName;

  @override
  String toString() => 'ServiceUnavailableException: $message';
}

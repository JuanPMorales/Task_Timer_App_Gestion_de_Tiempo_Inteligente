import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:task_timer/core/errors/exceptions.dart';

/// Clase Helper para manejar la base de datos SQLite
///
/// Implementa el patrón Singleton para asegurar una única instancia de conexión.
class DatabaseHelper {
  // Factory constructor para retornar la instancia única
  factory DatabaseHelper() => _instance;
  // Constructor privado
  DatabaseHelper._internal();

  // Instancia única
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static sqflite.Database? _database;

  /// Obtiene la instancia de la base de datos.
  /// Si no existe, la inicializa.
  Future<sqflite.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// Inicializa la base de datos
  Future<sqflite.Database> _initDB() async {
    try {
      final dbPath = await sqflite.getDatabasesPath();
      final path = join(dbPath, 'task_timer.db');

      return await sqflite.openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
        onUpgrade: _upgradeDB,
      );
    } catch (e) {
      throw DatabaseException('Error al inicializar la base de datos', e);
    }
  }

  /// Crea las tablas de la base de datos
  Future<void> _createDB(sqflite.Database db, int version) async {
    // Tabla de Tareas
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        duration INTEGER NOT NULL,
        color INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        archived INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // TODO: Definir tabla timer_sessions cuando se implemente el módulo 4
  }

  /// Maneja las actualizaciones de versión de la base de datos
  Future<void> _upgradeDB(
      sqflite.Database db, int oldVersion, int newVersion) async {
    // Implementar migraciones aquí cuando sea necesario
    if (oldVersion < newVersion) {
      // Lógica de migración
    }
  }

  /// Cierra la conexión a la base de datos
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}

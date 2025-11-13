import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Estado de la base de datos
enum DatabaseStatus {
  /// Base de datos no inicializada
  uninitialized,

  /// Inicializando base de datos
  initializing,

  /// Base de datos lista para usar
  ready,

  /// Error al inicializar
  error,
}

/// Provider que gestiona la instancia de la base de datos SQLite
///
/// Este provider es responsable de:
/// - Inicializar la base de datos local
/// - Crear las tablas necesarias
/// - Proporcionar acceso a la instancia de Database
/// - Manejar migraciones de esquema
///
/// Ejemplo de uso:
/// ```dart
/// // Obtener instancia de la base de datos
/// final dbAsyncValue = ref.watch(databaseProvider);
///
/// dbAsyncValue.when(
///   data: (db) {
///     // Usar la base de datos
///     await db.query('tasks');
///   },
///   loading: () => CircularProgressIndicator(),
///   error: (error, stack) => Text('Error: $error'),
/// );
/// ```
final databaseProvider = FutureProvider<Database>((ref) async {
  return DatabaseHelper.instance.database;
});

/// Estado del estado de la base de datos para UI reactiva
///
/// Permite a los widgets reaccionar al estado de inicialización
final databaseStatusProvider = StateProvider<DatabaseStatus>((ref) {
  return DatabaseStatus.uninitialized;
});

/// Helper singleton para gestión de la base de datos
///
/// Implementa el patrón Singleton para garantizar una única instancia
/// de la base de datos en toda la aplicación.
class DatabaseHelper {
  // Constructor privado
  DatabaseHelper._internal();
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._internal();

  // Instancia de la base de datos
  static Database? _database;

  /// Nombre de la base de datos
  static const String _databaseName = 'task_timer.db';

  /// Versión de la base de datos (incrementar para migraciones)
  static const int _databaseVersion = 1;

  /// Nombres de las tablas
  static const String tableTask = 'tasks';
  static const String tableTimeEntry = 'time_entries';
  static const String tableCategory = 'categories';

  /// Obtener instancia de la base de datos
  ///
  /// Inicializa la base de datos si no está creada
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializar base de datos
  Future<Database> _initDatabase() async {
    // Obtener path de la base de datos
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    // Abrir/crear base de datos
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Crear tablas en la primera ejecución
  Future<void> _onCreate(Database db, int version) async {
    // Tabla de tareas
    await db.execute('''
      CREATE TABLE $tableTask (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        category_id TEXT,
        status TEXT NOT NULL DEFAULT 'pending',
        priority TEXT NOT NULL DEFAULT 'medium',
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        completed_at INTEGER,
        archived_at INTEGER,
        estimated_minutes INTEGER,
        actual_minutes INTEGER DEFAULT 0,
        tags TEXT,
        color TEXT,
        sort_order INTEGER DEFAULT 0,
        FOREIGN KEY (category_id) REFERENCES $tableCategory (id) ON DELETE SET NULL
      )
    ''');

    // Tabla de entradas de tiempo (registros de temporizador)
    await db.execute('''
      CREATE TABLE $tableTimeEntry (
        id TEXT PRIMARY KEY,
        task_id TEXT NOT NULL,
        start_time INTEGER NOT NULL,
        end_time INTEGER,
        duration_seconds INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (task_id) REFERENCES $tableTask (id) ON DELETE CASCADE
      )
    ''');

    // Tabla de categorías
    await db.execute('''
      CREATE TABLE $tableCategory (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        color TEXT NOT NULL,
        icon TEXT,
        created_at INTEGER NOT NULL,
        sort_order INTEGER DEFAULT 0
      )
    ''');

    // Índices para mejorar performance
    await db.execute(
      'CREATE INDEX idx_task_status ON $tableTask (status)',
    );
    await db.execute(
      'CREATE INDEX idx_task_category ON $tableTask (category_id)',
    );
    await db.execute(
      'CREATE INDEX idx_time_entry_task ON $tableTimeEntry (task_id)',
    );
    await db.execute(
      'CREATE INDEX idx_task_created ON $tableTask (created_at DESC)',
    );

    // Insertar categoría por defecto
    await db.insert(tableCategory, {
      'id': 'default',
      'name': 'General',
      'color': '#2196F3',
      'icon': 'work',
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'sort_order': 0,
    });
  }

  /// Migrar base de datos a nueva versión
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // TODO(sprint2): Implementar migraciones cuando sea necesario
    // Ejemplo:
    // if (oldVersion < 2) {
    //   await db.execute('ALTER TABLE $tableTask ADD COLUMN new_field TEXT');
    // }
  }

  /// Cerrar base de datos
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  /// Eliminar base de datos (útil para testing o reset completo)
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }

  /// Obtener información de la base de datos
  Future<Map<String, dynamic>> getDatabaseInfo() async {
    final db = await database;
    final tasks = await db.query(tableTask);
    final timeEntries = await db.query(tableTimeEntry);
    final categories = await db.query(tableCategory);

    return {
      'database_name': _databaseName,
      'database_version': _databaseVersion,
      'tasks_count': tasks.length,
      'time_entries_count': timeEntries.length,
      'categories_count': categories.length,
      'path': db.path,
    };
  }

  /// Limpiar todas las tablas (mantener estructura)
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(tableTimeEntry);
    await db.delete(tableTask);
    await db.delete(tableCategory);

    // Reinsertar categoría por defecto
    await db.insert(tableCategory, {
      'id': 'default',
      'name': 'General',
      'color': '#2196F3',
      'icon': 'work',
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'sort_order': 0,
    });
  }
}

/// Provider de información de la base de datos
///
/// Proporciona información útil sobre el estado de la BD
final databaseInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return DatabaseHelper.instance.getDatabaseInfo();
});

# Providers - Task Timer App

**Versión:** 1.0 (Sprint 1 - MVP)  
**Última actualización:** 2025-11-13  
**Estado:** Documentación completa de providers implementados

---

## 📋 Índice

1. [Introducción](#introducción)
2. [Jerarquía de Providers](#jerarquía-de-providers)
3. [Providers Implementados](#providers-implementados)
4. [Relaciones y Dependencias](#relaciones-y-dependencias)
5. [Patrones de Uso](#patrones-de-uso)
6. [Guías de Implementación](#guías-de-implementación)
7. [Roadmap Futuro](#roadmap-futuro)

---

## 📖 Introducción

Este documento describe la arquitectura de providers implementada en la aplicación Task Timer usando **Riverpod** como solución de gestión de estado. Los providers son la capa de presentación que conecta la UI con la lógica de negocio y la capa de datos.

### Principios de Diseño

- **Separación de responsabilidades**: Cada provider tiene una responsabilidad única y bien definida
- **Inmutabilidad**: Los estados son inmutables y se modifican mediante `copyWith()`
- **Reactividad**: Los widgets se reconstruyen automáticamente cuando cambian los providers
- **Testabilidad**: Providers son fáciles de testear gracias a la inyección de dependencias de Riverpod

### Tipos de Providers Usados

| Tipo | Uso | Ejemplo |
|------|-----|---------|
| `StateNotifierProvider` | Estado complejo con lógica | `taskListProvider`, `timerStateProvider` |
| `FutureProvider` | Datos asíncronos | `databaseProvider`, `databaseInfoProvider` |
| `StateProvider` | Estado simple | `databaseStatusProvider` |

---

## 🏗️ Jerarquía de Providers

```
ProviderScope (main.dart)
├── databaseProvider [FutureProvider<Database>]
│   └── Proporciona: Instancia de SQLite Database
│
├── databaseStatusProvider [StateProvider<DatabaseStatus>]
│   └── Proporciona: Estado de inicialización de BD
│
├── databaseInfoProvider [FutureProvider<Map>]
│   └── Proporciona: Información de la BD (conteos, path, versión)
│
├── taskListProvider [StateNotifierProvider<TaskListNotifier, TaskListState>]
│   ├── Proporciona: Lista de tareas y operaciones CRUD
│   └── Dependencias futuras (Sprint 2): databaseProvider
│
└── timerStateProvider [StateNotifierProvider<TimerNotifier, TimerState>]
    ├── Proporciona: Estado del temporizador y control
    └── Dependencias futuras (Sprint 2): taskListProvider (para guardar tiempo)
```

### Diagrama de Flujo de Datos

```
┌─────────────────────────────────────────────────────────────┐
│                        UI LAYER                              │
│  (Widgets consumen providers mediante ref.watch/ref.read)   │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                   PROVIDER LAYER                             │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ taskList     │  │ timerState   │  │ database     │      │
│  │ Provider     │  │ Provider     │  │ Provider     │      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘      │
│         │                  │                  │              │
│         └──────────────────┴──────────────────┘              │
│                            │                                 │
└────────────────────────────┼─────────────────────────────────┘
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                   DATA LAYER (Sprint 2)                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Task         │  │ TimeEntry    │  │ SQLite       │      │
│  │ Repository   │  │ Repository   │  │ Database     │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔌 Providers Implementados

### 1. databaseProvider

**Tipo:** `FutureProvider<Database>`  
**Archivo:** `lib/presentation/providers/database_provider.dart`  
**Responsabilidad:** Proporcionar acceso a la instancia de SQLite Database

#### Características

- ✅ Inicializa la base de datos local
- ✅ Crea tablas: `tasks`, `time_entries`, `categories`
- ✅ Gestiona migraciones de esquema
- ✅ Implementa patrón Singleton mediante `DatabaseHelper`

#### API

```dart
// Obtener instancia de BD
final dbAsyncValue = ref.watch(databaseProvider);

dbAsyncValue.when(
  data: (db) async {
    // Base de datos lista
    await db.query('tasks');
  },
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
);
```

#### Estado

```dart
AsyncValue<Database> {
  data: Database instance,
  loading: bool,
  error: Object?,
}
```

---

### 2. databaseStatusProvider

**Tipo:** `StateProvider<DatabaseStatus>`  
**Archivo:** `lib/presentation/providers/database_provider.dart`  
**Responsabilidad:** Estado reactivo de inicialización de BD para UI

#### Estados Posibles

```dart
enum DatabaseStatus {
  uninitialized,  // No inicializada
  initializing,   // En proceso
  ready,          // Lista para usar
  error,          // Error
}
```

#### API

```dart
// Leer estado
final status = ref.watch(databaseStatusProvider);

// Actualizar estado
ref.read(databaseStatusProvider.notifier).state = DatabaseStatus.ready;
```

---

### 3. databaseInfoProvider

**Tipo:** `FutureProvider<Map<String, dynamic>>`  
**Archivo:** `lib/presentation/providers/database_provider.dart`  
**Responsabilidad:** Información útil de la BD (debugging, configuración)

#### Datos Proporcionados

```dart
{
  'database_name': 'task_timer.db',
  'database_version': 1,
  'tasks_count': 10,
  'time_entries_count': 45,
  'categories_count': 5,
  'path': '/data/..../task_timer.db',
}
```

#### API

```dart
final infoAsyncValue = ref.watch(databaseInfoProvider);

infoAsyncValue.whenData((info) {
  print('Tasks: ${info['tasks_count']}');
  print('Path: ${info['path']}');
});
```

---

### 4. taskListProvider

**Tipo:** `StateNotifierProvider<TaskListNotifier, TaskListState>`  
**Archivo:** `lib/presentation/providers/task_provider.dart`  
**Responsabilidad:** Gestión del estado de la lista de tareas

#### Estado (TaskListState)

```dart
class TaskListState {
  final List<dynamic> tasks;      // TODO Sprint 2: List<Task>
  final bool isLoading;
  final String? error;
  
  // Getters
  int get taskCount;
  bool get hasError;
  bool get isEmpty;
}
```

#### Métodos del Notifier

| Método | Descripción | Estado MVP |
|--------|-------------|------------|
| `loadTasks()` | Cargar todas las tareas | ⏳ Placeholder |
| `createTask()` | Crear nueva tarea | ⏳ Placeholder |
| `updateTask()` | Actualizar tarea existente | ⏳ Placeholder |
| `deleteTask()` | Eliminar tarea | ⏳ Placeholder |
| `archiveTask()` | Archivar tarea | ⏳ Placeholder |

#### API

```dart
// Leer estado
final taskState = ref.watch(taskListProvider);

// Operaciones
await ref.read(taskListProvider.notifier).loadTasks();
await ref.read(taskListProvider.notifier).createTask(
  title: 'Nueva tarea',
  description: 'Descripción',
);
```

#### TODOs para Sprint 2

- [ ] Integrar con `Task` entity de dominio
- [ ] Integrar con `TaskRepository`
- [ ] Implementar lógica real (actualmente placeholders)
- [ ] Agregar filtros y ordenamiento
- [ ] Implementar caché local

---

### 5. timerStateProvider

**Tipo:** `StateNotifierProvider<TimerNotifier, TimerState>`  
**Archivo:** `lib/presentation/providers/timer_provider.dart`  
**Responsabilidad:** Gestión del estado del temporizador

#### Estado (TimerState)

```dart
class TimerState {
  final TimerStatus status;        // stopped, running, paused, completed
  final int remainingSeconds;
  final int totalSeconds;
  final String? taskId;
  final String? error;
  
  // Getters calculados
  double get progress;              // 0.0 a 1.0
  bool get isActive;                // running o paused
}
```

#### Estados del Temporizador

```dart
enum TimerStatus {
  stopped,      // No iniciado o reseteado
  running,      // En ejecución
  paused,       // Pausado
  completed,    // Tiempo agotado
}
```

#### Métodos del Notifier

| Método | Descripción | Parámetros |
|--------|-------------|------------|
| `start()` | Iniciar temporizador | `durationInSeconds`, `taskId?`, `onCompleted?` |
| `pause()` | Pausar temporizador | - |
| `resume()` | Reanudar desde pausa | - |
| `complete()` | Completar manualmente | - |
| `stop()` | Detener y resetear | - |
| `addTime()` | Añadir tiempo extra | `additionalSeconds` |

#### API

```dart
// Leer estado
final timerState = ref.watch(timerStateProvider);

// Iniciar timer de 25 minutos (Pomodoro)
ref.read(timerStateProvider.notifier).start(
  durationInSeconds: 25 * 60,
  taskId: 'task-123',
  onCompleted: () => print('Completado!'),
);

// Controles
ref.read(timerStateProvider.notifier).pause();
ref.read(timerStateProvider.notifier).resume();
ref.read(timerStateProvider.notifier).stop();
```

#### TODOs para Sprint 2

- [ ] Guardar tiempo en `taskListProvider` al completar
- [ ] Persistir estado del timer en BD
- [ ] Integrar con notificaciones
- [ ] Añadir sonido al completar

---

## 🔗 Relaciones y Dependencias

### Dependencias Actuales (Sprint 1)

```
databaseProvider (independiente)
    ↓ (usado por)
databaseInfoProvider

taskListProvider (independiente por ahora)

timerStateProvider (independiente por ahora)

databaseStatusProvider (independiente)
```

**Nota:** En Sprint 1, los providers están implementados pero no tienen dependencias entre sí porque aún no existen las entidades de dominio ni los repositorios.

### Dependencias Futuras (Sprint 2)

```
databaseProvider
    ↓
TaskRepository
    ↓
taskListProvider
    ↓
timerStateProvider (guardará tiempo al completar)
```

#### Flujo de Datos Completo (Sprint 2)

1. **UI** → `ref.read(taskListProvider.notifier).loadTasks()`
2. **taskListProvider** → `TaskRepository.getAllTasks()`
3. **TaskRepository** → `ref.read(databaseProvider).query('tasks')`
4. **databaseProvider** → SQLite Database
5. **SQLite** → retorna `List<Map>`
6. **TaskRepository** → mapea a `List<Task>`
7. **taskListProvider** → actualiza estado con `List<Task>`
8. **UI** → se reconstruye con nuevos datos

---

## 💡 Patrones de Uso

### Patrón 1: Leer Estado (watch)

**Uso:** Cuando el widget debe reconstruirse al cambiar el provider

```dart
class TaskListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskListProvider);
    
    if (taskState.isLoading) {
      return CircularProgressIndicator();
    }
    
    return ListView.builder(
      itemCount: taskState.tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(task: taskState.tasks[index]);
      },
    );
  }
}
```

### Patrón 2: Ejecutar Acción (read)

**Uso:** Cuando se necesita ejecutar una acción sin reconstruir

```dart
class CreateTaskButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        // ❌ NO usar watch aquí (causaría rebuild innecesario)
        // ✅ Usar read para ejecutar acción
        await ref.read(taskListProvider.notifier).createTask(
          title: 'Nueva tarea',
          description: 'Descripción',
        );
      },
      child: Text('Crear Tarea'),
    );
  }
}
```

### Patrón 3: AsyncValue con when/whenData

**Uso:** Para providers que retornan `Future` o `Stream`

```dart
class DatabaseInfoWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infoAsyncValue = ref.watch(databaseInfoProvider);
    
    return infoAsyncValue.when(
      data: (info) => Text('Tasks: ${info['tasks_count']}'),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
    
    // O usar whenData si solo interesa el caso de éxito
    return infoAsyncValue.whenData((info) {
      return Text('Version: ${info['database_version']}');
    }).value ?? Text('Cargando...');
  }
}
```

### Patrón 4: Escuchar Cambios (listen)

**Uso:** Para ejecutar side effects (mostrar snackbar, navegación, etc.)

```dart
class TaskScreenWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<TaskListState>(
      taskListProvider,
      (previous, next) {
        if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${next.error}')),
          );
        }
      },
    );
    
    // ... resto del widget
  }
}
```

### Patrón 5: Múltiples Providers

**Uso:** Combinar datos de varios providers

```dart
class DashboardWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskListProvider);
    final timerState = ref.watch(timerStateProvider);
    
    return Column(
      children: [
        Text('Tareas: ${taskState.taskCount}'),
        Text('Timer: ${timerState.remainingSeconds}s'),
      ],
    );
  }
}
```

---

## 📐 Guías de Implementación

### Cuándo Crear un Nuevo Provider

✅ **Crear nuevo provider cuando:**
- Hay un estado que necesita ser compartido entre múltiples widgets
- La lógica es compleja y merece estar separada de la UI
- Se necesita gestionar un recurso externo (BD, API, etc.)
- El estado necesita sobrevivir a la reconstrucción del widget

❌ **NO crear provider cuando:**
- El estado es local a un solo widget (usar `StatefulWidget` o `useState`)
- La lógica es trivial (getter/setter simple)
- No hay necesidad de reactividad

### Cómo Elegir el Tipo de Provider

| Escenario | Tipo Recomendado |
|-----------|------------------|
| Estado simple (bool, String, int) | `StateProvider` |
| Estado complejo con lógica | `StateNotifierProvider` |
| Datos asíncronos (Future) | `FutureProvider` |
| Stream de datos | `StreamProvider` |
| Valor calculado de otros providers | `Provider` |

### Convenciones de Nombres

```dart
// Provider de estado
final taskListProvider = StateNotifierProvider<TaskListNotifier, TaskListState>(...);

// Notifier asociado
class TaskListNotifier extends StateNotifier<TaskListState> { ... }

// Estado asociado
class TaskListState { ... }

// Provider de datos asíncronos
final databaseProvider = FutureProvider<Database>(...);

// Provider de estado simple
final databaseStatusProvider = StateProvider<DatabaseStatus>(...);
```

---

## 🚀 Roadmap Futuro

### Sprint 2: Integración con Dominio

- [ ] **Crear entidades de dominio**
  - `Task` entity
  - `TimeEntry` entity
  - `Category` entity

- [ ] **Implementar repositorios**
  - `TaskRepository` (consume `databaseProvider`)
  - `TimeEntryRepository` (consume `databaseProvider`)
  - `CategoryRepository` (consume `databaseProvider`)

- [ ] **Conectar providers con repositorios**
  - `taskListProvider` → `TaskRepository`
  - Crear `timeEntryProvider` → `TimeEntryRepository`
  - Crear `categoryProvider` → `CategoryRepository`

- [ ] **Integrar timer con tareas**
  - `timerStateProvider` guarda tiempo en `taskListProvider` al completar
  - Persistir estado del timer en BD

### Sprint 3: Providers Avanzados

- [ ] **Crear providers de configuración**
  - `settingsProvider` (tema, idioma, notificaciones)
  - `userPreferencesProvider`

- [ ] **Crear providers de UI**
  - `navigationProvider` (navegación declarativa)
  - `bottomNavProvider` (estado de navegación inferior)
  - `searchProvider` (estado de búsqueda)

- [ ] **Crear providers de estadísticas**
  - `statisticsProvider` (tiempo total, tareas completadas)
  - `chartDataProvider` (datos para gráficas)

### Sprint 4: Optimización

- [ ] **Caché y Performance**
  - Implementar caché en providers
  - `keepAlive: true` en providers críticos
  - Lazy loading de datos

- [ ] **Testing**
  - Tests unitarios de todos los notifiers
  - Tests de integración de flujos completos
  - Mock providers para testing de widgets

---

## 📚 Referencias

- **Riverpod Docs:** https://riverpod.dev/
- **Flutter State Management:** https://flutter.dev/docs/development/data-and-backend/state-mgmt
- **Clean Architecture:** `docs/ARCHITECTURE.md`
- **Task Breakdown:** `docs/TASK_BREAKDOWN.md`

---

## 🔄 Changelog

| Versión | Fecha | Cambios |
|---------|-------|---------|
| 1.0 | 2025-11-13 | Documentación inicial - Sprint 1 MVP completado |

---

**Mantenido por:** @JuanPMorales  
**Última revisión:** 2025-11-13

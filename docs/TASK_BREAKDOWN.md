# 🧩 TASK_BREAKDOWN.md — Task Timer App

> **Versión mejorada** | Documento de desglose exhaustivo de tareas  
> Proyecto: **Task Timer App** | Stack: Flutter 3.19 + Riverpod + SQLite  
> Estado inicial: Todas las tareas inician en **Pendiente**

---

## 📋 Tabla de Contenidos

1. [Configuración Inicial](#1-configuración-inicial)
2. [Arquitectura Base](#2-arquitectura-base)
3. [Módulo de Tareas](#3-módulo-de-tareas-task-management)
4. [Módulo de Temporizador](#4-módulo-de-temporizador-timer-core)
5. [Servicios Nativos](#5-servicios-nativos)
6. [Persistencia](#6-persistencia-sqlite--repositories)
7. [Presentación](#7-presentación-ui-providers-animaciones)
8. [Testing](#8-testing)
9. [CI/CD y Release](#9-cicd-y-release)
10. [Documentación y Mantenimiento](#10-documentación-y-mantenimiento)

---

## 🔧 Convenciones

### Estados de tarea
- ⏳ **Pendiente**: No iniciada
- 🔄 **En progreso**: En desarrollo activo
- ✅ **Completada**: Finalizada y validada
- ⚠️ **Bloqueada**: Requiere completar dependencias

### Formato de ID de tarea
`<módulo>.<submódulo>.<número>` (ej: `1.1.1`, `3.2.5`)

### Dependencias
Las tareas con dependencias se marcan con `⚠️ Depende de: [ID]`

---

## 1. Configuración Inicial

### 1.1 Entorno y Dependencias

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 1.1.1 | Instalar Flutter 3.19+ y Dart 3.3+ | ✅ Completada | - |
| 1.1.2 | Instalar y configurar IDE (Android Studio/VS Code + extensiones Flutter/Dart) | ✅ Completada | 1.1.1 |
| 1.1.3 | Configurar emuladores/simuladores (Android API 33+, iOS 16+) | ✅ Completada | 1.1.2 |
| 1.1.4 | Inicializar repositorio Git con estructura de ramas | ✅ Completada | - |
| 1.1.5 | Crear archivos base del proyecto: `.gitignore`, `README.md`, `LICENSE`, `CHANGELOG.md` | ✅ Completada | 1.1.4 |
| 1.1.6 | Establecer estrategia de branching: `main`, `develop`, `feature/*`, `release/*`, `hotfix/*` | ✅ Completada | 1.1.4 |
| 1.1.7 | Configurar CI/CD inicial con GitHub Actions (lint + test básico) | ✅ Completada | 1.1.4 |
| 1.1.8 | Definir y agregar dependencias iniciales en `pubspec.yaml` según MVP_TECNICO.md | ✅ Completada | 1.1.1 |
| 1.1.9 | Configurar análisis estático de código (`flutter_lints`, `analysis_options.yaml`) | ✅ Completada | 1.1.8 |
| 1.1.10 | Configurar internacionalización (`flutter_localizations`, `intl`) | ✅ Completada | 1.1.8 |

**Nota:** Validar instalación ejecutando `flutter doctor -v` sin errores críticos.

---

## 2. Arquitectura Base

### 2.1 Estructura de Carpetas `/lib`

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 2.1.1 | Crear `/core` con subcarpetas: `theme/`, `constants/`, `utils/`, `errors/` | ✅ Completada | 1.1.8 |
| 2.1.2 | Crear `/data` con subcarpetas: `models/`, `repositories/`, `database/`, `datasources/` | ✅ Completada | 1.1.8 |
| 2.1.3 | Crear `/domain` con subcarpetas: `entities/`, `usecases/`, `repositories/` (interfaces) | ✅ Completada | 1.1.8 |
| 2.1.4 | Crear `/presentation` con subcarpetas: `providers/`, `screens/`, `widgets/`, `viewmodels/` | ✅ Completada | 1.1.8 |
| 2.1.5 | Crear `/services` para integraciones nativas: `volume/`, `vibration/`, `background/` | ✅ Completada | 1.1.8 |
| 2.1.6 | Crear archivo `main.dart` como punto de entrada con estructura base | ✅ Completada | 2.1.1-2.1.5 |
| 2.1.7 | Documentar arquitectura en `docs/ARCHITECTURE.md` con diagramas | ✅ Completada | 2.1.6 |

**Principio:** Clean Architecture con separación clara de capas (domain → data → presentation).

### 2.2 Configuración de Riverpod

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 2.2.1 | Instalar `flutter_riverpod` y configurar `ProviderScope` en `main.dart` | ✅ Completada | 1.1.8, 2.1.6 |
| 2.2.2 | Crear provider global de tareas (`taskListProvider`) en `/presentation/providers/` | ✅ Completada | 2.2.1 |
| 2.2.3 | Crear provider de temporizador (`timerStateProvider`) | ✅ Completada | 2.2.1 |
| 2.2.4 | Crear provider de base de datos (`databaseProvider`) | ✅ Completada | 2.2.1 |
| 2.2.5 | Documentar jerarquía y relaciones de providers en `docs/PROVIDERS.md` | ✅ Completada | 2.2.2-2.2.4 |

**Nota:** Utilizar `StateNotifierProvider` para lógica compleja y `FutureProvider` para datos asíncronos.

### 2.3 Temas y Estilos

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 2.3.1 | Definir paleta de colores en `/core/theme/app_colors.dart` (primarios, secundarios, semánticos) | ✅ Completada | 2.1.1 |
| 2.3.2 | Definir tipografía en `/core/theme/app_text_styles.dart` (headings, body, labels) | ✅ Completada | 2.1.1 |
| 2.3.3 | Crear `AppTheme` con dark mode por defecto en `/core/theme/app_theme.dart` | ✅ Completada | 2.3.1, 2.3.2 |
| 2.3.4 | Definir espaciados y dimensiones en `/core/theme/app_dimensions.dart` | ✅ Completada | 2.1.1 |
| 2.3.5 | Integrar tema en `MaterialApp` dentro de `main.dart` | ✅ Completada | 2.3.3, 2.1.6 |

**Criterio de diseño:** Accesibilidad WCAG 2.1 AA (contraste, tamaños táctiles 44x44dp).

### 2.4 Constantes y Utilidades

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 2.4.1 | Crear `/core/constants/app_constants.dart` con valores globales (timeouts, límites) | ✅ Completada | 2.1.1 |
| 2.4.2 | Crear `/core/utils/time_formatter.dart` con funciones de formato (mm:ss, hh:mm:ss) | ✅ Completada | 2.1.1 |
| 2.4.3 | Crear `/core/utils/validators.dart` con validaciones (nombre, duración, etc.) | ✅ Completada | 2.1.1 |
| 2.4.4 | Crear `/core/errors/exceptions.dart` con excepciones personalizadas | ✅ Completada | 2.1.1 |
| 2.4.5 | Crear `/core/errors/failures.dart` para manejo de errores en domain layer | ✅ Completada | 2.1.1 |

---

## 3. Módulo de Tareas (Task Management)

### 3.1 Modelo y Base de Datos

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 3.1.1 | Definir entidad `Task` en `/domain/entities/task.dart` con propiedades inmutables | ✅ Completada | 2.1.3 |
| 3.1.2 | Crear modelo `TaskModel` en `/data/models/task_model.dart` con serialización JSON↔SQLite | ✅ Completada | 3.1.1 |
| 3.1.3 | Implementar interfaz `TaskRepository` en `/domain/repositories/task_repository.dart` | ✅ Completada | 3.1.1 |
| 3.1.4 | Implementar `TaskRepositoryImpl` en `/data/repositories/task_repository_impl.dart` | ✅ Completada | 3.1.2, 3.1.3 |
| 3.1.5 | Crear métodos CRUD en `TaskRepository`: `create`, `getAll`, `getById`, `update`, `delete` | ✅ Completada | 3.1.4 |
| 3.1.6 | Implementar validaciones de negocio (nombre no vacío, duración > 0) en repository | ✅ Completada | 3.1.5, 2.4.3 |
| 3.1.7 | Definir esquema de tabla `tasks` con campos: `id`, `name`, `duration`, `color`, `created_at`, `archived` | ⏳ Pendiente | 6.1.3 |
| 3.1.8 | Crear índices de performance en tabla `tasks` (por `created_at`, `archived`) | ⏳ Pendiente | 3.1.7 |

**Validación:** Escribir unit tests para cada método CRUD.

### 3.2 Casos de Uso (Use Cases)

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 3.2.1 | Crear `CreateTaskUseCase` en `/domain/usecases/create_task.dart` | ⏳ Pendiente | 3.1.3 |
| 3.2.2 | Crear `GetAllTasksUseCase` con filtro opcional (activas/archivadas) | ⏳ Pendiente | 3.1.3 |
| 3.2.3 | Crear `UpdateTaskUseCase` | ⏳ Pendiente | 3.1.3 |
| 3.2.4 | Crear `DeleteTaskUseCase` | ⏳ Pendiente | 3.1.3 |
| 3.2.5 | Crear `ArchiveTaskUseCase` para archivado lógico | ⏳ Pendiente | 3.1.3 |

### 3.3 UI y Flujo de Tareas

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 3.3.1 | Crear pantalla `TaskListScreen` en `/presentation/screens/task_list_screen.dart` | ⏳ Pendiente | 2.1.4 |
| 3.3.2 | Crear widget `TaskCard` con degradado azul y datos de tarea | ⏳ Pendiente | 2.3.3, 3.3.1 |
| 3.3.3 | Implementar `FloatingActionButton` "+" para nueva tarea | ⏳ Pendiente | 3.3.1 |
| 3.3.4 | Crear modal `NewTaskModal` con formulario de nombre y duración | ⏳ Pendiente | 3.3.3 |
| 3.3.5 | Conectar `TaskListScreen` con `taskListProvider` para reactiva | ⏳ Pendiente | 3.3.1, 2.2.2 |
| 3.3.6 | Implementar edición de tarea (tap largo en `TaskCard` → modal editar) | ⏳ Pendiente | 3.3.2, 3.3.4 |
| 3.3.7 | Implementar eliminación con diálogo de confirmación (swipe-to-delete) | ⏳ Pendiente | 3.3.2 |
| 3.3.8 | Validar inputs en `NewTaskModal` y mostrar errores inline | ⏳ Pendiente | 3.3.4, 2.4.3 |
| 3.3.9 | Implementar ordenamiento por fecha de creación (más recientes primero) | ⏳ Pendiente | 3.3.5 |
| 3.3.10 | Implementar selector de color personalizable en modal de tarea | ⏳ Pendiente | 3.3.4 |
| 3.3.11 | Implementar funcionalidad de archivado/desarchivado de tareas | ⏳ Pendiente | 3.3.2, 3.2.5 |
| 3.3.12 | Agregar animaciones de entrada/salida para `TaskCard` | ⏳ Pendiente | 3.3.2 |

**UX:** Validar que la interacción táctil sea fluida y responsive (<100ms).

---

## 4. Módulo de Temporizador (Timer Core)

### 4.1 Entidades y Modelos

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 4.1.1 | Definir entidad `TimerSession` en `/domain/entities/timer_session.dart` | ⏳ Pendiente | 2.1.3 |
| 4.1.2 | Crear modelo `TimerSessionModel` con serialización en `/data/models/` | ⏳ Pendiente | 4.1.1 |
| 4.1.3 | Definir enum `TimerState` (stopped, running, paused, completed) | ⏳ Pendiente | 4.1.1 |
| 4.1.4 | Definir esquema de tabla `timer_sessions` con campos: `id`, `task_id`, `start_time`, `pause_time`, `end_time`, `state` | ⏳ Pendiente | 6.1.3 |
| 4.1.5 | Crear índices en tabla `timer_sessions` (por `task_id`, `state`) | ⏳ Pendiente | 4.1.4 |

### 4.2 Repositorio y Casos de Uso

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 4.2.1 | Implementar interfaz `TimerRepository` en `/domain/repositories/` | ⏳ Pendiente | 4.1.1 |
| 4.2.2 | Implementar `TimerRepositoryImpl` con persistencia en SQLite | ⏳ Pendiente | 4.1.2, 4.2.1 |
| 4.2.3 | Crear `StartTimerUseCase` con lógica de timestamp inicial | ⏳ Pendiente | 4.2.1 |
| 4.2.4 | Crear `PauseTimerUseCase` con timestamp de pausa | ⏳ Pendiente | 4.2.1 |
| 4.2.5 | Crear `ResumeTimerUseCase` calculando tiempo transcurrido | ⏳ Pendiente | 4.2.1 |
| 4.2.6 | Crear `CompleteTimerUseCase` marcando sesión como completada | ⏳ Pendiente | 4.2.1 |
| 4.2.7 | Crear `RestoreTimerUseCase` para restaurar estado tras cierre de app | ⏳ Pendiente | 4.2.1 |
| 4.2.8 | Implementar lógica de cálculo de tiempo restante usando `DateTime.now()` | ⏳ Pendiente | 4.2.3-4.2.5 |

**Validación:** Probar restauración matando app con timer activo.

### 4.3 Lógica de Temporizador (Provider)

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 4.3.1 | Crear `TimerStateNotifier` extendiendo `StateNotifier<TimerState>` | ⏳ Pendiente | 2.2.3, 4.1.3 |
| 4.3.2 | Implementar método `start(Task task)` en notifier | ⏳ Pendiente | 4.3.1, 4.2.3 |
| 4.3.3 | Implementar método `pause()` persistiendo timestamp | ⏳ Pendiente | 4.3.1, 4.2.4 |
| 4.3.4 | Implementar método `resume()` recalculando tiempo | ⏳ Pendiente | 4.3.1, 4.2.5 |
| 4.3.5 | Implementar método `complete()` finalizando sesión | ⏳ Pendiente | 4.3.1, 4.2.6 |
| 4.3.6 | Implementar stream de actualización cada segundo (usando `Timer.periodic`) | ⏳ Pendiente | 4.3.1 |
| 4.3.7 | Manejar restauración automática al iniciar app si hay sesión activa | ⏳ Pendiente | 4.3.1, 4.2.7 |
| 4.3.8 | Implementar lógica de autocompletado cuando tiempo llega a 0 | ⏳ Pendiente | 4.3.6, 4.3.5 |

### 4.4 Interfaz de Temporizador

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 4.4.1 | Crear pantalla `TimerScreen` en `/presentation/screens/` | ⏳ Pendiente | 2.1.4 |
| 4.4.2 | Crear widget `CircularProgressIndicator` personalizado con animación | ⏳ Pendiente | 4.4.1 |
| 4.4.3 | Mostrar tiempo en formato mm:ss en el centro del círculo | ⏳ Pendiente | 4.4.2, 2.4.2 |
| 4.4.4 | Implementar control "Slide to Start" con `Slider` o gesture | ⏳ Pendiente | 4.4.1 |
| 4.4.5 | Mostrar nombre de tarea actual y siguiente tarea en cola | ⏳ Pendiente | 4.4.1, 3.2.2 |
| 4.4.6 | Implementar botones de pausa/reanudar con íconos claros | ⏳ Pendiente | 4.4.1 |
| 4.4.7 | Conectar `TimerScreen` con `timerStateProvider` | ⏳ Pendiente | 4.4.1, 4.3.1 |
| 4.4.8 | Implementar feedback visual al completar timer (animación + mensaje) | ⏳ Pendiente | 4.4.2, 4.3.8 |
| 4.4.9 | Integrar vibración al finalizar timer | ⏳ Pendiente | 4.3.8, 5.2.2 |
| 4.4.10 | Validar accesibilidad con TalkBack (Android) y VoiceOver (iOS) | ⏳ Pendiente | 4.4.1-4.4.9 |

**Performance:** El progreso debe actualizarse suavemente sin lag perceptible.

---

## 5. Servicios Nativos

### 5.1 Control de Volumen

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 5.1.1 | Investigar y seleccionar paquete para detección de botones de volumen (ej: `volume_controller`) | ⏳ Pendiente | 1.1.8 |
| 5.1.2 | Crear `VolumeButtonService` en `/services/volume/` | ⏳ Pendiente | 2.1.5, 5.1.1 |
| 5.1.3 | Implementar detección de Vol ↑ para Start/Resume | ⏳ Pendiente | 5.1.2 |
| 5.1.4 | Implementar detección de Vol ↓ para Pause | ⏳ Pendiente | 5.1.2 |
| 5.1.5 | Agregar fallback táctil en UI si detección falla | ⏳ Pendiente | 5.1.2, 4.4.6 |
| 5.1.6 | Manejar permisos necesarios (si aplica por plataforma) | ⏳ Pendiente | 5.1.2 |
| 5.1.7 | Validar comportamiento en diferentes dispositivos Android | ⏳ Pendiente | 5.1.3, 5.1.4 |

**Nota:** iOS limita acceso a botones de volumen; priorizar Android.

### 5.2 Vibración

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 5.2.1 | Instalar paquete `vibration` o equivalente | ⏳ Pendiente | 1.1.8 |
| 5.2.2 | Crear `VibrationService` en `/services/vibration/` | ⏳ Pendiente | 2.1.5, 5.2.1 |
| 5.2.3 | Implementar método `vibrate(duration, pattern)` | ⏳ Pendiente | 5.2.2 |
| 5.2.4 | Integrar vibración al completar timer | ⏳ Pendiente | 5.2.3, 4.3.8 |
| 5.2.5 | Validar soporte de vibración en dispositivo (evitar crash) | ⏳ Pendiente | 5.2.3 |
| 5.2.6 | Configurar permisos de vibración en `AndroidManifest.xml` | ⏳ Pendiente | 5.2.2 |

### 5.3 Background y Persistencia de Timer

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 5.3.1 | Investigar paquetes para background service: `flutter_background_service`, `workmanager` | ⏳ Pendiente | 1.1.8 |
| 5.3.2 | Crear `BackgroundTimerService` para Android | ⏳ Pendiente | 2.1.5, 5.3.1 |
| 5.3.3 | Configurar Foreground Service con notificación persistente (Android) | ⏳ Pendiente | 5.3.2 |
| 5.3.4 | Agregar permisos en `AndroidManifest.xml` (`FOREGROUND_SERVICE`, `WAKE_LOCK`) | ⏳ Pendiente | 5.3.3 |
| 5.3.5 | Implementar restauración de timer en iOS usando timestamps (sin background real) | ⏳ Pendiente | 4.2.7 |
| 5.3.6 | Manejar eventos de ciclo de vida: `AppLifecycleState` (pause, resume, detached) | ⏳ Pendiente | 5.3.2, 5.3.5 |
| 5.3.7 | Validar consumo de batería en background con profiler | ⏳ Pendiente | 5.3.3 |
| 5.3.8 | Probar comportamiento al matar app desde gestor de tareas | ⏳ Pendiente | 5.3.2, 5.3.5 |

**Crítico:** En iOS, usar timestamps y recalcular al reabrir app (no hay background real).

---

## 6. Persistencia (SQLite + Repositories)

### 6.1 Configuración de SQLite

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 6.1.1 | Instalar `sqflite` y `path_provider` | ⏳ Pendiente | 1.1.8 |
| 6.1.2 | Crear `DatabaseHelper` singleton en `/data/database/database_helper.dart` | ⏳ Pendiente | 2.1.2, 6.1.1 |
| 6.1.3 | Definir esquema inicial de tablas `tasks` y `timer_sessions` | ⏳ Pendiente | 6.1.2 |
| 6.1.4 | Implementar método `onCreate` para creación inicial de DB | ⏳ Pendiente | 6.1.3 |
| 6.1.5 | Implementar método `onUpgrade` para migraciones futuras | ⏳ Pendiente | 6.1.4 |
| 6.1.6 | Implementar control de versiones de base de datos | ⏳ Pendiente | 6.1.5 |
| 6.1.7 | Crear métodos genéricos: `insert`, `update`, `delete`, `query`, `rawQuery` | ⏳ Pendiente | 6.1.2 |
| 6.1.8 | Implementar manejo de errores y transacciones (rollback en falla) | ⏳ Pendiente | 6.1.7 |
| 6.1.9 | Documentar esquema y migraciones en `docs/DATABASE.md` | ⏳ Pendiente | 6.1.3-6.1.6 |

**Principio:** Usar transacciones para operaciones críticas (garantizar atomicidad).

### 6.2 Integración con Repositories

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 6.2.1 | Conectar `TaskRepositoryImpl` con `DatabaseHelper` | ⏳ Pendiente | 3.1.4, 6.1.2 |
| 6.2.2 | Conectar `TimerRepositoryImpl` con `DatabaseHelper` | ⏳ Pendiente | 4.2.2, 6.1.2 |
| 6.2.3 | Implementar streams reactivos en `TaskRepository` (usando `StreamController`) | ⏳ Pendiente | 6.2.1 |
| 6.2.4 | Implementar streams reactivos en `TimerRepository` | ⏳ Pendiente | 6.2.2 |
| 6.2.5 | Validar integridad referencial (FK entre `timer_sessions` y `tasks`) | ⏳ Pendiente | 6.1.3, 6.2.1, 6.2.2 |

---

## 7. Presentación (UI, Providers, Animaciones)

### 7.1 Providers y ViewModels

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 7.1.1 | Crear `TaskListViewModel` con lógica de pantalla de tareas | ⏳ Pendiente | 2.2.2, 3.2.2 |
| 7.1.2 | Crear `TimerViewModel` con lógica de pantalla de temporizador | ⏳ Pendiente | 2.2.3, 4.3.1 |
| 7.1.3 | Implementar `StateNotifier` para `TaskListViewModel` | ⏳ Pendiente | 7.1.1 |
| 7.1.4 | Implementar `StateNotifier` para `TimerViewModel` | ⏳ Pendiente | 7.1.2 |
| 7.1.5 | Integrar ViewModels con providers en widgets | ⏳ Pendiente | 7.1.3, 7.1.4 |

### 7.2 Widgets Reutilizables

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 7.2.1 | Crear `TaskCard` widget en `/presentation/widgets/` | ⏳ Pendiente | 3.3.2 |
| 7.2.2 | Crear `CircularTimerProgress` widget con animación | ⏳ Pendiente | 4.4.2 |
| 7.2.3 | Crear `CustomModal` base para formularios | ⏳ Pendiente | 3.3.4 |
| 7.2.4 | Crear `TimerControls` widget (botones play/pause/stop) | ⏳ Pendiente | 4.4.6 |
| 7.2.5 | Crear `EmptyState` widget para lista vacía | ⏳ Pendiente | 3.3.1 |
| 7.2.6 | Validar tamaños táctiles mínimos (44x44 dp) | ⏳ Pendiente | 7.2.1-7.2.5 |
| 7.2.7 | Implementar feedback háptico en botones críticos | ⏳ Pendiente | 7.2.4 |

### 7.3 Animaciones

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 7.3.1 | Implementar animación de progreso circular con `AnimationController` | ⏳ Pendiente | 7.2.2 |
| 7.3.2 | Implementar transiciones entre pantallas con `Hero` y `PageRoute` | ⏳ Pendiente | 3.3.1, 4.4.1 |
| 7.3.3 | Implementar degradados dinámicos en `TaskCard` según color | ⏳ Pendiente | 7.2.1 |
| 7.3.4 | Implementar animación de celebración al completar timer | ⏳ Pendiente | 4.4.8 |
| 7.3.5 | Validar performance de animaciones (60 FPS consistente) | ⏳ Pendiente | 7.3.1-7.3.4 |

**Herramienta:** Usar Flutter DevTools Performance para medir frame rate.

---

## 8. Testing

### 8.1 Unit Tests

| ID | Tarea | Estado | Dependencias | Cobertura Objetivo |
|---|---|---|---|---|
| 8.1.1 | Test de CRUD en `TaskRepository` (create, read, update, delete) | ⏳ Pendiente | 3.1.5 | 100% |
| 8.1.2 | Test de streams en `TaskRepository` | ⏳ Pendiente | 6.2.3 | 100% |
| 8.1.3 | Test de lógica de timer en `TimerStateNotifier` | ⏳ Pendiente | 4.3.1-4.3.8 | 100% |
| 8.1.4 | Test de validadores en `/core/utils/validators.dart` | ⏳ Pendiente | 2.4.3 | 100% |
| 8.1.5 | Test de serialización JSON en modelos (`TaskModel`, `TimerSessionModel`) | ⏳ Pendiente | 3.1.2, 4.1.2 | 100% |
| 8.1.6 | Test de casos de uso (UseCases) | ⏳ Pendiente | 3.2.1-3.2.5, 4.2.3-4.2.8 | 100% |
| 8.1.7 | Test de `VibrationService` (con mocks) | ⏳ Pendiente | 5.2.3 | 80% |
| 8.1.8 | Test de `VolumeButtonService` (con mocks) | ⏳ Pendiente | 5.1.3, 5.1.4 | 80% |

**Objetivo global:** Cobertura de unit tests ≥ 90%.

### 8.2 Integration Tests

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 8.2.1 | Test: Crear tarea → Aparece en lista | ⏳ Pendiente | 3.3.4, 3.3.5 |
| 8.2.2 | Test: Editar tarea → Cambios reflejados en UI y DB | ⏳ Pendiente | 3.3.6 |
| 8.2.3 | Test: Eliminar tarea → Desaparece de lista y DB | ⏳ Pendiente | 3.3.7 |
| 8.2.4 | Test: Iniciar timer → Estado persiste en DB | ⏳ Pendiente | 4.3.2, 4.2.3 |
| 8.2.5 | Test: Pausar timer → Timestamp guardado correctamente | ⏳ Pendiente | 4.3.3 |
| 8.2.6 | Test: Cerrar app con timer activo → Restaurar al reabrir | ⏳ Pendiente | 4.3.7, 5.3.8 |
| 8.2.7 | Test: Completar timer → Vibración + notificación | ⏳ Pendiente | 4.3.8, 5.2.4 |
| 8.2.8 | Test: Control por volumen funciona (mock) | ⏳ Pendiente | 5.1.3, 5.1.4 |
| 8.2.9 | Test: Archivar tarea → No aparece en lista activa | ⏳ Pendiente | 3.3.11 |

### 8.3 Widget Tests

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 8.3.1 | Test: `TaskCard` muestra datos correctamente | ⏳ Pendiente | 7.2.1 |
| 8.3.2 | Test: `TaskCard` responde a tap y long-press | ⏳ Pendiente | 3.3.6 |
| 8.3.3 | Test: `CustomModal` valida inputs vacíos | ⏳ Pendiente | 7.2.3, 2.4.3 |
| 8.3.4 | Test: `CustomModal` muestra errores de validación | ⏳ Pendiente | 3.3.8 |
| 8.3.5 | Test: `TimerScreen` muestra tiempo en formato correcto | ⏳ Pendiente | 4.4.3 |
| 8.3.6 | Test: `CircularTimerProgress` actualiza progreso proporcionalmente | ⏳ Pendiente | 7.2.2 |
| 8.3.7 | Test: `EmptyState` se muestra cuando lista está vacía | ⏳ Pendiente | 7.2.5 |

### 8.4 Performance Tests

| ID | Tarea | Estado | Dependencias | Métrica Objetivo |
|---|---|---|---|---|
| 8.4.1 | Medir tiempo de carga inicial de app | ⏳ Pendiente | 2.1.6 | < 2s |
| 8.4.2 | Medir consumo de CPU con timer activo | ⏳ Pendiente | 4.3.6 | < 10% |
| 8.4.3 | Medir consumo de RAM con 50 tareas | ⏳ Pendiente | 3.3.5 | < 150 MB |
| 8.4.4 | Medir consumo de batería en background (8h) | ⏳ Pendiente | 5.3.7 | < 5% |
| 8.4.5 | Medir frame rate en scroll de lista | ⏳ Pendiente | 3.3.1 | ≥ 60 FPS |
| 8.4.6 | Medir tiempo de escritura en DB (100 tareas) | ⏳ Pendiente | 6.1.7 | < 100ms |
| 8.4.7 | Medir tamaño de APK release | ⏳ Pendiente | 9.2.3 | < 20 MB |

**Herramientas:** Flutter DevTools, Android Profiler, Xcode Instruments.

### 8.5 Automatización de Testing

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 8.5.1 | Configurar ejecución automática de tests en GitHub Actions | ⏳ Pendiente | 1.1.7, 8.1.1 |
| 8.5.2 | Configurar generación de reporte de cobertura con `coverage` | ⏳ Pendiente | 8.1.1-8.1.8 |
| 8.5.3 | Configurar badge de cobertura en README | ⏳ Pendiente | 8.5.2 |
| 8.5.4 | Configurar tests obligatorios antes de merge a `main` | ⏳ Pendiente | 8.5.1 |

---

## 9. CI/CD y Release

### 9.1 Pipeline de CI

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 9.1.1 | Crear workflow `.github/workflows/ci.yml` | ⏳ Pendiente | 1.1.7 |
| 9.1.2 | Agregar step de análisis estático (`flutter analyze`) | ⏳ Pendiente | 9.1.1, 1.1.9 |
| 9.1.3 | Agregar step de formateo (`flutter format --dry-run`) | ⏳ Pendiente | 9.1.1 |
| 9.1.4 | Agregar step de unit tests con cobertura | ⏳ Pendiente | 9.1.1, 8.5.2 |
| 9.1.5 | Agregar step de widget e integration tests | ⏳ Pendiente | 9.1.1, 8.3.1 |
| 9.1.6 | Configurar ejecución en push a `dev` y PRs a `main` | ⏳ Pendiente | 9.1.1 |
| 9.1.7 | Configurar notificaciones de fallos (Slack/email/GitHub) | ⏳ Pendiente | 9.1.1 |

### 9.2 Pipeline de CD

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 9.2.1 | Crear workflow `.github/workflows/cd.yml` para releases | ⏳ Pendiente | 1.1.7 |
| 9.2.2 | Configurar build de APK de QA en merge a `dev` | ⏳ Pendiente | 9.2.1 |
| 9.2.3 | Configurar build de APK release firmado | ⏳ Pendiente | 9.2.1, 9.3.1 |
| 9.2.4 | Configurar build de IPA release firmado | ⏳ Pendiente | 9.2.1, 9.3.2 |
| 9.2.5 | Implementar versionado automático (semver) basado en tags | ⏳ Pendiente | 9.2.1 |
| 9.2.6 | Configurar subida automática a GitHub Releases | ⏳ Pendiente | 9.2.3, 9.2.4 |

### 9.3 Firma y Configuración de Stores

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 9.3.1 | Generar keystore de Android y configurar en `build.gradle` | ⏳ Pendiente | - |
| 9.3.2 | Configurar certificado de iOS en Xcode | ⏳ Pendiente | - |
| 9.3.3 | Guardar secretos de firma en GitHub Secrets | ⏳ Pendiente | 9.3.1, 9.3.2 |
| 9.3.4 | Configurar ProGuard/R8 para ofuscación (Android) | ⏳ Pendiente | 9.3.1 |
| 9.3.5 | Validar builds firmados en dispositivos reales | ⏳ Pendiente | 9.2.3, 9.2.4 |

### 9.4 Publicación en Stores

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 9.4.1 | Crear cuenta de desarrollador en Google Play Console | ⏳ Pendiente | - |
| 9.4.2 | Crear cuenta de desarrollador en Apple Developer Program | ⏳ Pendiente | - |
| 9.4.3 | Preparar assets: ícono, screenshots, banner, video (opcional) | ⏳ Pendiente | - |
| 9.4.4 | Redactar descripción corta y larga para stores | ⏳ Pendiente | - |
| 9.4.5 | Completar metadata en Google Play: categoría, etiquetas, edad | ⏳ Pendiente | 9.4.1, 9.4.4 |
| 9.4.6 | Completar metadata en App Store Connect | ⏳ Pendiente | 9.4.2, 9.4.4 |
| 9.4.7 | Subir APK a Google Play (track beta cerrada) | ⏳ Pendiente | 9.2.3, 9.4.5 |
| 9.4.8 | Subir IPA a TestFlight | ⏳ Pendiente | 9.2.4, 9.4.6 |
| 9.4.9 | Realizar QA en beta con usuarios reales | ⏳ Pendiente | 9.4.7, 9.4.8 |
| 9.4.10 | Promocionar a producción en Google Play | ⏳ Pendiente | 9.4.9 |
| 9.4.11 | Promocionar a producción en App Store | ⏳ Pendiente | 9.4.9 |
| 9.4.12 | Validar publicación y accesibilidad en stores | ⏳ Pendiente | 9.4.10, 9.4.11 |

---

## 10. Documentación y Mantenimiento

### 10.1 Documentación Técnica

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 10.1.1 | Documentar arquitectura en `docs/ARCHITECTURE.md` con diagramas | ⏳ Pendiente | 2.1.7 |
| 10.1.2 | Documentar casos de uso y flujos principales en `docs/USE_CASES.md` | ⏳ Pendiente | 3.2.1-3.2.5, 4.2.3-4.2.8 |
| 10.1.3 | Documentar servicios nativos en `docs/NATIVE_SERVICES.md` | ⏳ Pendiente | 5.1.2, 5.2.2, 5.3.2 |
| 10.1.4 | Documentar esquema de DB y migraciones en `docs/DATABASE.md` | ⏳ Pendiente | 6.1.9 |
| 10.1.5 | Documentar jerarquía de providers en `docs/PROVIDERS.md` | ⏳ Pendiente | 2.2.5 |
| 10.1.6 | Documentar estrategia de testing en `docs/TESTING.md` | ⏳ Pendiente | 8.1.1-8.4.7 |
| 10.1.7 | Documentar proceso de release en `docs/RELEASE.md` | ⏳ Pendiente | 9.1.1-9.4.12 |
| 10.1.8 | Mantener `CHANGELOG.md` con cada versión | ⏳ Pendiente | 9.2.5 |

### 10.2 Documentación de Usuario

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 10.2.1 | Crear `README.md` con descripción del proyecto y quick start | ⏳ Pendiente | 1.1.5 |
| 10.2.2 | Agregar guía de instalación para desarrolladores | ⏳ Pendiente | 10.2.1 |
| 10.2.3 | Agregar guía de contribución (`CONTRIBUTING.md`) | ⏳ Pendiente | 1.1.5 |
| 10.2.4 | Crear guía de usuario final en `docs/USER_GUIDE.md` | ⏳ Pendiente | 4.4.1-4.4.10, 3.3.1-3.3.12 |

### 10.3 Reglas para IA

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 10.3.1 | Crear `IA_RULES.md` con directrices de generación de código | ⏳ Pendiente | 1.1.5 |
| 10.3.2 | Documentar convenciones de código (naming, estructura, comentarios) | ⏳ Pendiente | 10.3.1 |
| 10.3.3 | Documentar patrones arquitectónicos obligatorios | ⏳ Pendiente | 10.3.1, 10.1.1 |
| 10.3.4 | Documentar reglas de testing (cobertura, tipos de test) | ⏳ Pendiente | 10.3.1, 10.1.6 |
| 10.3.5 | Documentar checklist pre-commit y pre-PR | ⏳ Pendiente | 10.3.1 |

### 10.4 Mantenimiento Continuo

| ID | Tarea | Estado | Dependencias |
|---|---|---|---|
| 10.4.1 | Configurar GitHub Issues con templates (bug, feature, question) | ⏳ Pendiente | 1.1.4 |
| 10.4.2 | Configurar GitHub Projects para roadmap | ⏳ Pendiente | 1.1.4 |
| 10.4.3 | Establecer proceso de triaje semanal de issues | ⏳ Pendiente | 10.4.1 |
| 10.4.4 | Configurar Dependabot para actualizaciones automáticas | ⏳ Pendiente | 1.1.4 |
| 10.4.5 | Revisar y actualizar dependencias mensualmente | ⏳ Pendiente | 10.4.4 |
| 10.4.6 | Revisar cobertura de tests trimestralmente | ⏳ Pendiente | 8.5.2 |
| 10.4.7 | Refactorizar código según deuda técnica acumulada | ⏳ Pendiente | 10.4.3 |
| 10.4.8 | Planificar roadmap de nuevas features bimensualmente | ⏳ Pendiente | 10.4.2 |

---

## 📊 Resumen de Métricas

| Categoría | Total Tareas | Objetivo Cobertura/Performance |
|---|---|---|
| **Configuración Inicial** | 10 | - |
| **Arquitectura Base** | 21 | - |
| **Módulo de Tareas** | 24 | - |
| **Módulo de Temporizador** | 26 | - |
| **Servicios Nativos** | 20 | - |
| **Persistencia** | 13 | - |
| **Presentación** | 17 | - |
| **Testing** | 37 | ≥ 90% cobertura unit tests |
| **CI/CD y Release** | 28 | APK < 20 MB |
| **Documentación** | 21 | - |
| **TOTAL** | **217 tareas** | - |

---

## 🚀 Flujo de Trabajo Recomendado

### Para desarrollo incremental:

1. **Fase 1 - Fundamentos** (Tareas 1.x - 2.x): ~2 semanas
2. **Fase 2 - Core Features** (Tareas 3.x - 4.x): ~3 semanas
3. **Fase 3 - Integraciones Nativas** (Tareas 5.x - 6.x): ~2 semanas
4. **Fase 4 - Polish & Testing** (Tareas 7.x - 8.x): ~2 semanas
5. **Fase 5 - Release** (Tareas 9.x - 10.x): ~1 semana

**Total estimado:** ~10 semanas (ajustable según equipo)

---

## 🔗 Referencias Cruzadas

- **PRD.md**: Requisitos de producto
- **MVP_TECNICO.md**: Stack técnico y dependencias
- **ARCHITECTURE.md**: Diagramas y decisiones arquitectónicas
- **IA_RULES.md**: Convenciones para generación de código por IA

---

## 📝 Notas Finales

1. **Atomicidad**: Cada tarea debe ser completable en < 4 horas de trabajo continuo.
2. **Dependencias**: Marcar como bloqueada (⚠️) si depende de tarea incompleta.
3. **Validación**: Toda tarea de implementación requiere test correspondiente.
4. **Documentación**: Actualizar docs relevantes al completar cada módulo.
5. **Code Review**: Todo código debe pasar por revisión antes de merge a `main`.

---

_Generado automáticamente según PRD, MVP_TECNICO, ARCHITECTURE e IA_RULES._  
_Última actualización: 2025-11-11_
# 🧩 MVP Técnico – Task Timer App

**Fecha:** 2025-11-11  
**Autor:** JuanP  
**Objetivo:** Desarrollar la primera versión funcional de Task Timer con las funcionalidades mínimas necesarias para validar el producto con usuarios reales.

---

## 1. Objetivo del MVP

Desarrollar la primera versión funcional de **Task Timer**, con las funcionalidades mínimas necesarias para validar el producto con usuarios reales:  
- Crear, editar y eliminar tareas
- Iniciar y pausar un cronómetro
- Mantener el progreso aunque la app se cierre
- Controles físicos (botones de volumen)
- Feedback háptico al completar

---

## 2. Alcance Técnico del MVP

### 2.1 Módulos Incluidos

| Módulo | Descripción | Prioridad | Sprint |
|---------|--------------|-----------|--------|
| **Task List** | Visualización, creación, edición y eliminación de tareas con SQLite. | Alta | 1-2 |
| **Timer Core** | Cronómetro de cuenta regresiva, control táctil y por botones físicos (Vol↑/↓). | Alta | 3-4 |
| **Persistencia local** | Almacenamiento y restauración de estado de tareas y timers. | Alta | 2, 5 |
| **Animaciones básicas** | Progreso circular, transiciones suaves, degradados dinámicos. | Media | 3 |
| **Vibración y notificación** | Aviso físico/auditivo cuando termina un timer. | Media | 4 |
| **Modo background** | Continuación del timer si se minimiza la app. | Alta | 5 |
| **Dark mode** | Tema azul oscuro por defecto. | Alta | 1 |

### 2.2 Fuera del Alcance del MVP

❌ **No incluido en esta versión:**
- Widgets de pantalla de inicio
- Estadísticas y reportes
- Sincronización en la nube
- Modo claro
- Integración con calendario
- Soporte para wearables
- Múltiples timers simultáneos
- Exportación de datos
- Notificaciones programadas
- Modo Pomodoro automático

---

## 3. Arquitectura Técnica

### 3.1 Patrón Arquitectónico

**Clean Architecture + MVVM con Riverpod**

```
📁 /lib
├── 📂 core/
│   ├── theme/
│   │   ├── colors.dart              # Paleta de colores
│   │   └── text_styles.dart         # Estilos de texto
│   ├── constants/
│   │   └── app_constants.dart       # Constantes globales
│   └── utils/
│       ├── time_formatter.dart      # Utilidades de formato
│       └── validators.dart          # Validaciones de input
│
├── 📂 data/
│   ├── models/
│   │   ├── task_model.dart          # Modelo de datos (JSON ↔ SQLite)
│   │   └── timer_session_model.dart # Modelo de sesión
│   ├── repositories/
│   │   ├── task_repository.dart     # Interfaz abstracta
│   │   └── task_repository_impl.dart # Implementación con SQLite
│   └── database/
│       ├── database_helper.dart     # Singleton de SQLite
│       └── migrations.dart          # Control de versiones de DB
│
├── 📂 domain/
│   ├── entities/
│   │   ├── task.dart                # Entidad pura (sin dependencias)
│   │   └── timer_session.dart       # Entidad de sesión
│   └── usecases/
│       ├── create_task.dart         # Caso de uso: crear tarea
│       ├── update_task.dart         # Caso de uso: editar tarea
│       ├── delete_task.dart         # Caso de uso: eliminar tarea
│       ├── get_tasks.dart           # Caso de uso: obtener tareas
│       ├── start_timer.dart         # Caso de uso: iniciar timer
│       └── pause_timer.dart         # Caso de uso: pausar timer
│
├── 📂 presentation/
│   ├── providers/
│   │   ├── task_provider.dart       # Estado de lista de tareas
│   │   └── timer_provider.dart      # Estado del cronómetro
│   ├── screens/
│   │   ├── task_list_screen.dart    # Pantalla principal
│   │   └── timer_screen.dart        # Pantalla de cronómetro
│   └── widgets/
│       ├── task_card.dart           # Tarjeta de tarea
│       ├── circular_progress.dart   # Progreso circular animado
│       └── new_task_modal.dart      # Modal de creación
│
├── 📂 services/
│   ├── volume_button_service.dart   # Control de botones físicos
│   ├── vibration_service.dart       # Feedback háptico
│   └── background_service.dart      # Servicio en segundo plano
│
└── main.dart                         # Punto de entrada
```

### 3.2 Flujo de Datos

```
┌─────────────┐
│     UI      │ (TaskListScreen, TimerScreen)
└──────┬──────┘
       │
       ↓
┌─────────────┐
│  Provider   │ (Riverpod - TaskProvider, TimerProvider)
└──────┬──────┘
       │
       ↓
┌─────────────┐
│  Use Case   │ (CreateTask, StartTimer, etc.)
└──────┬──────┘
       │
       ↓
┌─────────────┐
│ Repository  │ (TaskRepositoryImpl)
└──────┬──────┘
       │
       ↓
┌─────────────┐
│   SQLite    │ (DatabaseHelper)
└─────────────┘
```

**Principios aplicados:**
- **Dependency Inversion:** Capas superiores no dependen de implementaciones concretas
- **Single Responsibility:** Cada clase tiene una única razón de cambio
- **Separation of Concerns:** UI, lógica de negocio y persistencia separadas

---

## 4. Stack Tecnológico

### 4.1 Tecnologías Core

| Componente | Tecnología | Versión | Justificación |
|-------------|-------------|---------|----------------|
| **Framework** | Flutter | ≥3.19.0 | Multiplataforma, alto rendimiento |
| **Lenguaje** | Dart | ≥3.3.0 | Tipado fuerte, null safety |
| **Gestor de estado** | Riverpod | ^2.4.10 | Reactivo, testable, sin BuildContext |
| **Base de datos local** | sqflite | ^2.3.2 | SQLite nativo, soporte async |
| **Rutas de archivos** | path_provider | ^2.1.2 | Acceso a directorios del sistema |
| **Control de volumen** | volume_controller | ^2.0.7 | Interceptar botones físicos |
| **Vibración** | vibration | ^1.8.4 | Feedback háptico multiplataforma |
| **Formateo de tiempo** | intl | ^0.19.0 | Internacionalización y formato |
| **IDs únicos** | uuid | ^4.3.3 | Generación de identificadores |

### 4.2 Herramientas de Desarrollo

| Herramienta | Propósito |
|-------------|-----------|
| **flutter_test** | Tests unitarios y de widgets |
| **mockito** | Mocking para tests |
| **build_runner** | Generación de código |
| **flutter_lints** | Análisis estático de código |
| **Android Studio / VS Code** | IDEs recomendados |

### 4.3 Análisis de Dependencias

| Paquete | Versión | Android | iOS | Riesgo | Notas |
|---------|---------|---------|-----|--------|-------|
| sqflite | 2.3.2 | API 16+ | iOS 12+ | ✅ Bajo | Estable, ampliamente usado |
| path_provider | 2.1.2 | API 16+ | iOS 11+ | ✅ Bajo | Mantenido por Flutter team |
| volume_controller | 2.0.7 | API 21+ | iOS 13+ | ⚠️ Medio | Varía por fabricante (Samsung, Xiaomi) |
| vibration | 1.8.4 | API 11+ | iOS 10+ | ✅ Bajo | Funciona en >95% dispositivos |
| intl | 0.19.0 | Todas | Todas | ✅ Bajo | Parte del SDK de Dart |
| uuid | 4.3.3 | Todas | Todas | ✅ Bajo | Sin dependencias nativas |

**Nota sobre `volume_controller`:** Algunos fabricantes (OnePlus, Xiaomi con MIUI) restringen la interceptación de botones. **Mitigación:** Siempre ofrecer controles táctiles como alternativa.

---

## 5. Modelo de Datos

### 5.1 Esquema de Base de Datos

**Versión:** 1  
**Engine:** SQLite 3

#### Tabla: `tasks`

```sql
CREATE TABLE tasks (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 50),
    duration_seconds INTEGER NOT NULL CHECK(duration_seconds BETWEEN 60 AND 86400),
    color TEXT NOT NULL DEFAULT '#3BCDFE',
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    is_archived INTEGER NOT NULL DEFAULT 0
);

-- Índices para mejorar performance
CREATE INDEX idx_tasks_created_at ON tasks(created_at DESC);
CREATE INDEX idx_tasks_archived ON tasks(is_archived);
```

**Campos:**
- `id`: UUID generado con el paquete `uuid`
- `name`: Nombre de la tarea (1-50 caracteres)
- `duration_seconds`: Duración en segundos (60 = 1 min, 86400 = 24 horas)
- `color`: Código hexadecimal del color (ej: `#3BCDFE`)
- `created_at`: Timestamp ISO 8601 (ej: `2025-11-11T15:40:01.000Z`)
- `updated_at`: Timestamp de última modificación
- `is_archived`: Booleano como INTEGER (0 = activa, 1 = archivada)

#### Tabla: `timer_sessions`

```sql
CREATE TABLE timer_sessions (
    id TEXT PRIMARY KEY,
    task_id TEXT NOT NULL,
    start_timestamp TEXT NOT NULL,
    end_timestamp TEXT,
    elapsed_seconds INTEGER NOT NULL DEFAULT 0,
    status TEXT NOT NULL CHECK(status IN ('active', 'paused', 'completed')),
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

-- Índices
CREATE INDEX idx_sessions_task_id ON timer_sessions(task_id);
CREATE INDEX idx_sessions_status ON timer_sessions(status);
```

**Campos:**
- `id`: UUID de la sesión
- `task_id`: Referencia a la tarea
- `start_timestamp`: Momento en que se inició el timer
- `end_timestamp`: Momento en que terminó (NULL si activa)
- `elapsed_seconds`: Segundos transcurridos
- `status`: `active` | `paused` | `completed`

### 5.2 Estrategia de Migraciones

```dart
// lib/data/database/database_helper.dart

class DatabaseHelper {
  static const int _currentVersion = 1;
  
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        duration_seconds INTEGER NOT NULL,
        color TEXT NOT NULL DEFAULT '#3BCDFE',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        is_archived INTEGER NOT NULL DEFAULT 0
      )
    ''');
    
    await db.execute('''
      CREATE TABLE timer_sessions (
        id TEXT PRIMARY KEY,
        task_id TEXT NOT NULL,
        start_timestamp TEXT NOT NULL,
        end_timestamp TEXT,
        elapsed_seconds INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL,
        FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
      )
    ''');
    
    // Índices
    await db.execute('CREATE INDEX idx_tasks_created_at ON tasks(created_at DESC)');
    await db.execute('CREATE INDEX idx_sessions_task_id ON timer_sessions(task_id)');
  }
  
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Ejemplo de migración futura (v1 → v2)
    if (oldVersion < 2) {
      // await db.execute('ALTER TABLE tasks ADD COLUMN tags TEXT');
    }
  }
}
```

**Plan de Rollback:**
- Antes de cada migración, crear backup de la DB en `app_documents/backups/`
- Si falla la migración, restaurar desde backup
- Logging de errores para debugging

---

## 6. Gestión de Estados Críticos

### 6.1 Background/Foreground

#### Decisión Técnica: **Timestamp-Based Calculation**

**Problema:** iOS y Android matan procesos en background de forma impredecible.

**Solución:** No confiar en timers reales en background.

```dart
// Estrategia:
// 1. Al iniciar timer, guardar timestamp de inicio en SQLite
// 2. Al reabrir app, calcular tiempo transcurrido = now - start_timestamp
// 3. Si elapsed >= duration, marcar como completado

class TimerProvider extends StateNotifier<TimerState> {
  void startTimer(Task task) {
    final startTime = DateTime.now();
    
    // Guardar en DB
    _repository.saveTimerSession(
      TimerSession(
        id: uuid.v4(),
        taskId: task.id,
        startTimestamp: startTime,
        status: 'active',
      ),
    );
    
    // Iniciar countdown local (UI)
    _startLocalCountdown(task.durationSeconds);
  }
  
  Future<void> restoreTimerOnAppResume() async {
    final activeSession = await _repository.getActiveSession();
    if (activeSession == null) return;
    
    final elapsed = DateTime.now().difference(activeSession.startTimestamp).inSeconds;
    final remaining = activeSession.task.durationSeconds - elapsed;
    
    if (remaining <= 0) {
      // Timer ya terminó
      _completeTimer(activeSession);
    } else {
      // Continuar desde donde quedó
      _startLocalCountdown(remaining);
    }
  }
}
```

#### Foreground Service (Android)

```dart
// Para notificación persistente en Android
// lib/services/background_service.dart

class BackgroundService {
  static Future<void> startForegroundService(Task task) async {
    if (Platform.isAndroid) {
      // Mostrar notificación permanente
      await FlutterForegroundTask.startService(
        notificationTitle: 'Timer activo',
        notificationText: '${task.name} en progreso',
      );
    }
  }
}
```

**Limitaciones en iOS:**
- No hay servicio persistente en background
- Solo Background Tasks (máximo 30 segundos)
- **Solución:** Calcular con timestamps (funciona sin proceso activo)

### 6.2 Manejo de Interrupciones

| Evento | Detección | Comportamiento |
|--------|-----------|----------------|
| **App minimizada** | `AppLifecycleState.paused` | Guardar timestamp, continuar cálculo |
| **App cerrada forzosamente** | N/A (no detectable) | Al reabrir, restaurar desde SQLite |
| **Llamada entrante** | `AppLifecycleState.inactive` | Pausar timer automáticamente |
| **Batería <5%** | `battery_plus` package | Pausar + mostrar alerta |
| **Reinicio del dispositivo** | N/A | Estado se pierde, mostrar último conocido |
| **Cambio de hora del sistema** | N/A | Usar `DateTime.now()` - inmune a cambios |

### 6.3 Edge Cases

```dart
// lib/core/utils/validators.dart

class TaskValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre no puede estar vacío';
    }
    if (value.length > 50) {
      return 'Máximo 50 caracteres';
    }
    return null;
  }
  
  static String? validateDuration(int? seconds) {
    if (seconds == null) {
      return 'Duración requerida';
    }
    if (seconds < 60) {
      return 'Mínimo 1 minuto';
    }
    if (seconds > 86400) {
      return 'Máximo 24 horas';
    }
    return null;
  }
}
```

**Casos límite cubiertos:**
- ✅ Nombres vacíos o solo espacios
- ✅ Duraciones fuera de rango
- ✅ Colores inválidos (default a `#3BCDFE`)
- ✅ DB corrupta (reinicializar + log error)
- ✅ Permisos de volumen denegados (ofrecer controles táctiles)
- ✅ Usuario cambia hora del sistema (usar elapsed time)

---

## 7. Plan de Testing

### 7.1 Cobertura Objetivo

**Meta global:** ≥70% de cobertura

| Tipo de Test | Cobertura | Responsable |
|--------------|-----------|-------------|
| **Unit Tests** | 40% del total | Cada desarrollador |
| **Integration Tests** | 20% del total | Tech Lead |
| **Widget Tests** | 10% del total | UI Developer |
| **Manual/Device Tests** | N/A | QA Team |

### 7.2 Unit Tests (Sprint 2-6)

```dart
// test/data/repositories/task_repository_test.dart

void main() {
  late TaskRepositoryImpl repository;
  late MockDatabaseHelper mockDb;
  
  setUp(() {
    mockDb = MockDatabaseHelper();
    repository = TaskRepositoryImpl(mockDb);
  });
  
  group('TaskRepository -', () {
    test('createTask guarda correctamente en DB', () async {
      // Arrange
      final task = Task(
        id: '123',
        name: 'Test Task',
        durationSeconds: 1800,
        color: '#3BCDFE',
      );
      
      when(mockDb.insert('tasks', any)).thenAnswer((_) async => 1);
      
      // Act
      await repository.createTask(task);
      
      // Assert
      verify(mockDb.insert('tasks', any)).called(1);
    });
    
    test('createTask con nombre vacío lanza excepción', () async {
      // Arrange
      final task = Task(id: '123', name: '', durationSeconds: 1800);
      
      // Act & Assert
      expect(
        () => repository.createTask(task),
        throwsA(isA<ValidationException>()),
      );
    });
    
    test('getTasks retorna lista ordenada por created_at', () async {
      // Arrange
      when(mockDb.query('tasks', orderBy: 'created_at DESC'))
          .thenAnswer((_) async => [
        {'id': '1', 'name': 'Task 1', 'created_at': '2025-11-11T10:00:00Z'},
        {'id': '2', 'name': 'Task 2', 'created_at': '2025-11-11T09:00:00Z'},
      ]);
      
      // Act
      final tasks = await repository.getTasks();
      
      // Assert
      expect(tasks.length, 2);
      expect(tasks.first.id, '1');
    });
  });
}
```

**Tests unitarios obligatorios:**
- [ ] `TaskRepository.createTask()` con datos válidos
- [ ] `TaskRepository.createTask()` con datos inválidos (nombre vacío, duración negativa)
- [ ] `TaskRepository.getTasks()` retorna lista ordenada
- [ ] `TaskRepository.updateTask()` modifica campos correctos
- [ ] `TaskRepository.deleteTask()` elimina de DB
- [ ] `TimerProvider.startCountdown()` decrementa cada segundo
- [ ] `TimerProvider.pauseTimer()` detiene el conteo
- [ ] `TimerProvider.restoreTimer()` calcula tiempo correcto
- [ ] `TaskValidators.validateName()` con casos límite
- [ ] `TaskValidators.validateDuration()` con valores fuera de rango

### 7.3 Integration Tests (Sprint 5-6)

```dart
// integration_test/app_test.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('Flujo completo: crear tarea → iniciar timer → pausar', (tester) async {
    await tester.pumpWidget(const MyApp());
    
    // 1. Crear tarea
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    
    await tester.enterText(find.byType(TextField), 'Test Task');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    
    // Verificar que aparece en lista
    expect(find.text('Test Task'), findsOneWidget);
    
    // 2. Iniciar timer
    await tester.tap(find.text('Test Task'));
    await tester.pumpAndSettle();
    
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pumpAndSettle();
    
    // Esperar 3 segundos
    await tester.pump(const Duration(seconds: 3));
    
    // Verificar que el tiempo decrementó
    // (lógica específica depende de tu UI)
    
    // 3. Pausar timer
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pumpAndSettle();
    
    // Verificar que se guardó en DB
    final db = await DatabaseHelper.instance.database;
    final sessions = await db.query('timer_sessions', where: 'status = ?', whereArgs: ['paused']);
    expect(sessions.length, 1);
  });
  
  testWidgets('Timer continúa después de cerrar y reabrir app', (tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Iniciar timer
    await tester.tap(find.text('Test Task'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.play_arrow));
    
    // Simular cerrar app (guardar estado)
    // ...
    
    // Reiniciar app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    
    // Verificar que el timer se restauró
    expect(find.byType(TimerScreen), findsOneWidget);
  });
}
```

**Tests de integración obligatorios:**
- [ ] Crear tarea → Aparece en lista
- [ ] Editar tarea → Cambios se reflejan
- [ ] Eliminar tarea → Desaparece de lista
- [ ] Iniciar timer → Se guarda en DB
- [ ] Pausar timer → Estado se persiste
- [ ] Cerrar app con timer activo → Al reabrir se restaura
- [ ] Completar timer → Se dispara vibración
- [ ] Control por volumen funciona (si dispositivo lo permite)

### 7.4 Widget Tests (Sprint 3-4)

```dart
// test/presentation/widgets/task_card_test.dart

void main() {
  testWidgets('TaskCard muestra datos correctamente', (tester) async {
    final task = Task(
      id: '123',
      name: 'Test Task',
      durationSeconds: 1800, // 30 minutos
      color: '#3BCDFE',
    );
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskCard(task: task),
        ),
      ),
    );
    
    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('30:00'), findsOneWidget);
  });
  
  testWidgets('TimerScreen actualiza cada segundo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TimerScreen(
          task: Task(id: '1', name: 'Test', durationSeconds: 60),
        ),
      ),
    );
    
    // Inicial: 01:00
    expect(find.text('01:00'), findsOneWidget);
    
    // Después de 1 segundo: 00:59
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('00:59'), findsOneWidget);
  });
}
```

**Tests de widgets obligatorios:**
- [ ] TaskCard renderiza nombre, duración y color
- [ ] TaskCard responde a taps
- [ ] NewTaskModal valida inputs vacíos
- [ ] NewTaskModal muestra errores de validación
- [ ] TimerScreen muestra tiempo en formato correcto
- [ ] CircularProgress avanza proporcionalmente

### 7.5 Performance Tests (Sprint 6)

| Métrica | Herramienta | Método | Target | Dispositivo de prueba |
|---------|-------------|---------|--------|----------------------|
| **Tiempo de carga inicial** | Stopwatch en `main()` | Medir hasta primer frame | <3s | Pixel 4a (gama media) |
| **Consumo de CPU (timer activo)** | Android Profiler | Promedio de 5 minutos | <5% | Cualquier Android 10+ |
| **Consumo de RAM** | DevTools Memory | Con 50 tareas en lista | <100 MB | Cualquier dispositivo |
| **Batería (1 hora de uso)** | Battery Historian | Timer activo en background | <5% | Pixel 4a, iPhone 12 |
| **Frame rate (scroll)** | Performance Overlay | Lista con 100 tareas | ≥60 FPS | Cualquier dispositivo |
| **Tiempo de escritura DB** | Stopwatch | Insert de 1 tarea | <50ms | Emulador |
| **Tamaño de APK** | `flutter build apk --analyze-size` | Release build | <20 MB | N/A |

**Comandos para profiling:**

```bash
# Medir tiempo de carga
flutter run --profile --trace-startup

# Analizar rendimiento
flutter run --profile
# Luego presionar 'P' para abrir DevTools

# Medir tamaño de APK
flutter build apk --analyze-size --target-platform android-arm64

# Generar reporte de cobertura
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### 7.6 Device Tests (Sprint 6)

**Dispositivos mínimos requeridos:**

| Plataforma | Dispositivo | OS | Propósito |
|------------|-------------|-----|-----------|
| Android | Pixel 4a / Galaxy A32 | Android 8.0 | Gama baja |
| Android | Pixel 7 / Galaxy S23 | Android 14 | Gama alta |
| iOS | iPhone 8 | iOS 15 | Gama baja |
| iOS | iPhone 15 | iOS 17 | Gama alta |

**Checklist de pruebas manuales:**
- [ ] Crear tarea funciona en todos los dispositivos
- [ ] Control por volumen funciona (excepto fabricantes bloqueados)
- [ ] Vibración funciona al completar timer
- [ ] App no crashea al minimizar/reabrir
- [ ] Timer se restaura correctamente
- [ ] Scroll fluido con 100 tareas
- [ ] Rotación de pantalla no pierde estado
- [ ] No hay memory leaks después de 30 minutos de uso

---

## 8. Estrategia de Desarrollo (6 Sprints)

### Sprint 1: Setup + UI Base (Semana 1)

**Objetivo:** Configurar proyecto y crear pantallas básicas.

#### Tareas
- [ ] Crear proyecto Flutter con estructura de carpetas
- [ ] Configurar `pubspec.yaml` con dependencias
- [ ] Implementar tema dark (colores, estilos de texto)
- [ ] Crear `TaskListScreen` (UI estática)
- [ ] Crear `TaskCard` widget
- [ ] Crear `NewTaskModal` (UI sin lógica)
- [ ] Configurar Riverpod providers básicos

#### Definition of Done
- [ ] App corre sin errores en Android/iOS
- [ ] Pantallas se ven según diseño
- [ ] Tema dark aplicado correctamente
- [ ] Navegación básica funciona
- [ ] Code review aprobado
- [ ] Commit pusheado a `main`

#### Entregables
- Capturas de pantalla de UI
- Código en repositorio

---

### Sprint 2: SQLite CRUD (Semana 2)

**Objetivo:** Implementar persistencia de tareas.

#### Tareas
- [ ] Crear `DatabaseHelper` singleton
- [ ] Implementar schema de `tasks` table
- [ ] Crear `TaskModel` con serialización JSON
- [ ] Implementar `TaskRepository` (interfaz + implementación)
- [ ] Conectar `TaskProvider` con repository
- [ ] Implementar CRUD completo (Create, Read, Update, Delete)
- [ ] Agregar validaciones de input
- [ ] Escribir unit tests para repository (≥80% cobertura)

#### Definition of Done
- [ ] Las tareas se guardan en SQLite
- [ ] Las tareas persisten al cerrar/reabrir app
- [ ] Validaciones funcionan (nombre vacío, duración inválida)
- [ ] Unit tests pasan al 100%
- [ ] Cobertura de tests ≥40% del módulo
- [ ] Sin warnings de linter
- [ ] Code review aprobado

#### Entregables
- Base de datos funcional
- Suite de tests unitarios
- Documentación de API de repository

---

### Sprint 3: Lógica del Timer (Semana 3)

**Objetivo:** Implementar cronómetro funcional con animaciones.

#### Tareas
- [ ] Crear `TimerProvider` con lógica de countdown
- [ ] Implementar `TimerScreen` con controles táctiles
- [ ] Crear `CircularProgress` widget animado
- [ ] Implementar estados del timer (stopped, running, paused, completed)
- [ ] Guardar sesión de timer en SQLite
- [ ] Formatear tiempo correctamente (mm:ss)
- [ ] Agregar transiciones de pantalla
- [ ] Escribir unit tests para `TimerProvider`
- [ ] Escribir widget tests para `TimerScreen`

#### Definition of Done
- [ ] Timer decrementa de N minutos a 00:00
- [ ] Actualización visual cada segundo sin jank
- [ ] Animación circular avanza proporcionalmente (0-100%)
- [ ] Botones Start/Pause funcionan
- [ ] Estado se guarda en SQLite cada cambio
- [ ] Al llegar a 00:00 el timer se detiene
- [ ] Unit tests cubren `TimerProvider` (100%)
- [ ] Widget tests cubren `TimerScreen` (80%)
- [ ] Performance: CPU <5% durante 10 minutos
- [ ] Code review aprobado

#### Entregables
- Timer funcional
- Tests de timer
- Video demo del timer

---

### Sprint 4: Integración Hardware (Semana 4)

**Objetivo:** Agregar controles físicos y feedback háptico.

#### Tareas
- [ ] Integrar `volume_controller` package
- [ ] Crear `VolumeButtonService`
- [ ] Mapear Vol↑ → Start/Resume
- [ ] Mapear Vol↓ → Pause
- [ ] Integrar `vibration` package
- [ ] Crear `VibrationService`
- [ ] Disparar vibración al completar timer (500ms)
- [ ] Agregar fallback táctil si volumen no funciona
- [ ] Probar en múltiples fabricantes (Samsung, Xiaomi, Google)
- [ ] Manejar caso de permisos denegados

#### Definition of Done
- [ ] Vol↑ inicia/reanuda timer
- [ ] Vol↓ pausa timer
- [ ] Vibración funciona al llegar a 00:00
- [ ] Si control de volumen no funciona, mostrar mensaje
- [ ] Controles táctiles siempre disponibles
- [ ] Probado en ≥3 dispositivos diferentes
- [ ] Manual testing checklist completado
- [ ] Code review aprobado

#### Entregables
- Control por volumen funcional
- Matriz de compatibilidad de dispositivos
- Video demo en dispositivo físico

---

### Sprint 5: Background Mode (Semana 5)

**Objetivo:** Mantener timer funcionando en segundo plano.

#### Tareas
- [ ] Implementar estrategia de timestamps (no timer real)
- [ ] Crear `BackgroundService` para Android
- [ ] Configurar Foreground Service (Android)
- [ ] Implementar restauración de timer al reabrir app
- [ ] Manejar evento `AppLifecycleState.paused`
- [ ] Manejar evento `AppLifecycleState.resumed`
- [ ] Calcular tiempo transcurrido con timestamps
- [ ] Mostrar notificación persistente (Android)
- [ ] Probar con app minimizada durante 30 minutos
- [ ] Escribir integration tests de restauración

#### Definition of Done
- [ ] Timer continúa si minimizo la app
- [ ] Al reabrir, el timer muestra tiempo correcto
- [ ] Si el timer terminó en background, se marca como completado
- [ ] Foreground service funciona en Android
- [ ] iOS calcula tiempo correctamente al reabrir
- [ ] Integration test de restauración pasa
- [ ] Probado en dispositivos reales (≥2 por plataforma)
- [ ] Consumo de batería <5% por hora
- [ ] Code review aprobado

#### Entregables
- Background mode funcional
- Integration tests de persistencia
- Reporte de consumo de batería

---

### Sprint 6: QA + Release (Semana 6)

**Objetivo:** Testing completo y preparación para distribución.

#### Tareas
- [ ] Ejecutar suite completa de tests
- [ ] Alcanzar cobertura ≥70%
- [ ] Ejecutar performance tests en 4 dispositivos
- [ ] Corregir bugs encontrados en QA
- [ ] Optimizar animaciones si hay jank
- [ ] Optimizar queries de SQLite si hay lag
- [ ] Generar APK de release firmado
- [ ] Generar IPA de release firmado
- [ ] Crear screenshots para stores (5 por plataforma)
- [ ] Redactar descripción de store (ES/EN)
- [ ] Redactar Privacy Policy
- [ ] Crear README.md con instrucciones
- [ ] Actualizar CHANGELOG.md

#### Definition of Done
- [ ] Cobertura de tests ≥70%
- [ ] Todos los tests pasan
- [ ] Zero crashes en 100 sesiones de prueba
- [ ] Carga inicial <3s en Pixel 4a
- [ ] Scroll ≥60 FPS con 100 tareas
- [ ] APK <20 MB
- [ ] Batería <5% por hora de uso
- [ ] APK/IPA de release generados
- [ ] Screenshots listos
- [ ] Privacy policy publicada
- [ ] Documentación completa

#### Entregables
- APK/IPA de release
- Reporte de QA
- Screenshots para stores
- Documentación final
- Changelog

---

## 9. Gestión de Errores

### 9.1 Estrategia de Error Handling

| Tipo de Error | Causa | Acción | Logging |
|---------------|-------|--------|---------|
| `DatabaseException` | Corrupción de SQLite | Mostrar alerta + reinicializar DB | ✅ Error |
| `SqliteException` (UNIQUE constraint) | Intento de duplicar ID | Regenerar UUID + reintentar | ⚠️ Warning |
| `PlatformException` (volumen) | Permisos denegados | Mostrar mensaje + ofrecer controles táctiles | ℹ️ Info |
| `TimeoutException` | DB tarda >5s | Mostrar "Cargando..." | ⚠️ Warning |
| `StateError` (timer) | Estado inconsistente | Resetear timer + log error | ✅ Error |
| `FormatException` (JSON) | Datos corruptos | Eliminar entrada + notificar usuario | ✅ Error |
| `ValidationException` | Input inválido | Mostrar error en UI | ℹ️ Info |

### 9.2 Implementación de Logging

```dart
// lib/core/utils/logger.dart

enum LogLevel { info, warning, error, critical }

class Logger {
  static void log(String message, {LogLevel level = LogLevel.info}) {
    final timestamp = DateTime.now().toIso8601String();
    final emoji = _getEmoji(level);
    
    if (kDebugMode) {
      print('$emoji [$timestamp] $message');
    }
    
    // En producción, enviar solo errores críticos a Crashlytics (opcional)
    if (level == LogLevel.critical || level == LogLevel.error) {
      // FirebaseCrashlytics.instance.log(message);
    }
  }
  
  static String _getEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.info: return 'ℹ️';
      case LogLevel.warning: return '⚠️';
      case LogLevel.error: return '❌';
      case LogLevel.critical: return '🔥';
    }
  }
}
```

### 9.3 Error Recovery

```dart
// lib/data/repositories/task_repository_impl.dart

class TaskRepositoryImpl implements TaskRepository {
  Future<void> createTask(Task task) async {
    try {
      // Validar antes de guardar
      final validationError = TaskValidators.validateName(task.name);
      if (validationError != null) {
        throw ValidationException(validationError);
      }
      
      // Intentar guardar
      await _db.insert('tasks', task.toMap());
      Logger.log('Task created: ${task.id}', level: LogLevel.info);
      
    } on SqliteException catch (e) {
      if (e.toString().contains('UNIQUE constraint')) {
        // Regenerar ID y reintentar
        final newTask = task.copyWith(id: uuid.v4());
        return createTask(newTask);
      }
      
      Logger.log('DB error: ${e.toString()}', level: LogLevel.error);
      throw DatabaseException('No se pudo guardar la tarea');
      
    } catch (e) {
      Logger.log('Unexpected error: ${e.toString()}', level: LogLevel.critical);
      rethrow;
    }
  }
}
```

---

## 10. Riesgos Técnicos

### 10.1 Registro de Riesgos

| ID | Riesgo | Probabilidad | Impacto | Mitigación | Owner | Status |
|----|--------|--------------|---------|------------|-------|--------|
| R-01 | `volume_controller` no funciona en Samsung/Xiaomi | ⚠️ Alta | 🔴 Alto | Implementar fallback táctil obligatorio en Sprint 4 | JuanP | 🟡 Activo |
| R-02 | iOS mata proceso en background | ⚠️ Media | 🔴 Crítico | Usar timestamp-based calculation en Sprint 5 | JuanP | ✅ Mitigado |
| R-03 | SQLite se corrompe en crash | 🟢 Baja | 🟠 Alto | Backups automáticos antes de migraciones en Sprint 2 | JuanP | ✅ Mitigado |
| R-04 | Animaciones causan jank en Android 8 | ⚠️ Media | 🟠 Medio | Usar `RepaintBoundary` y perfilar en Sprint 3 | JuanP | 🟡 Activo |
| R-05 | Foreground service bloqueado por OEM | ⚠️ Alta | 🟠 Medio | Documentar limitaciones + usar timestamps en Sprint 5 | JuanP | ✅ Mitigado |
| R-06 | Tests no alcanzan 70% de cobertura | 🟢 Baja | 🟠 Medio | Escribir tests en paralelo con features desde Sprint 2 | JuanP | 🟡 Activo |
| R-07 | APK excede 20 MB | 🟢 Baja | 🟢 Bajo | Revisar assets y usar `--split-per-abi` en Sprint 6 | JuanP | 🔵 Monitoreando |

**Leyenda:**
- Probabilidad: 🟢 Baja | ⚠️ Media | 🔴 Alta
- Impacto: 🟢 Bajo | 🟠 Medio | 🔴 Alto | 🔴 Crítico
- Status: 🔵 Monitoreando | 🟡 Activo | ✅ Mitigado | ❌ Materializado

### 10.2 Plan de Contingencia

#### R-01: Volumen no funciona
**Si se materializa:**
1. Mostrar alerta la primera vez que se abre `TimerScreen`
2. Destacar botones táctiles de Start/Pause
3. Agregar tooltip explicativo
4. Documentar dispositivos incompatibles en README

#### R-04: Jank en animaciones
**Si se materializa:**
1. Reducir frecuencia de actualización de timer (cada 500ms en vez de 1s)
2. Usar `RepaintBoundary` en `CircularProgress`
3. Simplificar gradientes si es necesario
4. Establecer requisito mínimo de Android 9.0

---

## 11. Scripts y Comandos

### 11.1 Setup Inicial

```bash
# Clonar repositorio
git clone https://github.com/JuanPMorales/task-timer.git
cd task-timer

# Verificar entorno
flutter doctor -v

# Instalar dependencias
flutter pub get

# Generar archivos de código (si usas build_runner)
flutter pub run build_runner build --delete-conflicting-outputs
```

### 11.2 Desarrollo

```bash
# Ejecutar en modo debug
flutter run

# Ejecutar en modo profile (para profiling)
flutter run --profile

# Ejecutar en dispositivo específico
flutter devices
flutter run -d <device-id>

# Hot reload
# Presionar 'r' en la terminal mientras la app corre

# Hot restart
# Presionar 'R' en la terminal
```

### 11.3 Testing

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar tests con cobertura
flutter test --coverage

# Generar reporte HTML de cobertura
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
xdg-open coverage/html/index.html  # Linux
start coverage/html/index.html  # Windows

# Ejecutar tests de integración
flutter test integration_test/

# Ejecutar tests en dispositivo específico
flutter test integration_test/ -d <device-id>
```

### 11.4 Análisis y Linting

```bash
# Analizar código
flutter analyze

# Formatear código
flutter format lib/ test/

# Verificar imports no usados
flutter pub run dependency_validator
```

### 11.5 Build de Release

```bash
# Android - APK (todas las arquitecturas)
flutter build apk --release

# Android - APK por arquitectura (reduce tamaño)
flutter build apk --release --split-per-abi

# Android - App Bundle (recomendado para Play Store)
flutter build appbundle --release

# iOS - IPA
flutter build ios --release

# Analizar tamaño de APK
flutter build apk --analyze-size --target-platform android-arm64

# Ver árbol de dependencias de tamaño
flutter build apk --analyze-size --target-platform android-arm64 | grep -A 20 "app-release.apk"
```

### 11.6 Profiling

```bash
# Abrir DevTools
flutter pub global activate devtools
flutter pub global run devtools

# Ejecutar con profiling
flutter run --profile --trace-startup

# Analizar rendimiento de startup
flutter run --profile --trace-startup --cache-startup-profile

# Medir frame rate
flutter run --profile
# Luego presionar 'P' para abrir Performance Overlay
```

### 11.7 Limpieza

```bash
# Limpiar build artifacts
flutter clean

# Limpiar + reinstalar dependencias
flutter clean && flutter pub get

# Limpiar caché de pub
flutter pub cache repair
```

---

## 12. Criterios de Aceptación del MVP Completo

### 12.1 Checklist de Funcionalidad

#### Features Core
- [ ] **Crear tarea:** Puedo crear una tarea en <30 segundos
- [ ] **Editar tarea:** Puedo modificar nombre y duración
- [ ] **Eliminar tarea:** Puedo eliminar con confirmación
- [ ] **Listar tareas:** Veo todas mis tareas ordenadas por fecha
- [ ] **Iniciar timer:** Puedo iniciar con ≤2 toques
- [ ] **Pausar timer:** Puedo pausar con Vol↓ o botón táctil
- [ ] **Reanudar timer:** Puedo reanudar con Vol↑ o botón táctil
- [ ] **Completar timer:** Recibo vibración al llegar a 00:00
- [ ] **Persistencia:** Si cierro la app, mis tareas persisten
- [ ] **Background:** Si minimizo con timer activo, continúa corriendo

#### Validaciones
- [ ] No puedo crear tarea con nombre vacío
- [ ] No puedo crear tarea con duración <1 min o >24 horas
- [ ] Veo mensajes de error claros en UI

#### UX
- [ ] Animación circular avanza suavemente
- [ ] Transiciones entre pantallas son fluidas
- [ ] No hay lag al hacer scroll con 100 tareas
- [ ] Dark mode aplicado en todas las pantallas
- [ ] Botones tienen tamaño táctil ≥48px

### 12.2 Criterios Técnicos

#### Performance
- [ ] Carga inicial <3s en Pixel 4a (gama media)
- [ ] CPU <5% con timer activo durante 10 minutos
- [ ] RAM <100 MB con 50 tareas en lista
- [ ] Scroll ≥60 FPS con 100 tareas
- [ ] Batería <5% por hora de uso con timer en background
- [ ] Escritura en DB <50ms por operación

#### Calidad de Código
- [ ] Cobertura de tests ≥70%
- [ ] Todos los tests pasan (unit + integration + widget)
- [ ] Zero warnings de `flutter analyze`
- [ ] Código formateado con `flutter format`
- [ ] Sin TODOs críticos sin resolver

#### Estabilidad
- [ ] Zero crashes en 100 sesiones de prueba
- [ ] Sin memory leaks después de 30 minutos de uso
- [ ] Maneja correctamente DB corrupta (reinicializa)
- [ ] Maneja permisos denegados (ofrece alternativas)

#### Compatibilidad
- [ ] Funciona en Android 8.0+ (API 26)
- [ ] Funciona en iOS 15+
- [ ] Probado en ≥2 dispositivos Android (diferente fabricante)
- [ ] Probado en ≥2 dispositivos iOS (diferentes modelos)

### 12.3 Checklist de Distribución

#### Assets
- [ ] APK de release generado y firmado (<20 MB)
- [ ] IPA de release generado y firmado
- [ ] Icono de app en todas las resoluciones
- [ ] Splash screen configurado

#### Documentación
- [ ] README.md con instrucciones de instalación
- [ ] README.md con arquitectura explicada
- [ ] CHANGELOG.md con historial de cambios
- [ ] Comentarios de código en funciones complejas
- [ ] Documentación de API de repositories

#### Legal
- [ ] Privacy Policy redactada y publicada
- [ ] Licencia MIT agregada al repositorio
- [ ] Créditos de dependencias incluidos

#### Stores (preparación)
- [ ] 5 screenshots por plataforma (Android/iOS)
- [ ] Descripción corta (80 caracteres)
- [ ] Descripción completa (ES/EN)
- [ ] Video preview (opcional, 30 segundos)
- [ ] Categoría seleccionada: Productivity

---

## 13. Próximos Pasos Post-MVP

### 13.1 Roadmap Inmediato (v1.1 - 1-2 meses)

**Objetivo:** Mejorar experiencia basada en feedback de usuarios.

- [ ] Estadísticas básicas (tiempo total por tarea)
- [ ] Modo claro (tema opcional)
- [ ] Sonidos personalizables al completar
- [ ] Exportar datos a CSV
- [ ] Notificaciones locales programadas
- [ ] Widget para pantalla de inicio (Android)

### 13.2 Roadmap Medio Plazo (v1.5 - 3-4 meses)

- [ ] Múltiples timers simultáneos
- [ ] Categorías/tags de tareas
- [ ] Gráficos de productividad (weekly/monthly)
- [ ] Historial de sesiones completadas
- [ ] Búsqueda y filtros en lista de tareas
- [ ] Today Widget (iOS)

### 13.3 Roadmap Largo Plazo (v2.0 - 6+ meses)

- [ ] Sincronización en la nube (Firebase/Supabase)
- [ ] Compartir reportes
- [ ] Integración con Wear OS / Apple Watch
- [ ] Exportar a PDF
- [ ] Modo Pomodoro integrado (auto-alternancia)
- [ ] Colaboración en equipos

---

## 14. Métricas de Éxito del MVP

### 14.1 Métricas de Producto (3 meses post-lanzamiento)

| Métrica | Objetivo | Herramienta de Medición |
|---------|----------|------------------------|
| Instalaciones totales | 1,000+ | Google Play Console + App Store Connect |
| Retención día 1 | >40% | Firebase Analytics (opcional) |
| Retención día 7 | >25% | Firebase Analytics |
| Retención día 30 | >10% | Firebase Analytics |
| Sesiones por usuario/semana | >8 | Analytics |
| Tiempo promedio de sesión | >15 min | Analytics |
| Calificación en stores | >4.0/5 | Reviews |
| Tasa de crashes | <1% | Crashlytics (opcional) |

### 14.2 Métricas Técnicas (durante desarrollo)

| Métrica | Objetivo | Herramienta |
|---------|----------|-------------|
| Cobertura de tests | >70% | `flutter test --coverage` |
| Tiempo de build (debug) | <3 min | CI/CD logs |
| Tiempo de build (release) | <8 min | CI/CD logs |
| Tamaño de APK | <20 MB | `flutter build apk --analyze-size` |
| Velocidad de carga | <3s | Stopwatch + Performance profiler |
| Frame drops en scroll | <5% | Performance Overlay |

---

## 15. Contacto y Recursos

### 15.1 Equipo

| Rol | Nombre | Responsabilidades |
|-----|--------|-------------------|
| **Product Owner** | JuanP | Dirección del producto, priorización |
| **Tech Lead** | JuanP | Arquitectura, code reviews |
| **Mobile Developer** | JuanP | Implementación de features |
| **QA** | JuanP | Testing manual, reportes de bugs |

### 15.2 Canales de Comunicación

- **Código:** https://github.com/JuanPMorales/task-timer
- **Bugs:** GitHub Issues
- **Preguntas:** GitHub Discussions
- **Features:** GitHub Discussions > Ideas

### 15.3 Recursos Externos

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [Material Design Guidelines](https://m3.material.io/)

---

## 16. Glosario Técnico

| Término | Definición |
|---------|------------|
| **Clean Architecture** | Patrón que separa lógica de negocio, UI y datos en capas independientes |
| **MVVM** | Model-View-ViewModel, patrón de presentación donde el ViewModel gestiona estado |
| **Riverpod** | Librería de gestión de estado reactivo para Flutter |
| **SQLite** | Motor de base de datos embebido, sin servidor |
| **Foreground Service** | Servicio de Android que mantiene proceso vivo con notificación visible |
| **Timestamp-based calculation** | Calcular tiempo transcurrido usando diferencia entre timestamps, no timers reales |
| **Hot reload** | Actualizar código sin reiniciar la app (preserva estado) |
| **Hot restart** | Reiniciar app con nuevo código (pierde estado) |
| **Widget test** | Test que verifica renderizado de widgets |
| **Integration test** | Test que verifica flujo completo end-to-end |
| **Code coverage** | Porcentaje de código ejecutado durante tests |
| **Jank** | Frames perdidos que causan animaciones entrecortadas |
| **RepaintBoundary** | Widget que optimiza repintado limitando área afectada |

---

## 17. Checklist de Pre-Lanzamiento

### Semana Antes del Lanzamiento

- [ ] Ejecutar suite completa de tests (100% passing)
- [ ] Verificar cobertura ≥70%
- [ ] Performance tests en 4 dispositivos (2 Android, 2 iOS)
- [ ] Manual testing en cada dispositivo (checklist completo)
- [ ] Verificar que APK/IPA firmados funcionan
- [ ] Revisar que no hay datos de prueba hardcodeados
- [ ] Verificar que logs sensibles están deshabilitados en release
- [ ] Actualizar versión en `pubspec.yaml` (1.0.0)
- [ ] Actualizar CHANGELOG.md con features y fixes
- [ ] Screenshots finales tomados
- [ ] Video demo grabado (opcional)

### Día del Lanzamiento

- [ ] Subir APK a Google Play Console (track: production)
- [ ] Subir IPA a App Store Connect
- [ ] Publicar Privacy Policy en sitio web
- [ ] Publicar código en GitHub (si open source)
- [ ] Crear release en GitHub con notas
- [ ] Post en redes sociales
- [ ] Notificar a beta testers
- [ ] Monitorear Crashlytics primeras 24 horas

---

## 18. Licencia

**MIT License**

```
Copyright (c) 2025 JuanP

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 19. Historial de Cambios del Documento

| Fecha | Versión | Cambios |
|-------|---------|---------|
| 2025-11-11 | 1.0 | Creación del documento inicial |
| 2025-11-11 | 1.1 | Expansión completa: arquitectura detallada, testing strategy, riesgos, scripts, criterios de aceptación |

---

**📌 Documento Aprobado para Iniciar Desarrollo**

**✅ Sprint 1 puede comenzar inmediatamente**

---

_Generado con ❤️ por JuanP | Última actualización: 2025-11-11 15:40:01 UTC_
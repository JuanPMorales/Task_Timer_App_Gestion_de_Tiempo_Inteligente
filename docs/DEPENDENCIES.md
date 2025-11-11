# 📦 Dependencias del Proyecto - Task Timer App

**Fecha:** 2025-11-11  
**Versión del Proyecto:** 0.1.0+1

---

## 📊 Resumen de Dependencias

| Categoría | Cantidad | Propósito |
|-----------|----------|-----------|
| **State Management** | 3 | Riverpod para gestión de estado reactivo |
| **Database** | 3 | SQLite para persistencia local |
| **UI & Icons** | 1 | Íconos de Material Design |
| **Utilities** | 2 | Formateo de fechas y UUIDs |
| **Native Services** | 2 | Control de volumen y vibración |
| **Background** | 1 | Servicio en segundo plano |
| **Notifications** | 1 | Notificaciones locales |
| **Localization** | 1 | Internacionalización |
| **Dev Dependencies** | 5 | Testing, linting y generación de código |

**Total:** 14 dependencias de producción + 5 de desarrollo

---

## 🎯 Dependencias de Producción

### State Management

#### `flutter_riverpod: ^2.6.1`
- **Propósito:** Gestión de estado reactivo
- **Documentación:** https://riverpod.dev/
- **Uso en el proyecto:**
  - `TaskListProvider` para gestionar lista de tareas
  - `TimerStateProvider` para controlar el temporizador
  - `DatabaseProvider` para instancia de SQLite
- **Ventajas:**
  - Compile-safe
  - No requiere BuildContext
  - Fácil testing con mocks
  - Provider scoping

#### `riverpod_annotation: ^2.6.1`
- **Propósito:** Anotaciones para generación de código con Riverpod
- **Uso:** Simplificar creación de providers con `@riverpod`

---

### Database & Persistencia

#### `sqflite: ^2.3.3+1`
- **Propósito:** Base de datos SQLite nativa
- **Documentación:** https://pub.dev/packages/sqflite
- **Uso en el proyecto:**
  - Almacenar tareas (`tasks` table)
  - Almacenar sesiones de timer (`timer_sessions` table)
  - CRUD completo
  - Queries optimizadas con índices
- **Plataformas:** Android (API 16+), iOS (12+)
- **Límites:**
  - Tamaño máximo de DB: ~140 TB (teórico)
  - En práctica: < 10 MB para 1000 tareas

#### `path_provider: ^2.1.4`
- **Propósito:** Obtener rutas de directorios del sistema
- **Uso:** Localizar directorio de documentos para SQLite
- **Ejemplo:**
  ```dart
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'task_timer.db');
  ```

#### `path: ^1.9.0`
- **Propósito:** Manipulación de rutas de archivos
- **Uso:** Construir paths de forma multiplataforma

---

### UI & Iconos

#### `cupertino_icons: ^1.0.8`
- **Propósito:** Íconos de iOS Cupertino
- **Uso:** Compatibilidad con widgets de iOS

---

### Utilities

#### `intl: ^0.20.2`
- **Propósito:** Internacionalización y formateo
- **Uso en el proyecto:**
  - Formateo de tiempo (mm:ss, hh:mm:ss)
  - Formateo de fechas (`created_at`, `updated_at`)
  - Soporte para múltiples idiomas (futuro)
- **Ejemplo:**
  ```dart
  final formatter = DateFormat('HH:mm:ss');
  String formattedTime = formatter.format(DateTime.now());
  ```

#### `uuid: ^4.5.1`
- **Propósito:** Generación de UUIDs únicos
- **Uso:** IDs de tareas y sesiones de timer
- **Tipo:** UUID v4 (aleatorio)
- **Ejemplo:**
  ```dart
  final taskId = Uuid().v4(); // "550e8400-e29b-41d4-a716-446655440000"
  ```

---

### Native Services

#### `volume_controller: ^2.0.8`
- **Propósito:** Control de botones físicos de volumen
- **Documentación:** https://pub.dev/packages/volume_controller
- **Uso en el proyecto:**
  - Vol ↑ → Iniciar/Reanudar timer
  - Vol ↓ → Pausar timer
- **Plataformas:**
  - ✅ Android API 21+
  - ⚠️ iOS 13+ (limitaciones de Apple)
- **Limitaciones conocidas:**
  - No funciona en todos los fabricantes Android (Samsung, Xiaomi con MIUI)
  - iOS no permite interceptar completamente los botones
- **Fallback:** Controles táctiles siempre disponibles

#### `vibration: ^2.1.0`
- **Propósito:** Feedback háptico
- **Uso en el proyecto:**
  - Vibración al completar timer (500ms)
  - Vibración al pausar (100ms)
- **Patrón de vibración:**
  ```dart
  Vibration.vibrate(duration: 500, amplitude: 128);
  ```
- **Plataformas:** Android (API 11+), iOS (10+)
- **Validación:** Verificar soporte antes de ejecutar

---

### Background & Lifecycle

#### `flutter_background_service: ^5.0.10`
- **Propósito:** Servicio en segundo plano
- **Uso en el proyecto:**
  - Mantener timer activo cuando app está minimizada
  - Foreground service en Android (notificación persistente)
  - Background tasks en iOS (limitado a 30s)
- **Android:**
  - Requiere permisos: `FOREGROUND_SERVICE`, `WAKE_LOCK`
  - Notificación obligatoria (Android 8+)
- **iOS:**
  - Usa Background Modes con timestamps
  - No hay servicio real en background

---

### Notifications

#### `flutter_local_notifications: ^18.0.1`
- **Propósito:** Notificaciones locales
- **Uso en el proyecto:**
  - Notificación de timer completado
  - Notificación persistente para foreground service (Android)
- **Canales de notificación (Android):**
  - `timer_channel`: Prioridad alta para completado
  - `service_channel`: Foreground service
- **Ejemplo:**
  ```dart
  await flutterLocalNotificationsPlugin.show(
    0,
    'Timer Completado!',
    'Has terminado: ${task.name}',
    notificationDetails,
  );
  ```

---

### Localization

#### `flutter_localizations` (SDK)
- **Propósito:** Soporte de internacionalización oficial de Flutter
- **Uso:** Provee widgets localizados (DatePicker, TimePicker, etc.)
- **Idiomas soportados en MVP:** Español (es), Inglés (en)

---

## 🛠️ Dependencias de Desarrollo

### Linting & Code Quality

#### `flutter_lints: ^5.0.0`
- **Propósito:** Reglas de linting recomendadas por Flutter
- **Configuración:** `analysis_options.yaml`
- **Nivel:** Strict (errores en warnings)

---

### Code Generation

#### `build_runner: ^2.5.4`
- **Propósito:** Herramienta de generación de código
- **Uso:** Ejecutar generadores de código (Riverpod, Freezed, etc.)
- **Comando:**
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```

#### `riverpod_generator: ^2.6.5`
- **Propósito:** Generador de providers de Riverpod
- **Uso:** Generar código boilerplate para `@riverpod`
- **Output:** `.g.dart` files

---

### Testing

#### `flutter_test` (SDK)
- **Propósito:** Framework de testing oficial
- **Uso:**
  - Unit tests (repositorios, use cases)
  - Widget tests (UI components)

#### `mockito: ^5.4.6`
- **Propósito:** Mocking para tests unitarios
- **Uso:** Crear mocks de repositorios y servicios
- **Ejemplo:**
  ```dart
  @GenerateMocks([TaskRepository, TimerRepository])
  void main() {
    final mockRepo = MockTaskRepository();
    // ...
  }
  ```

#### `integration_test` (SDK)
- **Propósito:** Tests de integración end-to-end
- **Uso:** Probar flujos completos de usuario

---

## 📋 Requisitos de Sistema

### SDK Requirements

```yaml
environment:
  sdk: '>=3.3.0 <4.0.0'
  flutter: '>=3.19.0'
```

### Android

- **Minimum SDK:** API 21 (Android 5.0 Lollipop)
- **Target SDK:** API 34 (Android 14)
- **Permisos requeridos:**
  ```xml
  <uses-permission android:name="android.permission.VIBRATE" />
  <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
  <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
  <uses-permission android:name="android.permission.WAKE_LOCK" />
  ```

### iOS

- **Minimum Version:** iOS 12.0
- **Target Version:** iOS 17.0
- **Capabilities:**
  - Background Modes: Processing
  - Notifications

---

## 🔄 Comandos Útiles

### Instalar dependencias
```bash
flutter pub get
```

### Actualizar dependencias
```bash
flutter pub upgrade
```

### Ver dependencias desactualizadas
```bash
flutter pub outdated
```

### Limpiar y reinstalar
```bash
flutter clean
flutter pub get
```

### Generar código (Riverpod)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Generar código en watch mode
```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## 🚨 Problemas Conocidos y Soluciones

### 1. Conflicto de versiones de `intl`

**Problema:** `flutter_localizations` requiere versión específica de `intl`

**Solución:** Usar la versión pinned por Flutter SDK
```yaml
intl: ^0.20.2  # Versión requerida por flutter_localizations
```

### 2. `volume_controller` no funciona en ciertos dispositivos

**Problema:** Fabricantes personalizan ROMs y bloquean interceptación de botones

**Solución:** 
- Detectar fallo y mostrar controles táctiles
- No depender exclusivamente de botones físicos

### 3. Background service en iOS limitado

**Problema:** iOS no permite servicios persistentes en background

**Solución:**
- Usar timestamps en lugar de timers reales
- Calcular tiempo transcurrido al reabrir app

### 4. Permisos de notificaciones en Android 13+

**Problema:** Android 13+ requiere permiso explícito para notificaciones

**Solución:**
- Solicitar permiso en primera ejecución
- Manejar caso de denegación

---

## 📊 Tamaño Estimado de Build

| Platform | Debug | Release | Notas |
|----------|-------|---------|-------|
| **APK (Android)** | ~45 MB | ~18 MB | Con splits por ABI |
| **AAB (Android)** | N/A | ~16 MB | Google Play optimiza |
| **IPA (iOS)** | ~60 MB | ~25 MB | Con bitcode |

---

## 🔐 Seguridad y Privacidad

### Dependencias sin tracking
✅ Todas las dependencias son open source  
✅ No se incluyen analytics (Firebase, etc.)  
✅ No se incluyen ads (AdMob, etc.)  
✅ Datos 100% locales (no salen del dispositivo)

### Auditoría de dependencias
```bash
# Ver árbol de dependencias
flutter pub deps --style=compact

# Buscar dependencias inseguras
flutter pub audit
```

---

## 📚 Referencias

- [Flutter Packages](https://pub.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [SQLite Flutter Plugin](https://github.com/tekartik/sqflite)
- [Flutter Background Service](https://pub.dev/packages/flutter_background_service)

---

**Última actualización:** 2025-11-11  
**Mantenido por:** JuanP  
**Revisión:** Verificar actualizaciones mensualmente con `flutter pub outdated`

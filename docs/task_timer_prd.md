# 🕒 Product Requirements Document (PRD)

## Task Timer App

**Versión:** 2.0  
**Fecha:** 2025-11-11  
**Autor:** JuanP  
**Última actualización:** 2025-11-11

---

## 1. Resumen Ejecutivo
Task Timer es una aplicación móvil desarrollada en Flutter que permite registrar, visualizar y medir el tiempo dedicado a distintas actividades (trabajo, estudio o descanso). Está diseñada para usuarios que buscan mejorar su productividad mediante una experiencia moderna, fluida y completamente local, sin necesidad de conexión a internet.

---

## 2. Información General

**Nombre del producto:** Task Timer  
**Plataformas:** Android / iOS  
**Tecnologías:**

* **Frontend:** Flutter (Dart)
* **Base de datos local:** SQLite
* **Gestor de estado:** Riverpod
* **Persistencia:** sqflite
* **Tema:** Dark Mode (azul oscuro + azul claro)

---

## 3. Objetivo del Producto
Desarrollar una aplicación móvil sencilla y moderna que permita al usuario **crear tareas, iniciar cronómetros personalizados y visualizar su progreso** con controles rápidos y almacenamiento local.

---

## 4. Público Objetivo
* Profesionales, estudiantes o freelancers que necesiten llevar control de su tiempo.
* Personas que desean optimizar sus rutinas o mejorar su enfoque.
* Usuarios que prefieren herramientas offline-first y con privacidad garantizada.

---

## 5. Características Principales

### 5.1 Pantalla Principal — Task List
**Objetivo:** Mostrar y gestionar la lista de tareas creadas.

**Componentes UI:**
* Título superior: `Task Timer`
* Lista de tareas en tarjetas degradadas (azul claro → azul oscuro)
* Cada tarjeta incluye:
  * Duración (`30:00`)
  * Nombre (`Timer: Planning`)
  * Icono de reloj para iniciar o editar
* FAB "+" para crear tareas

**Acciones:**
* Tap en tarea → abre cronómetro.
* Tap en "+" → abre modal de nueva tarea.

**Modal Nueva Tarea:**
* Campo: Nombre (máx. 50 caracteres)
* Selector de hora inicio/fin (opcional)
* Selector de color (5 tonos predefinidos)
* Botón Guardar (almacena en SQLite)

**Validaciones:**
* El nombre no puede estar vacío
* La duración debe estar entre 1 minuto y 24 horas
* Mostrar mensaje de error si fallan validaciones

---

### 5.2 Pantalla Secundaria — Timer
**Objetivo:** Controlar el cronómetro de una tarea.

**Componentes UI:**
* Título: Nombre de la tarea
* Subtexto: "Up next: [siguiente tarea]"
* Círculo animado de progreso
* Tiempo `mm:ss`
* Texto inferior: "Slide to Start"
* Fondo con degradado y colores dinámicos

**Controles Físicos:**
* **Volumen ↑:** Inicia o reanuda
* **Volumen ↓:** Pausa

**Animaciones:**
* Progreso circular (azul claro → azul oscuro)
* Vibración al finalizar

**Estados del Timer:**
* **Detenido:** Estado inicial, listo para iniciar
* **En curso:** Contando regresivamente
* **Pausado:** Tiempo detenido, puede reanudarse
* **Completado:** Tiempo llegó a 00:00

---

## 6. Flujo de Navegación
```
Inicio (Task List)
   ↓ Tap en tarea
Timer Screen
   ↓ Back
Regreso a Task List
   ↓ Tap "+"
Modal Nueva Tarea → Guardar → Regreso a lista
```

---

## 7. Escenarios de Uso

### Escenario 1: Sesión de Estudio Ininterrumpida
**Actor:** María, estudiante universitaria  
**Contexto:** Quiere estudiar 90 minutos de matemáticas  
**Flujo:**
1. Abre la app y toca el botón "+"
2. Ingresa "Estudio - Matemáticas" y configura 90 min
3. Selecciona color azul y guarda
4. Toca la tarea para abrir el timer
5. Presiona Vol ↑ para iniciar
6. Estudia sin interrupciones hasta que el timer vibra al terminar

### Escenario 2: Técnica Pomodoro con Pausas
**Actor:** Juan, desarrollador freelance  
**Contexto:** Trabaja en sesiones de 25 min con pausas de 5 min  
**Flujo:**
1. Crea tarea "Pomodoro - Coding" de 25 min
2. Inicia el timer con Vol ↑
3. Suena el teléfono a los 10 minutos
4. Presiona Vol ↓ para pausar
5. Atiende la llamada (2 minutos)
6. Presiona Vol ↑ para reanudar
7. Completa los 15 minutos restantes

### Escenario 3: App Cerrada Durante Timer Activo
**Actor:** Ana, diseñadora gráfica  
**Contexto:** Inicia un timer de 60 min pero cierra la app accidentalmente  
**Flujo:**
1. Inicia timer "Diseño - Logo Cliente"
2. Minimiza la app para revisar email
3. Cierra la app por error
4. Reabre la app 10 minutos después
5. **Resultado esperado:** El timer continúa desde donde quedó (50 min restantes)

---

## 8. Historias de Usuario

| ID | Historia | Prioridad | Estimación |
|----|----------|-----------|------------|
| US-01 | Como usuario, quiero crear una tarea con nombre y duración, para poder medir mi tiempo de trabajo. | Alta | 3 pts |
| US-02 | Como usuario, quiero pausar y reanudar el cronómetro con los botones de volumen, para no interrumpir mi concentración. | Alta | 5 pts |
| US-03 | Como usuario, quiero ver la lista de mis tareas con colores, para identificar rápidamente mis actividades. | Media | 2 pts |
| US-04 | Como usuario, quiero editar una tarea existente, para corregir errores o ajustar duraciones. | Media | 3 pts |
| US-05 | Como usuario, quiero eliminar tareas que ya no uso, para mantener mi lista organizada. | Baja | 2 pts |
| US-06 | Como usuario, quiero que el timer continúe en background, para no perder progreso si cambio de app. | Alta | 8 pts |

---

## 9. Requerimientos Funcionales

| ID | Requerimiento | Descripción | Criterios de Aceptación |
|----|----------------|-------------|------------------------|
| RF-01 | Crear tarea | Permitir crear una tarea con nombre, duración y color. | ✓ Nombre entre 1-50 caracteres<br>✓ Duración entre 1 min - 24 hrs<br>✓ Color seleccionable<br>✓ Se guarda en SQLite |
| RF-02 | Editar tarea | Modificar nombre o duración. | ✓ Se pueden editar todos los campos<br>✓ Cambios se persisten |
| RF-03 | Eliminar tarea | Eliminar tareas almacenadas. | ✓ Confirmación antes de eliminar<br>✓ No se puede recuperar después |
| RF-04 | Iniciar cronómetro | Iniciar conteo del tiempo. | ✓ Inicia con botón o Vol ↑<br>✓ Se actualiza cada segundo<br>✓ Animación de progreso |
| RF-05 | Control físico | Pausar/reanudar con botones de volumen. | ✓ Vol ↑ inicia/reanuda<br>✓ Vol ↓ pausa |
| RF-06 | Guardado local | Persistir datos con SQLite. | ✓ Todas las tareas se guardan<br>✓ Estado del timer se guarda |
| RF-07 | Restaurar sesión | Recuperar tareas al abrir la app. | ✓ Lista de tareas se carga<br>✓ Timer activo se restaura |
| RF-08 | Notificación al completar | Vibración y sonido al llegar a 00:00. | ✓ Vibración de 500ms<br>✓ Sonido opcional |
| RF-09 | Ejecución en background | Timer continúa si la app está minimizada. | ✓ Foreground service (Android)<br>✓ Background mode (iOS) |

---

## 9.5 Manejo de Interrupciones y Estados Críticos

| Evento | Comportamiento Esperado | Prioridad |
|--------|------------------------|-----------|
| **App cerrada con timer activo** | El timer se guarda y continúa en background. Al reabrir, se restaura el estado. | Alta |
| **Llamada entrante** | El timer se pausa automáticamente. Al colgar, se muestra opción para reanudar. | Alta |
| **Batería baja (<5%)** | Se muestra notificación. El timer se pausa automáticamente si llega a 0%. | Media |
| **Reinicio del dispositivo** | El timer se detiene y se guarda el progreso hasta ese momento. | Media |
| **Cambio de zona horaria** | No afecta el timer (usa tiempo relativo, no absoluto). | Baja |
| **Permisos de volumen revocados** | Se muestra mensaje de error y se ofrecen controles táctiles alternativos. | Media |

---

## 10. Requerimientos No Funcionales

| ID | Categoría | Descripción |
|----|------------|---------------|
| RNF-01 | Usabilidad | Máximo 3 pasos para iniciar un timer. |
| RNF-02 | Diseño | Paleta azul oscuro (#0A0E2A) y azul claro (#3BCDFE). |
| RNF-03 | Rendimiento | Carga < 3s en dispositivos de gama media. |
| RNF-04 | Accesibilidad | Botones táctiles ≥ 48px. Soporte para TalkBack/VoiceOver. |
| RNF-05 | Seguridad | Acceso local, sin conexión externa. Datos no salen del dispositivo. |
| RNF-06 | Compatibilidad | Android 8.0+ (API 26), iOS 15+. |
| RNF-07 | Batería | Consumo < 5% por hora con timer activo en background. |
| RNF-08 | Almacenamiento | Base de datos < 10 MB para 1000 tareas. |

---

## 11. Accesibilidad

| Característica | Implementación |
|----------------|----------------|
| **Screen Reader** | Soporte completo para TalkBack (Android) y VoiceOver (iOS) |
| **Tamaño de texto** | Respeta configuración del sistema (hasta 200%) |
| **Contraste** | Ratios WCAG AA (4.5:1 para texto normal) |
| **Navegación por teclado** | Soporte para tablets con teclado físico |
| **Modo alto contraste** | Opción en configuración (v2.0) |
| **Vibración** | Configurable para usuarios con discapacidad auditiva |

---

## 12. Arquitectura y Almacenamiento

### Estructura de base de datos

**Tabla:** `tasks`

| Campo | Tipo | Restricciones | Descripción |
|--------|------|---------------|-------------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| name | TEXT | NOT NULL, LENGTH(1-50) | Nombre de la tarea |
| start_time | TEXT | NULL | Hora de inicio (ISO 8601) |
| end_time | TEXT | NULL | Hora de fin (ISO 8601) |
| color | TEXT | NOT NULL, DEFAULT '#3BCDFE' | Color hex |
| duration | INTEGER | NOT NULL, CHECK(duration BETWEEN 60 AND 86400) | Duración total (segundos) |
| created_at | TEXT | NOT NULL | Timestamp de creación |
| updated_at | TEXT | NOT NULL | Timestamp de última edición |

**Tabla:** `timer_sessions` (nueva en v2.0)

| Campo | Tipo | Restricciones | Descripción |
|--------|------|---------------|-------------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT | Identificador único |
| task_id | INTEGER | FOREIGN KEY(tasks.id) | Referencia a tarea |
| start_timestamp | TEXT | NOT NULL | Inicio de sesión |
| end_timestamp | TEXT | NULL | Fin de sesión (NULL si activa) |
| elapsed_seconds | INTEGER | DEFAULT 0 | Tiempo transcurrido |
| status | TEXT | CHECK(status IN ('active','paused','completed')) | Estado actual |

### Estructura del proyecto

```
/lib
  /core
    /theme
      - colors.dart
      - text_styles.dart
    /constants
      - app_constants.dart
  /data
    /models
      - task_model.dart
      - timer_session_model.dart
    /repositories
      - task_repository.dart
      - timer_repository.dart
    /database
      - database_helper.dart
  /domain
    /entities
      - task.dart
      - timer_session.dart
    /usecases
      - create_task.dart
      - start_timer.dart
  /presentation
    /providers
      - task_provider.dart
      - timer_provider.dart
    /screens
      - task_list_screen.dart
      - timer_screen.dart
    /widgets
      - task_card.dart
      - circular_progress.dart
      - new_task_modal.dart
  /services
    - volume_button_service.dart
    - notification_service.dart
  main.dart
```

**Patrón arquitectónico:** Clean Architecture + MVVM + Riverpod

---

## 13. Plan de Pruebas

### Pruebas Unitarias

| ID | Componente | Prueba | Resultado esperado |
|----|---------|---------|--------------------|
| UT-01 | TaskModel | Serialización JSON | Conversión bidireccional exitosa |
| UT-02 | TaskRepository | CRUD operations | Todas las operaciones funcionan |
| UT-03 | TimerProvider | Countdown logic | Decrementa 1 segundo correctamente |
| UT-04 | Validaciones | Nombre vacío | Retorna error |
| UT-05 | Validaciones | Duración negativa | Retorna error |

### Pruebas de Integración

| ID | Flujo | Acción | Resultado esperado |
|----|---------|---------|--------------------|
| IT-01 | Crear tarea | Completar modal y guardar | Nueva tarea aparece en lista |
| IT-02 | Iniciar timer | Tocar "Start" o Vol ↑ | Cronómetro inicia y se actualiza |
| IT-03 | Pausar timer | Pulsar Vol ↓ | Cronómetro se detiene sin perder progreso |
| IT-04 | Restaurar sesión | Cerrar y reabrir app | Lista y timer activo se restauran |
| IT-05 | Completar timer | Esperar a 00:00 | Vibración + notificación |
| IT-06 | Background | Minimizar app con timer activo | Timer continúa corriendo |

### Pruebas de Usabilidad

| ID | Objetivo | Métrica | Criterio de éxito |
|----|----------|---------|-------------------|
| UX-01 | Tiempo para crear tarea | Segundos | < 30 segundos |
| UX-02 | Tiempo para iniciar timer | Toques/pasos | ≤ 2 toques |
| UX-03 | Comprensión de controles | % usuarios que entienden Vol ↑/↓ | > 80% |
| UX-04 | Satisfacción general | Escala 1-5 | ≥ 4.0 |

### Pruebas de Rendimiento

| ID | Escenario | Métrica | Límite |
|----|-----------|---------|--------|
| PF-01 | Carga inicial | Tiempo | < 3s |
| PF-02 | Scroll de lista (100 tareas) | FPS | ≥ 60 |
| PF-03 | Actualización de timer | CPU | < 5% |
| PF-04 | Consumo de batería (1 hora) | % | < 5% |
| PF-05 | Tamaño de APK/IPA | MB | < 20 MB |

---

## 14. Requisitos de Entorno

### Desarrollo
* Flutter SDK >= 3.19.0  
* Dart >= 3.3.0  
* Android Studio / VS Code con extensiones de Flutter
* Xcode 15+ (para iOS)

### Producción
* Android SDK 26+ (Android 8.0 Oreo)  
* iOS 15+
* Dispositivos con mínimo 2 GB RAM

**Comandos de ejecución:**
```bash
# Instalar dependencias
flutter pub get

# Ejecutar en modo debug
flutter run

# Ejecutar pruebas
flutter test

# Generar APK
flutter build apk --release

# Generar IPA
flutter build ios --release
```

---

## 15. Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.10
  
  # Database
  sqflite: ^2.3.2
  path_provider: ^2.1.2
  path: ^1.8.3
  
  # UI
  cupertino_icons: ^1.0.6
  
  # Hardware
  volume_controller: ^2.0.7
  vibration: ^1.8.4
  
  # Utils
  intl: ^0.19.0
  uuid: ^4.3.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  mockito: ^5.4.4
  build_runner: ^2.4.8
```

---

## 16. Permisos y Privacidad

### Permisos Requeridos

**Android (AndroidManifest.xml):**
```xml
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

**iOS (Info.plist):**
```xml
<key>UIBackgroundModes</key>
<array>
    <string>processing</string>
</array>
<key>NSUserNotificationsUsageDescription</key>
<string>Necesitamos enviarte notificaciones cuando un timer finalice</string>
```

### Política de Privacidad

✅ **Datos Locales:** Toda la información se almacena únicamente en el dispositivo  
✅ **Sin Rastreo:** No se utilizan herramientas de analytics ni tracking  
✅ **Sin Conexión:** La app funciona 100% offline  
✅ **Sin Cuentas:** No requiere registro ni autenticación  
✅ **Sin Publicidad:** No se muestran anuncios  
✅ **Open Source:** Código disponible para auditoría

---

## 17. Plan de Desarrollo (MVP)

| Sprint | Semana | Entrega | Tareas Clave |
|--------|--------|----------|--------------|
| 1 | 1 | Setup + UI Base | • Configuración del proyecto<br>• Task List Screen<br>• Modal de creación |
| 2 | 2 | Database | • Implementar SQLite<br>• CRUD de tareas<br>• Pruebas de persistencia |
| 3 | 3 | Timer Core | • Lógica de countdown<br>• Controles táctiles<br>• Animaciones |
| 4 | 4 | Hardware Integration | • Control por volumen<br>• Vibración<br>• Pruebas en dispositivos |
| 5 | 5 | Background & Polish | • Foreground service<br>• Restauración de estado<br>• Optimizaciones |
| 6 | 6 | Testing & Release | • QA completo<br>• Corrección de bugs<br>• Preparación para stores |

---

## 18. Riesgos y Mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|--------------|---------|------------|
| Control de volumen varía por fabricante | Alta | Medio | Ofrecer controles táctiles alternativos |
| Timer pierde precisión en background | Media | Alto | Usar timestamps absolutos, no intervalos |
| Consumo excesivo de batería | Media | Alto | Optimizar foreground service, pruebas extensivas |
| Rechazo en App Store | Baja | Alto | Revisar guidelines antes de submit |
| Problemas de rendimiento en dispositivos antiguos | Media | Medio | Establecer requisitos mínimos claros |

---

## 19. Limitaciones del MVP

* Solo una tarea activa a la vez
* Sin sincronización en la nube
* Sin estadísticas ni reportes
* Sin notificaciones programadas
* Sin integración con calendarios
* Sin soporte para widgets
* Sin modo claro (solo dark mode)

---

## 20. Roadmap de Futuras Versiones

### v1.1 (1-2 meses después del lanzamiento)
- [ ] Estadísticas básicas (tiempo total por tarea)
- [ ] Modo claro
- [ ] Sonidos personalizables
- [ ] Exportar datos a CSV

### v1.5 (3-4 meses)
- [ ] Widget para pantalla de inicio
- [ ] Múltiples timers simultáneos
- [ ] Categorías de tareas
- [ ] Gráficos de productividad

### v2.0 (6 meses)
- [ ] Sincronización en la nube (opcional)
- [ ] Compartir reportes
- [ ] Integración con Wear OS / Apple Watch
- [ ] Exportar a PDF
- [ ] Modo Pomodoro integrado

### v3.0 (12 meses)
- [ ] Colaboración en equipos
- [ ] API pública
- [ ] Integración con Notion, Trello, etc.
- [ ] Machine learning para sugerencias

---

## 21. Métricas de Éxito (KPIs)

### Métricas de Producto (3 meses post-lanzamiento)

| Métrica | Objetivo | Medición |
|---------|----------|----------|
| Instalaciones totales | 5,000+ | Google Play Console + App Store Connect |
| Retención día 1 | > 50% | Firebase Analytics |
| Retención día 7 | > 30% | Firebase Analytics |
| Retención día 30 | > 15% | Firebase Analytics |
| Sesiones por usuario/semana | > 10 | Analytics |
| Tiempo promedio de sesión | > 20 min | Analytics |
| Calificación en stores | > 4.0/5 | Reviews |
| Tasa de crashes | < 1% | Crashlytics |

### Métricas Técnicas

| Métrica | Objetivo | Herramienta |
|---------|----------|-------------|
| Cobertura de tests | > 70% | `flutter test --coverage` |
| Tiempo de build | < 5 min | CI/CD logs |
| Tamaño de APK | < 20 MB | Android Studio |
| Velocidad de carga | < 3s | Performance profiler |

---

## 22. Glosario de Términos

| Término | Definición |
|---------|------------|
| **Task** | Actividad con nombre, duración y color asignado que el usuario desea cronometrar |
| **Timer** | Cronómetro de cuenta regresiva asociado a una tarea específica |
| **Session** | Período de tiempo continuo desde que un timer se inicia hasta que se completa o detiene |
| **Background Mode** | Estado en que la app continúa ejecutando el timer aunque no esté visible |
| **Foreground Service** | Servicio de Android que mantiene la app en ejecución prioritaria |
| **MVP** | Minimum Viable Product - versión con funcionalidades esenciales |
| **Riverpod** | Librería de gestión de estado reactivo para Flutter |
| **SQLite** | Base de datos embebida para almacenamiento local |
| **FAB** | Floating Action Button - botón flotante de acción |
| **Pomodoro** | Técnica de gestión de tiempo (25 min trabajo + 5 min descanso) |

---

## 23. Fuera del Alcance (v1.0)

### No Incluido en MVP

❌ **Sincronización Multi-dispositivo**  
_Razón:_ Requiere backend y autenticación (complejidad alta)

❌ **Colaboración en Tiempo Real**  
_Razón:_ Fuera del objetivo de privacidad local

❌ **Integración con Asistentes de Voz**  
_Razón:_ Requiere permisos adicionales y complejidad

❌ **Gamificación (logros, puntos, niveles)**  
_Razón:_ Añade complejidad UX para MVP

❌ **Modo Pomodoro Automático**  
_Razón:_ Se puede lograr manualmente en v1.0

❌ **Reportes Avanzados (PDF, gráficos)**  
_Razón:_ Planificado para v1.5

❌ **Integración con Calendarios**  
_Razón:_ Requiere permisos y sincronización

❌ **Soporte para Tablets/Desktop**  
_Razón:_ MVP enfocado en móviles

❌ **Temas Personalizables**  
_Razón:_ Solo dark mode en v1.0

❌ **Importar/Exportar Backups**  
_Razón:_ Planificado para v1.1

---

## 24. Referencias de Diseño

### Paleta de Colores

```dart
// lib/core/theme/colors.dart
class AppColors {
  static const Color darkBlue = Color(0xFF0A0E2A);
  static const Color lightBlue = Color(0xFF3BCDFE);
  static const Color accentBlue = Color(0xFF1E90FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF6B7280);
  
  // Task Colors (seleccionables)
  static const List<Color> taskColors = [
    Color(0xFF3BCDFE), // Azul claro
    Color(0xFF6366F1), // Índigo
    Color(0xFF8B5CF6), // Púrpura
    Color(0xFFEC4899), // Rosa
    Color(0xFFEF4444), // Rojo
  ];
}
```

### Tipografía

* **Heading:** SF Pro Display / Roboto Bold (24sp)
* **Body:** SF Pro Text / Roboto Regular (16sp)
* **Caption:** SF Pro Text / Roboto Medium (14sp)
* **Timer Display:** SF Pro Display / Roboto Mono (48sp)

### Mockups

_Pendiente: Agregar enlaces a Figma o capturas de pantalla_

```
/designs
  - task_list_screen.png
  - timer_screen_idle.png
  - timer_screen_active.png
  - new_task_modal.png
```

---

## 25. Estrategia de Lanzamiento

### Fase 1: Alpha Testing (Semana 1-2)
* **Participantes:** 5-10 testers internos
* **Objetivo:** Detectar bugs críticos
* **Canales:** TestFlight (iOS) + Firebase App Distribution (Android)

### Fase 2: Beta Testing (Semana 3-6)
* **Participantes:** 50-100 usuarios externos
* **Objetivo:** Validar UX y detectar edge cases
* **Canales:** Google Play Beta Track + TestFlight Public Link

### Fase 3: Soft Launch (Semana 7)
* **Regiones:** 2-3 países de habla hispana
* **Objetivo:** Validar métricas antes del lanzamiento global
* **Estrategia:** Sin promoción activa, SEO orgánico

### Fase 4: Lanzamiento Global (Semana 8+)
* **Regiones:** Todos los mercados disponibles
* **Promoción:** 
  - Post en redes sociales
  - Product Hunt launch
  - Posts en comunidades de productividad
  - Email a beta testers

---

## 26. Contacto y Soporte

**Desarrollador:** JuanP  
**GitHub:** [@JuanPMorales](https://github.com/JuanPMorales)  
**Email de Soporte:** _[Pendiente]_  
**Repositorio:** _[Pendiente - agregar al publicar]_

### Canales de Soporte
* **Bugs:** GitHub Issues
* **Preguntas:** GitHub Discussions
* **Features:** GitHub Discussions > Ideas

---

## 27. Entregables

### Código
- [ ] Repositorio Git con código fuente
- [ ] README.md con instrucciones de instalación
- [ ] Documentación de API interna
- [ ] Scripts de deployment

### Documentación
- [x] PRD completo (este documento)
- [ ] Guía de contribución
- [ ] Changelog
- [ ] Arquitectura técnica detallada

### Diseño
- [ ] Archivo Figma con todos los screens
- [ ] Assets exportados (iconos, splash screen)
- [ ] Guía de estilo visual

### Testing
- [ ] Suite de tests unitarios (>70% cobertura)
- [ ] Tests de integración
- [ ] Reporte de QA

### Distribución
- [ ] APK firmado para Google Play
- [ ] IPA firmado para App Store
- [ ] Screenshots para stores (5 por plataforma)
- [ ] Descripción de store en ES/EN
- [ ] Privacy Policy publicada

---

## 28. Licencia y Créditos

### Licencia
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
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

### Créditos
* **Diseño y Desarrollo:** JuanP
* **Testing:** _[Agregar testers beta]_
* **Inspiración:** Forest App, Toggl, Focus To-Do

---

## 29. Historial de Versiones del PRD

| Versión | Fecha | Cambios |
|---------|-------|---------|
| 1.0 | 2025-01-11 | Versión inicial |
| 1.1 | 2025-11-11 | Primera revisión con estructura básica |
| 2.0 | 2025-11-11 | **Versión expandida**: escenarios de uso, manejo de interrupciones, métricas de éxito, glosario, roadmap detallado, estrategia de lanzamiento |

---

## 30. Aprobaciones

| Rol | Nombre | Firma | Fecha |
|-----|--------|-------|-------|
| Product Owner | JuanP | ✓ | 2025-11-11 |
| Tech Lead | _[Pendiente]_ | | |
| QA Lead | _[Pendiente]_ | | |
| UX Designer | _[Pendiente]_ | | |

---

**📌 Nota Final:**  
Este PRD es un documento vivo y será actualizado conforme el proyecto evolucione. Todas las decisiones de producto deben estar alineadas con este documento o requerir una actualización formal del mismo.

**✅ Documento aprobado para iniciar desarrollo - Sprint 1**

---

_Generado con ❤️ por JuanP | Última actualización: 2025-11-11_
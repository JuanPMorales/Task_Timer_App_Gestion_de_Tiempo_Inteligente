# 🕐 Task Timer App

> **Aplicación móvil de gestión de tareas con temporizador integrado**  
> Flutter 3.19+ | Riverpod | SQLite | Clean Architecture

[![Flutter](https://img.shields.io/badge/Flutter-3.35.7-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![CI](https://github.com/JuanPMorales/Task_Timer_App_Gestion_de_Tiempo_Inteligente/actions/workflows/ci.yml/badge.svg)](https://github.com/JuanPMorales/Task_Timer_App_Gestion_de_Tiempo_Inteligente/actions/workflows/ci.yml)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

---

## 📖 Descripción

**Task Timer App** es una aplicación móvil diseñada para maximizar la productividad mediante la gestión de tareas con temporizador integrado. Permite crear, organizar y ejecutar tareas con control de tiempo preciso, ideal para técnicas como Pomodoro, Time Blocking y gestión de proyectos.

### ✨ Características Principales

- ⏱️ **Temporizador Inteligente**: Control preciso con inicio/pausa por botones de volumen
- 📝 **Gestión de Tareas**: CRUD completo con colores personalizables
- 💾 **Persistencia Local**: SQLite para almacenamiento offline
- 🎨 **Diseño Minimalista**: Dark mode con degradados azules
- 📱 **Background Support**: El timer continúa funcionando con app cerrada
- 🔔 **Notificaciones**: Alertas visuales y vibraciones al completar
- ♿ **Accesible**: Cumple WCAG 2.1 AA

---

## 🚀 Quick Start

### Prerequisitos

- Flutter SDK ≥ 3.19.0
- Dart SDK ≥ 3.3.0
- Android Studio / VS Code
- Android API 33+ o iOS 16+

### Instalación

```bash
# Clonar el repositorio
git clone https://github.com/JuanPMorales/Task_Timer_App_Gestion_de_Tiempo_Inteligente.git
cd Task_Timer_App_Gestion_de_Tiempo_Inteligente

# Instalar dependencias
flutter pub get

# Ejecutar en dispositivo/emulador
flutter run
```

### Desarrollo

```bash
# Ejecutar tests
flutter test

# Generar cobertura
flutter test --coverage

# Análisis estático
flutter analyze

# Formatear código
flutter format .
```

---

## 🏗️ Arquitectura

Este proyecto sigue **Clean Architecture** con separación en capas:

```
lib/
├── core/           # Utilidades, temas, constantes
├── data/           # Modelos, repositories, database
├── domain/         # Entidades, use cases, interfaces
├── presentation/   # UI, providers, widgets
└── services/       # Integraciones nativas (volumen, vibración)
```

**Stack Técnico:**
- **UI Framework**: Flutter 3.19+
- **State Management**: Riverpod 2.5+
- **Database**: SQLite (sqflite)
- **Architecture**: Clean Architecture + MVVM
- **Testing**: Unit, Widget, Integration tests

📚 **Documentación completa**: [ARCHITECTURE.md](ARCHITECTURE.md)

---

## 📱 Capturas de Pantalla

_Próximamente: Screenshots de la app funcionando_

---

## 🧪 Testing

El proyecto mantiene una cobertura de tests ≥ 90%:

- **Unit Tests**: Lógica de negocio y repositorios
- **Widget Tests**: Componentes de UI
- **Integration Tests**: Flujos completos de usuario

```bash
# Ejecutar todos los tests
flutter test

# Tests específicos
flutter test test/domain/usecases/
flutter test test/presentation/widgets/
```

---

## 📦 Dependencias Principales

| Paquete | Versión | Propósito |
|---------|---------|-----------|
| `flutter_riverpod` | ^2.5.0 | State management |
| `sqflite` | ^2.3.0 | Base de datos local |
| `path_provider` | ^2.1.0 | Rutas del sistema |
| `vibration` | ^1.8.0 | Feedback háptico |
| `volume_controller` | ^2.0.0 | Control de volumen |

Ver `pubspec.yaml` para lista completa.

---

## 🗂️ Estructura de Ramas (GitFlow)

- **`main`**: Producción (código estable, releases)
- **`develop`**: Integración de desarrollo (rama base)
- **`feature/*`**: Nuevas funcionalidades
- **`release/*`**: Preparación de versiones
- **`hotfix/*`**: Correcciones urgentes en producción

📚 **Ver documentación completa**: [GITFLOW.md](GITFLOW.md)

---

## 🤝 Contribución

Las contribuciones son bienvenidas. Seguimos **GitFlow** y **Conventional Commits**:

1. Fork el proyecto
2. Crea una rama feature desde `develop`: `git checkout -b feature/nueva-funcionalidad develop`
3. Commit con formato convencional: `git commit -m 'feat(scope): descripción'`
4. Push a tu fork: `git push origin feature/nueva-funcionalidad`
5. Abre un Pull Request hacia `develop`

Ver [CONTRIBUTING.md](CONTRIBUTING.md) y [GITFLOW.md](GITFLOW.md) para más detalles.

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](LICENSE) para más información.

---

## 👨‍💻 Autor

**Juan Pablo Morales**
- Email: j.5.2.0.p.1.3.m@gmail.com
- GitHub: [@JuanPMorales](https://github.com/JuanPMorales)

---

## 🙏 Agradecimientos

- Equipo de Flutter por el excelente framework
- Comunidad de Riverpod por el robusto state management
- Todos los colaboradores del proyecto

---

## 📚 Documentación Adicional

- [Product Requirements Document (PRD)](task_timer_prd.md)
- [MVP Técnico](task_timer_mvp_tecnico.md)
- [Desglose de Tareas](TASK_BREAKDOWN.md)
- [Reglas para IA](IA_RULES.md)

---

**Estado del Proyecto**: 🚧 En Desarrollo  
**Versión Actual**: 0.1.0-dev  
**Última Actualización**: Noviembre 2025

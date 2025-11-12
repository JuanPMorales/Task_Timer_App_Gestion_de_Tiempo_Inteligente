# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir a **Task Timer App**! Este documento proporciona directrices para contribuir al proyecto.

> 📚 **Documentación completa**: Ver [docs/README.md](docs/README.md) para índice de toda la documentación

---

## 📋 Tabla de Contenidos

1. [Código de Conducta](#código-de-conducta)
2. [Cómo Contribuir](#cómo-contribuir)
3. [Proceso de Desarrollo](#proceso-de-desarrollo)
4. [Estándares de Código](#estándares-de-código)
5. [Commits y Mensajes](#commits-y-mensajes)
6. [Pull Requests](#pull-requests)
7. [Testing](#testing)
8. [Documentación Relacionada](#documentación-relacionada)

---

## 📜 Código de Conducta

Este proyecto adhiere a un código de conducta que todos los contribuidores deben seguir:

- **Respeto**: Trata a todos con respeto y empatía
- **Inclusividad**: Sé acogedor con personas de todos los orígenes
- **Profesionalismo**: Mantén discusiones constructivas y profesionales
- **Colaboración**: Ayuda a otros y acepta críticas constructivas

---

## 🚀 Cómo Contribuir

### Reportar Bugs

1. Verifica que el bug no haya sido reportado ya en [Issues](https://github.com/JuanPMorales/task-timer-app/issues)
2. Si es nuevo, crea un issue con la plantilla de bug
3. Incluye:
   - Descripción clara del problema
   - Pasos para reproducirlo
   - Comportamiento esperado vs actual
   - Screenshots si aplica
   - Versión de Flutter y dispositivo

### Sugerir Mejoras

1. Abre un issue con la plantilla de feature request
2. Describe claramente:
   - El problema que resuelve
   - La solución propuesta
   - Alternativas consideradas
   - Impacto esperado

### Contribuir Código

1. **Fork** el repositorio
2. **Clone** tu fork localmente
3. Crea una **rama** desde `dev`
4. Haz tus **cambios**
5. Escribe/actualiza **tests**
6. Envía un **Pull Request**

---

## 🔄 Proceso de Desarrollo

### Estructura de Ramas

```
main              # Código en producción (solo merges desde dev)
  └── dev         # Desarrollo activo (rama base para features)
       ├── feature/task-crud
       ├── feature/timer-logic
       └── feature/background-service
  └── hotfix/*    # Correcciones urgentes desde main
```

### Flujo de Trabajo

1. **Sincroniza** tu fork con upstream:
   ```bash
   git remote add upstream https://github.com/JuanPMorales/task-timer-app.git
   git fetch upstream
   git checkout dev
   git merge upstream/dev
   ```

2. **Crea** una rama feature:
   ```bash
   git checkout -b feature/nombre-descriptivo
   ```

3. **Desarrolla** siguiendo los estándares (ver abajo)

4. **Commit** con mensajes descriptivos (ver formato)

5. **Push** a tu fork:
   ```bash
   git push origin feature/nombre-descriptivo
   ```

6. **Abre** un Pull Request a `dev`

---

## 💻 Estándares de Código

### Arquitectura

- Sigue **Clean Architecture**
- Separa capas: `domain` → `data` → `presentation`
- Usa **Riverpod** para state management
- Repositorios deben implementar interfaces del dominio

### Convenciones de Código

#### Nomenclatura

```dart
// Clases: PascalCase
class TaskRepository {}

// Variables y métodos: camelCase
String userName;
void fetchTasks() {}

// Constantes: lowerCamelCase con 'k' prefix
const kDefaultTimeout = 30;

// Archivos: snake_case
task_repository.dart
timer_screen.dart
```

#### Organización de Archivos

```dart
// 1. Imports de Dart/Flutter
import 'dart:async';
import 'package:flutter/material.dart';

// 2. Imports de paquetes externos
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';

// 3. Imports del proyecto
import 'package:task_timer/domain/entities/task.dart';
import 'package:task_timer/core/utils/formatters.dart';
```

#### Documentación

```dart
/// Repositorio para gestionar operaciones CRUD de tareas.
///
/// Implementa [TaskRepository] usando SQLite como fuente de datos.
/// Proporciona streams reactivos para cambios en tiempo real.
class TaskRepositoryImpl implements TaskRepository {
  /// Crea una nueva tarea en la base de datos.
  ///
  /// Lanza [DatabaseException] si hay error de escritura.
  /// Retorna el ID de la tarea creada.
  @override
  Future<int> createTask(Task task) async {
    // Implementación
  }
}
```

### Formateo

```bash
# Formatear código automáticamente
flutter format .

# Verificar antes de commit
flutter format --dry-run --set-exit-if-changed .
```

### Análisis Estático

```bash
# Ejecutar análisis
flutter analyze

# No debe haber errores ni warnings
```

---

## 📝 Commits y Mensajes

### Formato de Commits

Usamos **Conventional Commits**:

```
<tipo>(<scope>): <descripción corta>

<cuerpo opcional>

<footer opcional>
```

#### Tipos

- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `docs`: Cambios en documentación
- `style`: Formateo, espacios (sin cambios de código)
- `refactor`: Refactorización (sin cambios funcionales)
- `test`: Añadir/modificar tests
- `chore`: Tareas de mantenimiento (deps, config)
- `perf`: Mejoras de performance

#### Ejemplos

```bash
feat(task): añadir validación de nombre de tarea

fix(timer): corregir cálculo de tiempo restante al pausar

docs(readme): actualizar instrucciones de instalación

test(timer): añadir tests para TimerStateNotifier

refactor(database): simplificar queries de SQLite
```

---

## 🔀 Pull Requests

### Checklist Pre-PR

Antes de abrir un PR, verifica:

- [ ] Código formateado (`flutter format .`)
- [ ] Sin errores de análisis (`flutter analyze`)
- [ ] Tests pasando (`flutter test`)
- [ ] Cobertura ≥ 90% en nuevo código
- [ ] Documentación actualizada
- [ ] CHANGELOG.md actualizado
- [ ] Commits siguen formato convencional

### Plantilla de PR

```markdown
## Descripción
Breve descripción de los cambios.

## Tipo de Cambio
- [ ] Bug fix
- [ ] Nueva funcionalidad
- [ ] Breaking change
- [ ] Documentación

## Tareas Relacionadas
Cierra #123
Relacionado con #456

## Tests
- [ ] Unit tests añadidos/actualizados
- [ ] Widget tests añadidos/actualizados
- [ ] Integration tests añadidos/actualizados

## Screenshots (si aplica)
[Añadir capturas de pantalla]

## Checklist
- [ ] Código formateado
- [ ] Tests pasando
- [ ] Documentación actualizada
```

### Proceso de Revisión

1. **CI/CD** debe pasar (lint + tests)
2. Al menos **1 aprobación** de maintainer
3. **No conflictos** con rama base
4. **Squash merge** al integrar

---

## 🧪 Testing

### Cobertura Requerida

- **Unit tests**: ≥ 90% para lógica de negocio
- **Widget tests**: Componentes críticos
- **Integration tests**: Flujos principales

### Ejecutar Tests

```bash
# Todos los tests
flutter test

# Con cobertura
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Escribir Tests

```dart
// test/domain/usecases/create_task_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('CreateTaskUseCase', () {
    late CreateTaskUseCase useCase;
    late MockTaskRepository mockRepo;

    setUp(() {
      mockRepo = MockTaskRepository();
      useCase = CreateTaskUseCase(mockRepo);
    });

    test('debe crear tarea exitosamente', () async {
      // Arrange
      final task = Task(name: 'Test', duration: 25);
      when(mockRepo.create(task)).thenAnswer((_) async => 1);

      // Act
      final result = await useCase(task);

      // Assert
      expect(result, 1);
      verify(mockRepo.create(task)).called(1);
    });
  });
}
```

---

## 🙋 ¿Preguntas?

Si tienes dudas:

1. Revisa la [documentación](README.md)
2. Busca en [Issues existentes](https://github.com/JuanPMorales/task-timer-app/issues)
3. Abre un nuevo issue con tag `question`

---

## 📚 Recursos Adicionales

- [Flutter Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Clean Architecture en Flutter](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Riverpod Documentation](https://riverpod.dev/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## 📖 Documentación Relacionada

### Documentación del Proyecto
- **[📚 Índice Principal](docs/README.md)** - Navegación completa
- [GitFlow Strategy](docs/GITFLOW.md) - Workflow de branches
- [Linting Guide](docs/LINTING.md) - Estándares de código
- [CI/CD Documentation](docs/CI_CD.md) - Pipelines y workflows
- [Dependencies Guide](docs/DEPENDENCIES.md) - Paquetes del proyecto
- [Task Breakdown](docs/TASK_BREAKDOWN.md) - Tareas del proyecto

### Progreso de Desarrollo
- [docs/progress/](docs/progress/) - Resúmenes de cada tarea completada

---

¡Gracias por contribuir! 🎉

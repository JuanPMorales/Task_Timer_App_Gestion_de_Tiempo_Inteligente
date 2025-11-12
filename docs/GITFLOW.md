# 🌿 GitFlow Workflow - Task Timer App

## Estructura de Ramas

Este proyecto sigue **GitFlow**, un modelo de ramificación exitoso para Git.

```
main (master)          ← Producción (código estable en live)
  ↑
release/*             ← Preparación de releases (QA, fixes menores)
  ↑
develop               ← Integración de desarrollo (rama principal de trabajo)
  ↑
feature/*             ← Nuevas funcionalidades
  ↑
hotfix/*              ← Correcciones urgentes en producción
```

---

## 📋 Descripción de Ramas

### 🎯 **main** (anteriormente master)
- **Propósito**: Código en producción
- **Protección**: Solo merge desde `release/*` o `hotfix/*`
- **Deploy**: Automático a producción al hacer merge
- **Tags**: Cada merge recibe un tag de versión (v1.0.0)

### 🚀 **develop**
- **Propósito**: Rama principal de desarrollo
- **Base para**: Todas las ramas `feature/*`
- **Integración**: Recibe merges de features completadas
- **Estabilidad**: Siempre debe estar en estado funcional
- **Deploy**: A entorno de desarrollo/staging

### ✨ **feature/***
- **Propósito**: Desarrollo de nuevas funcionalidades
- **Naming**: `feature/nombre-descriptivo` (ej: `feature/timer-logic`)
- **Base**: Se crea desde `develop`
- **Merge**: Hacia `develop` cuando está completa
- **Tiempo de vida**: Corto (días a semanas)
- **Eliminación**: Se borra después del merge

**Ejemplos:**
- `feature/task-crud`
- `feature/timer-background-service`
- `feature/volume-button-controls`

### 🔧 **release/***
- **Propósito**: Preparar nueva versión de producción
- **Naming**: `release/v1.0.0`
- **Base**: Se crea desde `develop`
- **Permite**: Solo bug fixes, ajustes de versión, documentación
- **Merge**: Hacia `main` Y `develop`
- **Tag**: Se crea tag de versión en `main`
- **Eliminación**: Se borra después del merge

**Proceso:**
1. Crear desde `develop`: `git checkout -b release/v1.0.0 develop`
2. Actualizar versión en `pubspec.yaml`
3. Ejecutar QA completo
4. Fixes menores si es necesario
5. Merge a `main` con tag
6. Merge a `develop` para sincronizar fixes

### 🚨 **hotfix/***
- **Propósito**: Corrección urgente en producción
- **Naming**: `hotfix/descripcion-bug` (ej: `hotfix/timer-crash-on-pause`)
- **Base**: Se crea desde `main`
- **Merge**: Hacia `main` Y `develop`
- **Versión**: Incrementa patch (1.0.0 → 1.0.1)
- **Urgencia**: Para bugs críticos que no pueden esperar al próximo release

**Proceso:**
1. Crear desde `main`: `git checkout -b hotfix/nombre-bug main`
2. Fix el bug
3. Actualizar versión (patch)
4. Merge a `main` con tag
5. Merge a `develop`

---

## 🔄 Flujos de Trabajo

### Desarrollar una nueva Feature

```bash
# 1. Asegurarse de tener develop actualizado
git checkout develop
git pull origin develop

# 2. Crear rama feature
git checkout -b feature/task-crud

# 3. Desarrollar (commits frecuentes)
git add .
git commit -m "feat(task): implementar CRUD de tareas"
git commit -m "test(task): añadir unit tests para TaskRepository"

# 4. Mantener actualizado con develop
git checkout develop
git pull origin develop
git checkout feature/task-crud
git merge develop  # o rebase: git rebase develop

# 5. Push de la feature
git push origin feature/task-crud

# 6. Abrir Pull Request a develop en GitHub
# (hacer code review, pasar CI/CD)

# 7. Después del merge, limpiar
git checkout develop
git pull origin develop
git branch -d feature/task-crud
git push origin --delete feature/task-crud
```

### Crear un Release

```bash
# 1. Crear rama release desde develop
git checkout develop
git pull origin develop
git checkout -b release/v1.0.0

# 2. Actualizar versión en pubspec.yaml
# version: 1.0.0+1

# 3. Actualizar CHANGELOG.md
# Documentar todos los cambios

# 4. Commit de versión
git commit -am "chore(release): preparar versión 1.0.0"

# 5. Ejecutar QA completo
flutter test
flutter analyze

# 6. Si hay bugs menores, fixearlos aquí
git commit -am "fix(release): corregir typo en UI"

# 7. Merge a main
git checkout main
git merge --no-ff release/v1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin main --tags

# 8. Merge a develop (para sincronizar fixes)
git checkout develop
git merge --no-ff release/v1.0.0
git push origin develop

# 9. Eliminar rama release
git branch -d release/v1.0.0
git push origin --delete release/v1.0.0
```

### Crear un Hotfix

```bash
# 1. Crear rama hotfix desde main
git checkout main
git pull origin main
git checkout -b hotfix/timer-crash-on-pause

# 2. Fixear el bug
git commit -am "fix(timer): corregir crash al pausar timer"

# 3. Actualizar versión (patch: 1.0.0 → 1.0.1)
# pubspec.yaml: version: 1.0.1+2

# 4. Commit de versión
git commit -am "chore(hotfix): bump version to 1.0.1"

# 5. Merge a main
git checkout main
git merge --no-ff hotfix/timer-crash-on-pause
git tag -a v1.0.1 -m "Hotfix version 1.0.1"
git push origin main --tags

# 6. Merge a develop
git checkout develop
git merge --no-ff hotfix/timer-crash-on-pause
git push origin develop

# 7. Eliminar rama hotfix
git branch -d hotfix/timer-crash-on-pause
git push origin --delete hotfix/timer-crash-on-pause
```

---

## 📏 Convenciones de Commits (Conventional Commits)

### Formato

```
<tipo>(<scope>): <descripción>

[cuerpo opcional]

[footer opcional]
```

### Tipos

- **feat**: Nueva funcionalidad
- **fix**: Corrección de bug
- **docs**: Cambios en documentación
- **style**: Formateo, espacios (sin cambios de lógica)
- **refactor**: Refactorización de código
- **perf**: Mejoras de performance
- **test**: Añadir o modificar tests
- **build**: Cambios en build system o dependencias
- **ci**: Cambios en CI/CD
- **chore**: Tareas de mantenimiento
- **revert**: Revertir commit previo

### Scopes (Módulos)

- `task`: Módulo de tareas
- `timer`: Módulo de temporizador
- `database`: Persistencia SQLite
- `ui`: Interfaz de usuario
- `core`: Utilidades core
- `service`: Servicios nativos
- `test`: Testing
- `docs`: Documentación
- `config`: Configuración

### Ejemplos

```bash
# Feature
git commit -m "feat(task): implementar creación de tareas con validación"

# Bug fix
git commit -m "fix(timer): corregir cálculo de tiempo al reanudar"

# Multiple scopes
git commit -m "feat(task,ui): añadir selector de color en modal de tarea"

# Breaking change
git commit -m "feat(database)!: migrar a nueva estructura de tablas

BREAKING CHANGE: La estructura de la tabla tasks cambió.
Se requiere migración de datos."

# Con body y footer
git commit -m "fix(timer): prevenir múltiples inicios simultáneos

Se añadió validación de estado antes de iniciar timer.
Fixes estado inconsistente en concurrencia.

Closes #42"
```

---

## 🛡️ Protección de Ramas

### GitHub Branch Protection Rules

**Para `main`:**
- ✅ Require pull request before merging
- ✅ Require approvals: 1
- ✅ Require status checks to pass (CI/CD)
- ✅ Require branches to be up to date
- ✅ Include administrators
- ✅ Restrict who can push (solo maintainers)

**Para `develop`:**
- ✅ Require pull request before merging
- ✅ Require status checks to pass
- ✅ Require branches to be up to date

---

## 📊 Ejemplo de Historia de Git

```
* f2cb780 (tag: v1.0.0, main) chore(release): preparar versión 1.0.0
|\
| * a3d4e21 (release/v1.0.0) fix(release): corregir typo en UI
|/
* b5f7c32 (develop) feat(timer): añadir notificaciones al completar
|\
| * c8e9d43 (feature/timer-notifications) test(timer): tests para notificaciones
| * d1a2b54 feat(timer): implementar servicio de notificaciones
|/
* e3f4g65 feat(task): CRUD de tareas completo
|\
| * f5g6h76 (feature/task-crud) test(task): integration tests
| * g7h8i87 feat(task): UI para gestión de tareas
| * h9i0j98 feat(task): repositorio y use cases
|/
* i1j2k09 chore: configuración inicial del proyecto
```

---

## 🔍 Comandos Útiles

```bash
# Ver todas las ramas
git branch -a

# Ver ramas remotas
git branch -r

# Ver último commit de cada rama
git branch -v

# Eliminar rama local
git branch -d nombre-rama

# Eliminar rama remota
git push origin --delete nombre-rama

# Ver historia gráfica
git log --oneline --graph --all

# Ver commits de una rama específica
git log develop..feature/nombre

# Sincronizar con remoto
git fetch --all --prune
```

---

## 📚 Referencias

- [GitFlow Original](https://nvie.com/posts/a-successful-git-branching-model/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

---

**Última actualización**: 2025-11-11

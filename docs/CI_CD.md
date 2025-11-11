# 🚀 CI/CD Pipeline - Task Timer App

## Descripción General

Este proyecto utiliza **GitHub Actions** para automatizar testing, análisis de código y deployment.

---

## 📊 Workflows Configurados

### 1. **CI - Lint & Test** (`ci.yml`)

**Trigger:**
- Push a `main` o `develop`
- Pull requests a `main` o `develop`
- Manual (`workflow_dispatch`)

**Jobs:**

#### 📝 `analyze`
- Verifica formateo de código
- Ejecuta `flutter analyze` con warnings fatales
- Comprueba dependencias desactualizadas

#### 🧪 `test`
- Ejecuta tests unitarios con cobertura
- Genera reporte de coverage
- Sube cobertura a Codecov

#### 🏗️ `build-android`
- Build de APK release (solo en push a `main`)
- Sube artifact con retención de 30 días

#### 🌐 `build-web`
- Build web (solo en push a `develop`)
- Sube artifact con retención de 7 días

---

### 2. **PR Validation** (`pr-validation.yml`)

**Trigger:**
- Pull requests abiertos/actualizados a `main` o `develop`

**Jobs:**

#### ✅ `pr-check`
- Valida formato de commits (Conventional Commits)
- Ejecuta lint y análisis
- Corre tests con coverage
- Genera reporte de cobertura
- Comenta en el PR con resultados

#### 📏 `size-label`
- Etiqueta PRs por tamaño:
  - `size/xs`: ≤ 10 líneas
  - `size/s`: ≤ 100 líneas
  - `size/m`: ≤ 500 líneas
  - `size/l`: ≤ 1000 líneas
  - `size/xl`: > 1000 líneas

---

### 3. **Auto Labeling** (`labeling.yml`)

**Trigger:**
- PRs abiertos/sincronizados
- Issues abiertos

**Jobs:**

#### 🏷️ Etiquetado por rama
- `feature/*` → `type: feature`
- `fix/*` → `type: bug`
- `hotfix/*` → `type: hotfix`, `priority: high`
- `docs/*` → `type: documentation`
- `refactor/*` → `type: refactor`
- `test/*` → `type: test`

#### 🏷️ Etiquetado por archivos
Ver configuración en `.github/labeler.yml`

---

## 🏷️ Sistema de Etiquetas

### Por Tipo
- `type: feature` - Nueva funcionalidad
- `type: bug` - Corrección de bug
- `type: hotfix` - Corrección urgente
- `type: documentation` - Documentación
- `type: refactor` - Refactorización
- `type: test` - Tests
- `type: question` - Pregunta

### Por Área
- `area: core` - Código core
- `area: data` - Capa de datos
- `area: domain` - Capa de dominio
- `area: presentation` - Capa de presentación
- `area: services` - Servicios nativos
- `area: tests` - Tests
- `area: docs` - Documentación
- `area: ci/cd` - CI/CD
- `area: config` - Configuración

### Por Estado
- `status: pending` - Pendiente de revisión
- `status: in-progress` - En progreso
- `status: blocked` - Bloqueado
- `status: ready` - Listo para merge

### Por Prioridad
- `priority: low` - Baja prioridad
- `priority: medium` - Media prioridad
- `priority: high` - Alta prioridad
- `priority: critical` - Crítico

### Por Tamaño
- `size/xs`, `size/s`, `size/m`, `size/l`, `size/xl`

### Especiales
- `dependencies` - Actualización de dependencias
- `automated` - Generado automáticamente
- `good first issue` - Bueno para principiantes
- `help wanted` - Se necesita ayuda

---

## 🔒 Branch Protection Rules

### Para `main`:
```yaml
required_reviews: 1
required_status_checks:
  - "Análisis Estático"
  - "Tests Unitarios"
dismiss_stale_reviews: true
require_code_owner_reviews: false
require_signed_commits: false
```

### Para `develop`:
```yaml
required_reviews: 0
required_status_checks:
  - "Análisis Estático"
  - "Tests Unitarios"
dismiss_stale_reviews: false
```

---

## 📋 Configuración en GitHub

### 1. Secrets Necesarios

Ve a **Settings → Secrets and variables → Actions** y configura:

#### Opcional (para coverage):
- `CODECOV_TOKEN` - Token de Codecov para reportes de cobertura

#### Para deployment futuro:
- `ANDROID_KEYSTORE` - Keystore codificado en base64
- `KEYSTORE_PASSWORD` - Contraseña del keystore
- `KEY_ALIAS` - Alias de la llave
- `KEY_PASSWORD` - Contraseña de la llave

### 2. Habilitar Branch Protection

1. Ve a **Settings → Branches**
2. Click en **Add rule**
3. Branch name pattern: `main`
4. Configura:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
5. Selecciona checks requeridos:
   - Análisis Estático
   - Tests Unitarios
6. Click **Create**

Repite para `develop` con menos restricciones.

### 3. Habilitar Dependabot

Ya está configurado en `.github/dependabot.yml`. Dependabot creará PRs automáticamente para actualizar dependencias.

---

## 🚀 Uso de Workflows

### Ejecutar CI Manualmente

```bash
# Ir a GitHub → Actions → CI - Lint & Test → Run workflow
```

O vía CLI:
```bash
gh workflow run ci.yml
```

### Ver Logs de Workflow

```bash
# En GitHub: Actions → selecciona workflow → selecciona run
```

O vía CLI:
```bash
gh run list
gh run view <run-id>
```

---

## 📊 Badges para README

Agrega estos badges al README.md:

```markdown
[![CI](https://github.com/JuanPMorales/Task_Timer_App_Gestion_de_Tiempo_Inteligente/actions/workflows/ci.yml/badge.svg)](https://github.com/JuanPMorales/Task_Timer_App_Gestion_de_Tiempo_Inteligente/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/JuanPMorales/Task_Timer_App_Gestion_de_Tiempo_Inteligente/branch/main/graph/badge.svg)](https://codecov.io/gh/JuanPMorales/Task_Timer_App_Gestion_de_Tiempo_Inteligente)
```

---

## 🔍 Troubleshooting

### CI falla en `flutter analyze`
- Ejecuta localmente: `flutter analyze`
- Corrige warnings y errores
- Commit y push

### Tests fallan en CI pero pasan localmente
- Verifica versión de Flutter en workflow
- Ejecuta `flutter clean && flutter pub get`
- Asegúrate de que no haya dependencias específicas de plataforma

### Build APK falla
- Verifica configuración de Android en `android/`
- Asegúrate de que `pubspec.yaml` tenga versión correcta
- Revisa logs completos en GitHub Actions

---

## 📚 Referencias

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/cd)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Última actualización**: 2025-11-11

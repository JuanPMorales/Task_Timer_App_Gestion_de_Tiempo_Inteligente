/// Punto de entrada de Task Timer App
///
/// Aplicación móvil para gestión de tiempo con cronómetros personalizados.
/// Desarrollada siguiendo Clean Architecture + MVVM + Riverpod.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_timer/core/constants/app_constants.dart';
import 'package:task_timer/core/theme/app_theme.dart';
import 'package:task_timer/l10n/app_localizations.dart';

/// Función principal de la aplicación
void main() {
  // Inicialización de la aplicación
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(Sprint-2): Inicializar servicios (base de datos, providers, etc.)

  // Envolver la aplicación con ProviderScope para habilitar Riverpod
  runApp(
    const ProviderScope(
      child: TaskTimerApp(),
    ),
  );
}

/// Widget raíz de la aplicación
class TaskTimerApp extends StatelessWidget {
  const TaskTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configuración básica
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Localización
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Español (default)
        Locale('en'), // Inglés
      ],
      locale: const Locale('es'),

      // Tema - Utilizando AppTheme del sistema de diseño
      theme: AppTheme.darkTheme,

      // Página inicial (temporal - se reemplazará con TaskListScreen)
      home: const _PlaceholderHomePage(),
    );
  }
}

/// Página temporal de placeholder
///
/// Esta página será reemplazada por TaskListScreen en el siguiente sprint.
class _PlaceholderHomePage extends StatelessWidget {
  const _PlaceholderHomePage();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono de reloj
            Icon(
              Icons.timer_outlined,
              size: 120,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 32),

            // Título
            Text(
              localizations?.appTitle ?? 'Task Timer',
              style: textTheme.displayMedium,
            ),
            const SizedBox(height: 16),

            // Subtítulo
            Text(
              'Arquitectura base configurada',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),

            // Versión
            Text(
              'v${AppConstants.version}',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 48),

            // Información de progreso
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 48),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 48,
                    color: theme.colorScheme.tertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Clean Architecture',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Estructura de carpetas creada\nTema oscuro configurado\nInternacionalización lista',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

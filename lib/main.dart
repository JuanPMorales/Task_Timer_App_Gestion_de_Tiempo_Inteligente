/// Punto de entrada de Task Timer App
///
/// Aplicación móvil para gestión de tiempo con cronómetros personalizados.
/// Desarrollada siguiendo Clean Architecture + MVVM + Riverpod.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_timer/core/constants/app_constants.dart';
import 'package:task_timer/core/theme/app_colors.dart';
import 'package:task_timer/l10n/app_localizations.dart';

/// Función principal de la aplicación
void main() {
  // Inicialización de la aplicación
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(Sprint-2): Inicializar servicios (base de datos, providers, etc.)

  runApp(const TaskTimerApp());
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

      // Tema
      theme: _buildTheme(),

      // Página inicial (temporal - se reemplazará con TaskListScreen)
      home: const _PlaceholderHomePage(),
    );
  }

  /// Construye el tema de la aplicación
  ThemeData _buildTheme() {
    return ThemeData(
      // Paleta de colores
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
        error: AppColors.error,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.background,

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),

      // Material 3
      useMaterial3: true,

      // Tipografía (se refinará con AppTextStyles)
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.textPrimary),
        displayMedium: TextStyle(color: AppColors.textPrimary),
        displaySmall: TextStyle(color: AppColors.textPrimary),
        headlineMedium: TextStyle(color: AppColors.textPrimary),
        headlineSmall: TextStyle(color: AppColors.textPrimary),
        titleLarge: TextStyle(color: AppColors.textPrimary),
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primaryDark,
      ),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono de reloj
            const Icon(
              Icons.timer_outlined,
              size: 120,
              color: AppColors.primaryLight,
            ),
            const SizedBox(height: 32),

            // Título
            Text(
              localizations?.appTitle ?? 'Task Timer',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Subtítulo
            const Text(
              'Arquitectura base configurada',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),

            // Versión
            const Text(
              'v${AppConstants.version}',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 48),

            // Información de progreso
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 48),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 48,
                    color: AppColors.success,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Clean Architecture',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Estructura de carpetas creada\nTema oscuro configurado\nInternacionalización lista',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
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

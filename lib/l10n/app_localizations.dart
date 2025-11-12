import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es'),
    Locale('en')
  ];

  /// Título de la aplicación
  ///
  /// In es, this message translates to:
  /// **'Task Timer'**
  String get appTitle;

  /// Etiqueta para la sección de tareas
  ///
  /// In es, this message translates to:
  /// **'Tareas'**
  String get tasks;

  /// Etiqueta para el temporizador
  ///
  /// In es, this message translates to:
  /// **'Temporizador'**
  String get timer;

  /// Etiqueta para la sección de estadísticas
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get statistics;

  /// Etiqueta para configuración
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settings;

  /// Botón para crear nueva tarea
  ///
  /// In es, this message translates to:
  /// **'Crear Tarea'**
  String get createTask;

  /// Botón para editar tarea
  ///
  /// In es, this message translates to:
  /// **'Editar Tarea'**
  String get editTask;

  /// Botón para eliminar tarea
  ///
  /// In es, this message translates to:
  /// **'Eliminar Tarea'**
  String get deleteTask;

  /// Campo de título de tarea
  ///
  /// In es, this message translates to:
  /// **'Título'**
  String get taskTitle;

  /// Campo de descripción de tarea
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get taskDescription;

  /// Tiempo estimado para completar la tarea
  ///
  /// In es, this message translates to:
  /// **'Tiempo Estimado'**
  String get taskEstimatedTime;

  /// Prioridad de la tarea
  ///
  /// In es, this message translates to:
  /// **'Prioridad'**
  String get taskPriority;

  /// Prioridad alta
  ///
  /// In es, this message translates to:
  /// **'Alta'**
  String get priorityHigh;

  /// Prioridad media
  ///
  /// In es, this message translates to:
  /// **'Media'**
  String get priorityMedium;

  /// Prioridad baja
  ///
  /// In es, this message translates to:
  /// **'Baja'**
  String get priorityLow;

  /// Botón para iniciar temporizador
  ///
  /// In es, this message translates to:
  /// **'Iniciar'**
  String get start;

  /// Botón para pausar temporizador
  ///
  /// In es, this message translates to:
  /// **'Pausar'**
  String get pause;

  /// Botón para reanudar temporizador
  ///
  /// In es, this message translates to:
  /// **'Reanudar'**
  String get resume;

  /// Botón para detener temporizador
  ///
  /// In es, this message translates to:
  /// **'Detener'**
  String get stop;

  /// Marcar tarea como completada
  ///
  /// In es, this message translates to:
  /// **'Completar'**
  String get complete;

  /// Botón cancelar
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Botón guardar
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// Botón eliminar
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// Botón confirmar
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// Duración del pomodoro en minutos
  ///
  /// In es, this message translates to:
  /// **'{minutes} minutos'**
  String pomodoroMinutes(int minutes);

  /// Contador de tareas completadas
  ///
  /// In es, this message translates to:
  /// **'Tareas Completadas: {count}'**
  String completedTasks(int count);

  /// Tiempo total trabajado
  ///
  /// In es, this message translates to:
  /// **'Tiempo Total: {hours}h {minutes}m'**
  String totalTime(int hours, int minutes);

  /// Notificación de tarea completada
  ///
  /// In es, this message translates to:
  /// **'¡Tarea completada!'**
  String get taskCompletedNotification;

  /// Notificación de pomodoro completado
  ///
  /// In es, this message translates to:
  /// **'¡Pomodoro completado! Tiempo de descanso.'**
  String get pomodoroCompletedNotification;

  /// Mensaje cuando no hay tareas
  ///
  /// In es, this message translates to:
  /// **'No hay tareas'**
  String get noTasksFound;

  /// Mensaje para crear primera tarea
  ///
  /// In es, this message translates to:
  /// **'Crea tu primera tarea'**
  String get createFirstTask;

  /// Confirmación de eliminación
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de eliminar esta tarea?'**
  String get deleteConfirmation;

  /// Mensaje de validación para campos requeridos
  ///
  /// In es, this message translates to:
  /// **'Este campo es requerido'**
  String get requiredField;

  /// Mensaje de error para tiempo inválido
  ///
  /// In es, this message translates to:
  /// **'Tiempo inválido'**
  String get invalidTime;

  /// Etiqueta para hoy
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get today;

  /// Etiqueta para ayer
  ///
  /// In es, this message translates to:
  /// **'Ayer'**
  String get yesterday;

  /// Etiqueta para esta semana
  ///
  /// In es, this message translates to:
  /// **'Esta Semana'**
  String get thisWeek;

  /// Etiqueta para este mes
  ///
  /// In es, this message translates to:
  /// **'Este Mes'**
  String get thisMonth;

  /// Opción de modo oscuro
  ///
  /// In es, this message translates to:
  /// **'Modo Oscuro'**
  String get darkMode;

  /// Opción de idioma
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// Configuración de notificaciones
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notifications;

  /// Configuración de vibración
  ///
  /// In es, this message translates to:
  /// **'Vibración'**
  String get vibration;

  /// Sección Acerca de
  ///
  /// In es, this message translates to:
  /// **'Acerca de'**
  String get about;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

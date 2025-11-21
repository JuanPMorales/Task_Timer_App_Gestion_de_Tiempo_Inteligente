/// Dimensiones y espaciados estandarizados de la aplicación Task Timer.
///
/// Define todos los valores de espaciado, tamaños, bordes y dimensiones
/// para mantener consistencia visual en toda la aplicación.
///
/// Criterios de diseño:
/// - Espaciado base de 4dp (siguiendo Material Design)
/// - Tamaños táctiles mínimos de 44x44dp (WCAG 2.1 AA)
/// - Sistema de espaciado escalable (xs, sm, md, lg, xl, xxl)
/// - Bordes redondeados consistentes
library;

/// Clase que contiene todas las dimensiones y espaciados de la aplicación.
///
/// Organizada en categorías para facilitar su uso y mantenimiento:
/// - Espaciados generales
/// - Paddings
/// - Margins
/// - Tamaños de componentes
/// - Bordes y elevaciones
/// - Tamaños de íconos
/// - Dimensiones específicas
class AppDimensions {
  // Constructor privado para prevenir instanciación
  AppDimensions._();

  // ============================================================================
  // ESPACIADO BASE
  // ============================================================================

  /// Unidad base de espaciado (4dp) - Material Design
  static const double baseUnit = 4;

  // ============================================================================
  // ESPACIADOS GENERALES (Múltiplos de baseUnit)
  // ============================================================================

  /// Espaciado extra pequeño (4dp = 1x baseUnit)
  static const double spaceXS = baseUnit; // 4.0

  /// Espaciado pequeño (8dp = 2x baseUnit)
  static const double spaceSM = baseUnit * 2; // 8.0

  /// Espaciado mediano (12dp = 3x baseUnit)
  static const double spaceMD = baseUnit * 3; // 12.0

  /// Espaciado estándar (16dp = 4x baseUnit)
  static const double spaceLG = baseUnit * 4; // 16.0

  /// Espaciado extra grande (24dp = 6x baseUnit)
  static const double spaceXL = baseUnit * 6; // 24.0

  /// Espaciado extra extra grande (32dp = 8x baseUnit)
  static const double spaceXXL = baseUnit * 8; // 32.0

  /// Espaciado masivo (48dp = 12x baseUnit)
  static const double spaceHuge = baseUnit * 12; // 48.0

  // ============================================================================
  // PADDINGS
  // ============================================================================

  /// Padding extra pequeño para elementos compactos (4dp)
  static const double paddingXS = spaceXS;

  /// Padding pequeño para elementos internos (8dp)
  static const double paddingSM = spaceSM;

  /// Padding mediano para contenido (12dp)
  static const double paddingMD = spaceMD;

  /// Padding estándar para pantallas y contenedores (16dp)
  static const double paddingLG = spaceLG;

  /// Padding extra grande para separación importante (24dp)
  static const double paddingXL = spaceXL;

  /// Padding extra extra grande para espacios amplios (32dp)
  static const double paddingXXL = spaceXXL;

  // Paddings específicos por componente
  /// Padding horizontal de botones (24dp)
  static const double buttonPaddingH = spaceXL;

  /// Padding vertical de botones (12dp)
  static const double buttonPaddingV = spaceMD;

  /// Padding horizontal de inputs (16dp)
  static const double inputPaddingH = spaceLG;

  /// Padding vertical de inputs (12dp)
  static const double inputPaddingV = spaceMD;

  /// Padding de cards (16dp)
  static const double cardPadding = spaceLG;

  /// Padding de diálogos (24dp)
  static const double dialogPadding = spaceXL;

  /// Padding de list tiles (16dp horizontal, 12dp vertical)
  static const double listTilePaddingH = spaceLG;
  static const double listTilePaddingV = spaceMD;

  // ============================================================================
  // MARGINS
  // ============================================================================

  /// Margin extra pequeño (4dp)
  static const double marginXS = spaceXS;

  /// Margin pequeño (8dp)
  static const double marginSM = spaceSM;

  /// Margin mediano (12dp)
  static const double marginMD = spaceMD;

  /// Margin estándar (16dp)
  static const double marginLG = spaceLG;

  /// Margin extra grande (24dp)
  static const double marginXL = spaceXL;

  /// Margin extra extra grande (32dp)
  static const double marginXXL = spaceXXL;

  // Margins específicos por componente
  /// Margin horizontal de cards (16dp)
  static const double cardMarginH = spaceLG;

  /// Margin vertical de cards (8dp)
  static const double cardMarginV = spaceSM;

  /// Margin entre secciones (24dp)
  static const double sectionMargin = spaceXL;

  // ============================================================================
  // TAMAÑOS DE COMPONENTES
  // ============================================================================

  // Botones
  /// Altura mínima de botones - accesibilidad táctil (44dp)
  static const double buttonMinHeight = 44;

  /// Ancho mínimo de botones (88dp)
  static const double buttonMinWidth = 88;

  /// Altura de botones grandes (56dp)
  static const double buttonHeightLarge = 56;

  /// Ancho de botones de ancho completo (relativo al contenedor)
  static const double buttonWidthFull = double.infinity;

  // Inputs
  /// Altura de campos de texto (48dp)
  static const double inputHeight = 48;

  /// Altura de campos de texto multilinea mínima (96dp)
  static const double textAreaMinHeight = 96;

  // Cards
  /// Altura mínima de task cards (120dp)
  static const double taskCardMinHeight = 120;

  /// Ancho máximo de cards en pantallas grandes (600dp)
  static const double cardMaxWidth = 600;

  // Bottom Sheets
  /// Altura máxima de bottom sheets (80% de pantalla)
  static const double bottomSheetMaxHeight = 0.8;

  // Tamaños táctiles (WCAG 2.1 AA)
  /// Área táctil mínima recomendada (44x44dp)
  static const double minTouchTarget = 44;

  /// Área táctil óptima para facilidad de uso (48x48dp)
  static const double optimalTouchTarget = 48;

  // ============================================================================
  // BORDES Y RADIOS
  // ============================================================================

  /// Radio de borde extra pequeño (4dp)
  static const double radiusXS = baseUnit;

  /// Radio de borde pequeño (8dp)
  static const double radiusSM = spaceSM;

  /// Radio de borde mediano (12dp)
  static const double radiusMD = spaceMD;

  /// Radio de borde grande (16dp)
  static const double radiusLG = spaceLG;

  /// Radio de borde extra grande (20dp)
  static const double radiusXL = 20;

  /// Radio de borde extra extra grande (24dp)
  static const double radiusXXL = spaceXL;

  /// Radio circular completo (9999dp)
  static const double radiusFull = 9999;

  // Radios específicos por componente
  /// Radio de botones estándar (12dp)
  static const double buttonRadius = radiusMD;

  /// Radio de inputs (12dp)
  static const double inputRadius = radiusMD;

  /// Radio de cards (16dp)
  static const double cardRadius = radiusLG;

  /// Radio de diálogos y modales (20dp)
  static const double dialogRadius = radiusXL;

  /// Radio de bottom sheets (solo top: 20dp)
  static const double bottomSheetRadius = radiusXL;

  /// Radio de chips y badges (20dp para efecto pill)
  static const double chipRadius = radiusXL;

  /// Radio de avatar circular (completo)
  static const double avatarRadius = radiusFull;

  // ============================================================================
  // ELEVACIONES (SOMBRAS)
  // ============================================================================

  /// Sin elevación (0dp)
  static const double elevationNone = 0;

  /// Elevación pequeña para elementos sutiles (1dp)
  static const double elevationXS = 1;

  /// Elevación mediana para cards y botones (2dp)
  static const double elevationSM = 2;

  /// Elevación estándar para elementos destacados (4dp)
  static const double elevationMD = 4;

  /// Elevación grande para modales y FAB (6dp)
  static const double elevationLG = 6;

  /// Elevación extra grande para diálogos (8dp)
  static const double elevationXL = 8;

  /// Elevación máxima para elementos flotantes (12dp)
  static const double elevationXXL = 12;

  // ============================================================================
  // TAMAÑOS DE ÍCONOS
  // ============================================================================

  /// Ícono extra pequeño (16dp)
  static const double iconXS = 16;

  /// Ícono pequeño (20dp)
  static const double iconSM = 20;

  /// Ícono mediano estándar (24dp)
  static const double iconMD = 24;

  /// Ícono grande (32dp)
  static const double iconLG = 32;

  /// Ícono extra grande (40dp)
  static const double iconXL = 40;

  /// Ícono extra extra grande (48dp)
  static const double iconXXL = 48;

  /// Ícono masivo para elementos destacados (64dp)
  static const double iconHuge = 64;

  // ============================================================================
  // ANCHOS Y ALTURAS ESPECÍFICAS
  // ============================================================================

  // AppBar
  /// Altura estándar de AppBar (56dp)
  static const double appBarHeight = 56;

  /// Altura de AppBar grande con scroll (104dp)
  static const double appBarHeightLarge = 104;

  // Bottom Navigation
  /// Altura de bottom navigation bar (56dp)
  static const double bottomNavHeight = 56;

  /// Altura de bottom navigation bar con etiquetas (64dp)
  static const double bottomNavHeightLabeled = 64;

  // FAB
  /// Tamaño de FAB estándar (56x56dp)
  static const double fabSize = 56;

  /// Tamaño de FAB pequeño (40x40dp)
  static const double fabSizeSmall = 40;

  /// Tamaño de FAB grande (64x64dp)
  static const double fabSizeLarge = 64;

  // Timer Display
  /// Altura del display del temporizador principal (120dp)
  static const double timerDisplayHeight = 120;

  /// Tamaño de los controles del temporizador (64dp)
  static const double timerControlSize = 64;

  // Dividers
  /// Grosor de líneas divisorias (1dp)
  static const double dividerThickness = 1;

  /// Grosor de líneas divisorias gruesas (2dp)
  static const double dividerThicknessThick = 2;

  // Progress Indicators
  /// Grosor de circular progress indicator (4dp)
  static const double progressThickness = 4;

  /// Grosor de circular progress indicator grueso (6dp)
  static const double progressThicknessThick = 6;

  // ============================================================================
  // DIMENSIONES ESPECÍFICAS DE TASK TIMER
  // ============================================================================

  /// Altura de la tarjeta de temporizador activo (200dp)
  static const double activeTimerCardHeight = 200;

  /// Altura de tarjetas de tarea en cola (72dp)
  static const double queuedTaskCardHeight = 72;

  /// Espaciado entre tarjetas de tareas (8dp)
  static const double taskCardSpacing = spaceSM;

  /// Ancho máximo del contenido principal en tablets/desktop (800dp)
  static const double maxContentWidth = 800;

  /// Altura del selector de color en creación de tareas (48dp)
  static const double colorPickerSize = 48;

  /// Tamaño del indicador de color en task cards (12dp)
  static const double colorIndicatorSize = 12;

  /// Ancho de la barra lateral en layouts grandes (280dp)
  static const double sidebarWidth = 280;

  // ============================================================================
  // DURACIONES DE ANIMACIÓN
  // ============================================================================

  /// Animación extra rápida (100ms)
  static const Duration animationFast = Duration(milliseconds: 100);

  /// Animación rápida (150ms)
  static const Duration animationQuick = Duration(milliseconds: 150);

  /// Animación normal (250ms)
  static const Duration animationNormal = Duration(milliseconds: 250);

  /// Animación estándar (300ms)
  static const Duration animationStandard = Duration(milliseconds: 300);

  /// Animación lenta (500ms)
  static const Duration animationSlow = Duration(milliseconds: 500);

  /// Animación extra lenta (800ms)
  static const Duration animationVerySlow = Duration(milliseconds: 800);

  // ============================================================================
  // UTILIDADES
  // ============================================================================

  /// Retorna un espaciado personalizado basado en múltiplos de baseUnit
  ///
  /// Ejemplo:
  /// ```dart
  /// AppDimensions.space(3) // 12dp (3 * 4)
  /// AppDimensions.space(5) // 20dp (5 * 4)
  /// ```
  static double space(int multiplier) => baseUnit * multiplier;

  /// Retorna un padding simétrico personalizado
  ///
  /// Ejemplo:
  /// ```dart
  /// AppDimensions.symmetricPadding(horizontal: 4, vertical: 2)
  /// // EdgeInsets.symmetric(horizontal: 16, vertical: 8)
  /// ```
  static double symmetricH(int multiplier) => baseUnit * multiplier;
  static double symmetricV(int multiplier) => baseUnit * multiplier;

  /// Verifica si un tamaño cumple con el mínimo táctil (44dp)
  ///
  /// Útil para validación de accesibilidad
  static bool isAccessibleTouchTarget(double size) => size >= minTouchTarget;

  /// Calcula un padding responsivo basado en el ancho de pantalla
  ///
  /// - Pantallas pequeñas (<600): paddingLG (16dp)
  /// - Pantallas medianas (600-900): paddingXL (24dp)
  /// - Pantallas grandes (>900): paddingXXL (32dp)
  static double responsivePadding(double screenWidth) {
    if (screenWidth < 600) return paddingLG;
    if (screenWidth < 900) return paddingXL;
    return paddingXXL;
  }

  /// Calcula un ancho máximo responsivo para contenido
  ///
  /// - Pantallas pequeñas: 100% del ancho
  /// - Pantallas grandes: máximo 800dp centrado
  static double responsiveMaxWidth(double screenWidth) {
    if (screenWidth < maxContentWidth) return screenWidth;
    return maxContentWidth;
  }
}

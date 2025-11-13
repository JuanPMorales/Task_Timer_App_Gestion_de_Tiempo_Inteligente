// Widget test básico para Task Timer App
//
// Este test verifica que la aplicación se construya correctamente.
// Los tests funcionales específicos se agregarán en sprints posteriores.

import 'package:flutter_test/flutter_test.dart';
import 'package:task_timer/main.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskTimerApp());

    // Verify that the app title is displayed (puede aparecer en appbar y en body)
    expect(find.text('Task Timer'), findsWidgets);

    // Verify that the placeholder screen is displayed
    expect(find.text('Arquitectura base configurada'), findsOneWidget);

    // Verify version is displayed
    expect(find.textContaining('v1.0.0'), findsOneWidget);
  });
}

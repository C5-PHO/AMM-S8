import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

Future<void> ingresar(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.enterText(find.byKey(const Key('login-email')), 'demo@aula.pe');
  await tester.enterText(find.byKey(const Key('login-password')), 'demo123');
  await tester.tap(find.text('Ingresar'));
  await tester.pumpAndSettle();
}

Future<void> abrirLista(WidgetTester tester) async {
  await tester.tap(find.text('Listar alumnos'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('valida el acceso y cerrar sesión elimina el menú del historial', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();
    expect(find.text('Ingresa un correo válido'), findsOneWidget);
    expect(find.text('Usa al menos 6 caracteres'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('login-email')), 'demo@aula.pe');
    await tester.enterText(find.byKey(const Key('login-password')), 'demo123');
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();
    expect(find.text('Hola, María'), findsOneWidget);
    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();
    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(Navigator.of(tester.element(find.text('Ingresar'))).canPop(), isFalse);
  });

  testWidgets('registra, valida rango y encuentra al alumno nuevo', (tester) async {
    await ingresar(tester);
    await tester.tap(find.text('Registrar alumno'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Ingresa el nombre'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('student-name')), 'Lucía');
    await tester.enterText(find.byKey(const Key('student-surname')), 'Pérez');
    await tester.enterText(find.byKey(const Key('student-grade')), '21');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Ingresa una nota entre 0 y 20'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('student-grade')), '10,5');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('5 alumnos en tu aula'), findsOneWidget);
    await abrirLista(tester);
    await tester.enterText(find.byType(TextField), 'lucía');
    await tester.pumpAndSettle();
    expect(find.text('Lucía Pérez'), findsOneWidget);
    expect(find.text('Desaprobado'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'inexistente');
    await tester.pumpAndSettle();
    expect(find.text('No se encontraron alumnos'), findsOneWidget);
  });

  testWidgets('edita una nota y elimina solo después de confirmar', (tester) async {
    await ingresar(tester);
    await abrirLista(tester);
    await tester.tap(find.byTooltip('Opciones de Ana'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Editar'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('student-grade')), '8');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Nota: 8.0 / 20'), findsOneWidget);
    await tester.tap(find.byTooltip('Opciones de Ana'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(find.text('Ana Torres'), findsOneWidget);
    await tester.tap(find.byTooltip('Opciones de Ana'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Eliminar'));
    await tester.pumpAndSettle();
    expect(find.text('Ana Torres'), findsNothing);
  });

  testWidgets('edita el perfil y actualiza el saludo al volver', (tester) async {
    await ingresar(tester);
    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Editar perfil'), 180);
    await tester.tap(find.text('Editar perfil'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Elena Torres');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Elena Torres'), findsWidgets);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Hola, Elena'), findsOneWidget);
  });

  testWidgets('las cinco pantallas caben en móvil de 320 píxeles', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await ingresar(tester);
    expect(tester.takeException(), isNull);
    for (final opcion in ['Listar alumnos', 'Registrar alumno', 'Perfil']) {
      await tester.tap(find.text(opcion));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tafsol_core/flutter_tafsol_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDropdown Widget Tests', () {
    testWidgets('Should render with hint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScreenUtil(
              options: ScreenUtilOptions(designSize: const Size(390, 844)),
              child: AppDropdown<String>(
                hint: 'Select Option',
                items: const ['A', 'B'],
                builder: (item) => Text(item),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Select Option'), findsOneWidget);
    });

    testWidgets('Should show items and select one', (tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScreenUtil(
              options: ScreenUtilOptions(designSize: const Size(390, 844)),
              child: AppDropdown<String>(
                hint: 'Select',
                items: const ['Option 1', 'Option 2'],
                builder: (item) => Text(item),
                onChanged: (val) => selectedValue = val,
              ),
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.text('Select'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // Find item in the list and tap it
      await tester.tap(find.text('Option 1').last);
      await tester.pumpAndSettle();

      expect(selectedValue, 'Option 1');
    });

    testWidgets('Should validate correctly', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScreenUtil(
              options: ScreenUtilOptions(designSize: const Size(390, 844)),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    AppDropdown<String>(
                      hint: 'Select',
                      items: const ['A'],
                      builder: (item) => Text(item),
                      validator: (value) => value == null ? 'Error' : null,
                    ),
                    ElevatedButton(
                      onPressed: () => formKey.currentState?.validate(),
                      child: const Text('Validate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Validate'));
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
    });
  });
}

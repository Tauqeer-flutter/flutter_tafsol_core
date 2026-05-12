import 'package:flutter/material.dart';
import 'package:flutter_tafsol_core/flutter_tafsol_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getDesignSize Tests', () {
    testWidgets('Should return Mobile size for width < 600', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final size = getDesignSize(context);
              expect(size, const Size(390, 844));
              return const SizedBox();
            },
          ),
        ),
      );

      tester.view.resetPhysicalSize();
    });

    testWidgets('Should return Tablet size for width between 600 and 1024', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final size = getDesignSize(context);
              expect(size, const Size(768, 1024));
              return const SizedBox();
            },
          ),
        ),
      );

      tester.view.resetPhysicalSize();
    });

    testWidgets(
      'Should return MacBook Air size for width between 1024 and 1366',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final size = getDesignSize(context);
                expect(size, const Size(1280, 832));
                return const SizedBox();
              },
            ),
          ),
        );

        tester.view.resetPhysicalSize();
      },
    );

    testWidgets('Should support custom sizes', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final customMobileSize = const Size(412, 920);
              final size = getDesignSize(
                context,
                customSizes: {DeviceType.mobile: customMobileSize},
              );
              expect(size, customMobileSize);
              return const SizedBox();
            },
          ),
        ),
      );

      tester.view.resetPhysicalSize();
    });

    testWidgets('Should swap dimensions for mobile landscape', (tester) async {
      // Small landscape mobile
      tester.view.physicalSize = const Size(500, 300);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final size = getDesignSize(context);
              // Original Mobile: 390x844. Swapped: 844x390
              expect(size, const Size(844, 390));
              return const SizedBox();
            },
          ),
        ),
      );

      tester.view.resetPhysicalSize();
    });
  });
}

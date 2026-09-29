import 'package:doc_bao_online/main.dart';
import 'package:doc_bao_online/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('hiển thị bốn mục điều hướng theo yêu cầu', (tester) async {
    await tester.pumpWidget(NewsApp(themeController: ThemeController()));
    await tester.pump();

    expect(find.text('Tin tổng hợp'), findsOneWidget);
    expect(find.text('Chủ đề'), findsOneWidget);
    expect(find.text('Tin mới nhất'), findsOneWidget);
    expect(find.text('Cài đặt'), findsOneWidget);
  });

  testWidgets('màn hình cài đặt hiển thị thông tin sinh viên', (tester) async {
    await tester.pumpWidget(NewsApp(themeController: ThemeController()));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pump();

    expect(find.text('D22KTPM03'), findsOneWidget);
    expect(find.text('2224801030048'), findsOneWidget);
    expect(find.text('Huỳnh Xuân Nhã'), findsOneWidget);
  });
}

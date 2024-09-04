import 'package:cat_api_prueba_pragma_jeant/main.dart' as app;
import 'package:cat_api_prueba_pragma_jeant/ui/pages/detail_page.dart';
import 'package:cat_api_prueba_pragma_jeant/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('cat api verify tap', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byKey(const Key('abys')));
    await tester.pumpAndSettle();

    expect(find.byType(DetailPage), findsOneWidget);

 /*    await tester.tap(find.byKey(const Key('goBack')));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget); */
  });
}
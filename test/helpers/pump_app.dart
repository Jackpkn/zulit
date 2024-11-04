import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zulit/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(

        home: widget,
      ),
    );
  }
}

import 'package:flutter_katana_looper/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders a channel button per Katana channel', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SwitchbladeApp());

    expect(find.text('CH1'), findsOneWidget);
    expect(find.text('CH2'), findsOneWidget);
    expect(find.text('CH3'), findsOneWidget);
    expect(find.text('CH4'), findsOneWidget);
  });
}

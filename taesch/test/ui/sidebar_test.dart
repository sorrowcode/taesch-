import 'package:flutter_test/flutter_test.dart';
import 'package:taesch/app.dart';
import 'package:taesch/model/screen.dart';
import 'package:taesch/pages/view/shopping_list_page.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());
    ShoppingListPage page = ShoppingListPage(title: Screen.shoppingList.text);
    expect(find.byWidget(page), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taesch/app.dart';
import 'package:taesch/model/screen.dart';
import 'package:taesch/pages/view/near_shops_page.dart';
import 'package:taesch/pages/view/shopping_list_page.dart';


void testNavigation() {
  testWidgets('tests navigation from shopping list page to near shops page', (widgetTester) async {
    var key = GlobalKey<ScaffoldState>();
    // building the root of the application
    await widgetTester.pumpWidget(App(key: key,));
    // checking in which page we are
    expect(find.byType(ShoppingListPage), findsOneWidget);
    expect(find.byType(NearShopsPage), findsNothing);
    // finding the button for the drawer
    var findMenuButton = find.byIcon(Icons.menu);
    expect(findMenuButton, findsOneWidget);
    // tapping the button which should make the drawer visible
    await widgetTester.ensureVisible(findMenuButton);
    await widgetTester.tap(findMenuButton);
    await widgetTester.pumpAndSettle();
    // checking if drawer made list tiles visible
    expect(find.byType(ListTile), findsAtLeastNWidgets(2));
    var findNearShopsListTile = find.text(Screen.nearShops.text);
    expect(findNearShopsListTile, findsOneWidget);
    // tapping on list tile to switch page
    await widgetTester.tap(findNearShopsListTile);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    // checking if page was switched
    expect(find.text(Screen.nearShops.text), findsAtLeastNWidgets(2));
  });
}

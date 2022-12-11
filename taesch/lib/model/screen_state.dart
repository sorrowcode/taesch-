/// enumeration for tracking the screen
enum ScreenState { shoppingList, nearShops, settings, shopsMap, shoppingListTemplates }

/// extension of the enumeration for holding some constants
extension ScreenString on ScreenState {
  String get text {
    switch (this) {
      case ScreenState.shoppingList:
        return "Shopping List";
      case ScreenState.nearShops:
        return "Near Shops";
      case ScreenState.settings:
        return "Settings";
      case ScreenState.shopsMap:
        return "Map";
      case ScreenState.shoppingListTemplates:
        return "Templates";
    }
  }
}

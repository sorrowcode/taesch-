/// enumeration for tracking the screen
enum Screen {
  shoppingList,
  nearShops,
}

/// extension of the enumeration for holding some constants
extension ScreenString on Screen {
  String get text {
    switch (this) {
      case Screen.shoppingList:
        return "Shopping List";
      case Screen.nearShops:
        return "Near Shops";
    }
  }
}

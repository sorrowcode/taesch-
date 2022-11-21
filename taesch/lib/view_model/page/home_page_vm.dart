import 'package:taesch/api/repository.dart';
import 'package:taesch/model/screen_state.dart';

class HomePageVM {
  ScreenState screenState = ScreenState.shoppingList;
  var repository = Repository();
}

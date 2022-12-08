import 'package:taesch/api/repository.dart';
import 'package:taesch/model/screen_state.dart';

class HomePageVM {
  late ScreenState screenState = ScreenState.shoppingList;
  bool init = true;
  var repository = Repository();
}

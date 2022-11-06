class MyTools {
  static List<dynamic> getElements({required dynamic list, int cap = 0}) {
    List<dynamic> result = [];
    bool capSet = cap > 0 ? true : false;
    bool endReached = false;
    int counter = 0;
    while (!endReached) {
      try {
        result.add(list[counter]);
        counter++;
        if (capSet) {
          if (counter > cap) endReached = true;
        }
      } catch (e) {
        endReached = true;
        // print("counter = $counter");
      }
    }
    return result;
  }

}

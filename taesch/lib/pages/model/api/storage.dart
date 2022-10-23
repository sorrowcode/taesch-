// Stores data permanently
class PersistStorage<T> {


  // retrieves stored data
  dynamic read(String filter) {}

  // adds or overwrites stored data
  void insert(T data) {}

  // clears stored data
  void update(T data) {}

  void delete(T data) {}

}

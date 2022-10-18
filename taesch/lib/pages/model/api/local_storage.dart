import 'dart:html';
import 'package:taesch/pages/model/api/storage.dart';

class LocalStorage implements PersistStorage{

  final Storage _localStorage = window.localStorage;

  final String lStorageId = "list";

  @override
  getRepo() {
    return _localStorage[lStorageId];
  }

  @override
  void writeRepo(data) {
    _localStorage[lStorageId] = data;
  }

  @override
  void clearRepo() {
    _localStorage.remove(lStorageId);
  }
}
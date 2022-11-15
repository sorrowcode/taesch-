class Tag {
  late String tagName;
  late double _priorityValue;

  Tag({required this.tagName});

  double get priorityValue => _priorityValue;

  set priorityValue(double value) {
    if (value < 1 && value > 0) {
      _priorityValue = value;
    } else {
      // todo: throw exception
    }
  }

  Map<String,dynamic> toMap(){
    return {'tag_name': tagName, 'priority': _priorityValue};
  }
}

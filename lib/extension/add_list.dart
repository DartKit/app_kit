extension AddList on List {
  List<List> splitList(int len) {
    if (len <= 1) {
      return [this];
    }
    List<List> result = [];
    int index = 1;

    while (true) {
      if (index * len < length) {
        List temp = skip((index - 1) * len).take(len).toList();
        result.add(temp);
        index++;
        continue;
      }
      List temp = skip((index - 1) * len).toList();
      result.add(temp);
      break;
    }
    return result;
  }
}

extension MapStrDyn on Map {
  Map<String, dynamic> get toStrDynamic {
    return map((key, value) {
      if (value.runtimeType.toString().startsWith('List'))
        return MapEntry(key.toString(), mapLs(value as List));
      return MapEntry(key.toString(), value);
    });
  }

  Map<String, dynamic> get toStrDynamic2 {
    return map((key, value) {
      if (value.runtimeType.toString().startsWith('List'))
        return MapEntry(key.toString(), mapLs2(value as List));
      return MapEntry(key.toString(), value);
    });
  }

  List<Map<String, dynamic>> mapLs2(List ls) => ls.map((e) {
        return (e as Map).toStrDynamic2;
      }).toList();

  List mapLs(List ls) => ls.map((e) {
        if (e.runtimeType.toString().startsWith('Map')) {
          return (e as Map).toStrDynamic;
        }
        return e;
      }).toList();
}

extension MapExt<T, U> on Map<T, U> {
  /// map排序 或者 对象中的某个元素排序
  Map<T, U> sortedBy(Comparable Function(U u) value, {bool isAsc = true}) {
    final entries = this.entries.toList();
    isAsc
        ? entries.sort((a, b) => value(a.value).compareTo(value(b.value)))
        : entries.sort((b, a) => value(a.value).compareTo(value(b.value)));
    return Map<T, U>.fromEntries(entries);
  }

  /*
  使用示例1
   Map<String, dynamic> data = {
    "book": 3,
    "pencil": 10,
    "keyboard": 1,
    "scissors": 2
  };
  final sortedAsc = data.sortedBy((u) => u);
  final sortedDsc = data.sortedBy((u) => u, isAsc: false);
  print('ASC: $sortedAsc');
  print('DSC: $sortedDsc');
  输出：
  ASC: {keyboard: 1, scissors: 2, book: 3, pencil: 10)
  DSC: {pencil: 10, book: 3, scissors: 2, keyboard: 1}

使用示例2
Map<String, Item> data2 = {
"2022-11-01": Item(count: 12, name: "book"'),
"2022-11-12": Item(count: 2, name: "pencil"),
"2022-11-05": Item(count: 18, name: "keyboard"),
"2022-11-24": Item(count: 8, name: "scissors"),
};
final sortByCount = data2.sortedBy ((u) =› u. count) .toString();
final sortByName = data2.sortedBy ((u) =› u. name) .toString();
print('Sort by Count: : › $sortByCount' );
print('Sort by Name :: › $sortByName');
   */
}

extension AddMap on Map {
  // Map<String, dynamic> get convertDDtoSD  {
  //   Map<String,dynamic> map = {};
  //   if (runtimeType == Map<dynamic, dynamic> ) {
  //     for (var key in keys) {
  //       if (map[key.to] is Map) {
  //         map[key.toString()] = this[key];
  //       }
  //     }
  //   }
  //   return map;
  //   // return Map<String, dynamic>.from(map);
  //   // more explicit alternative way:
  //   // return Map.fromEntries(map.entries.map((entry) => MapEntry(entry.key.toString(), entry.value)));
  // }
  // Map<String, dynamic> convertDDtoSD(Map<dynamic, dynamic> map) {
  //   for (var key in map.keys) {
  //     if (map[key] is Map) {
  //       map[key] = convertDDtoSD(map[key]);
  //     }
  //   }  // use .from to ensure the keys are Strings
  //   return Map<String, dynamic>.from(map);
  //   // more explicit alternative way:
  //   // return Map.fromEntries(map.entries.map((entry) => MapEntry(entry.key.toString(), entry.value)));
  // }

  // Map<String, dynamic> convertSStoDD(Map<dynamic, dynamic> map) {
  //   for (var key in map.keys) {
  //     if (map[key] is Map) {
  //       map[key] = convertSStoDD(map[key]);
  //     }
  //   }  // use .from to ensure the keys are Strings
  //   return Map<String, dynamic>.from(map);
  //   // more explicit alternative way:
  //   // return Map.fromEntries(map.entries.map((entry) => MapEntry(entry.key.toString(), entry.value)));
  // }
}

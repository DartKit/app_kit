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


/*
where : 接受一个函数作为参数，该函数接受 Map 的键和值作为参数，并返回一个布尔值。
whereKey : 接受一个只接受键作为参数的函数。
whereValue : 这个方法接受一个只接受值作为参数的函数。
void main(){
  const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter': 22};
  print(people.where((key, value) => key.length > 4 && value > 20)); // {Peter: 22}
  print(people.whereKey((key) => key.length < 5)); // {John: 20, Mary: 21}
  print(people.whereValue((value) => value.isEven)); // {John: 20, Peter: 22}
}
其中 where 方法先使用 entries 获取 Map 的键值对列表，然后使用 entries.where 方法对列表中的每个键值对进行过滤，最后使用 fromEntries 方法将过滤后的键值对列表转换回 Map，最后返回的新的 Map 中只包含满足条件的键值对，达到对 Map 中键值过滤的效果，也让代码更加简洁和易读。
* */
extension DetailedWhere<K, V> on Map<K, V> {
  Map<K, V> where(bool Function(K key, V value) f) => Map<K, V>.fromEntries(
    entries.where((entry) => f(entry.key, entry.value)),
  );

  Map<K, V> whereKey(bool Function(K key) f) =>
      {...where((key, value) => f(key))};
  Map<K, V> whereValue(bool Function(V value) f) =>
      {...where((key, value) => f(value))};
}

/*
Map 过滤还有另外一种写法
void main(){
  const Map<String, int> people = {
    'foo': 20,
    'bar': 31,
    'baz': 25,
    'qux': 32,
  };
  final peopleOver30 = people.filter((e) => e.value > 30);
  print(peopleOver30); // 输出结果：(MapEntry(bar: 31), MapEntry(qux: 32))
}
* */
extension Filter<K, V> on Map<K, V> {
  Iterable<MapEntry<K, V>> filter(
      bool Function(MapEntry<K, V> entry) f,
      ) sync* {
    for (final entry in entries) {
      if (f(entry)) {
        yield entry;
      }
    }
  }
}


/*
上面的代码用到了 operator 关键字，在 Dart 中，operator 关键字用于定义自定义操作符或者重载现有的操作符。通过 operator 关键字，我们可以为自定义类定义各种操作符的行为，使得我们的类可以像内置类型一样使用操作符。

如 operator + 来定义两个对象相加的行为，operator [] 来实现索引操作，operator == 来定义相等性比较。这种语义式的也更加符合直觉、清晰易懂。

下面来看看 Map 的 Merge 功能调用代码例子：
const userInfo = {
  'name': 'StellarRemi',
  'age': 28,
};

const address = {
  'address': 'shanghai',
  'post_code': '200000',
};

void main() {
  final allInfo = userInfo | address;
  print(allInfo);
  // 输出结果：{name: StellarRemi, age: 28, address: shanghai, post_code: 200000}
}
* */
extension Merge<K, V> on Map<K, V> {
  Map<K, V> operator |(Map<K, V> other) => {...this}..addEntries(
    other.entries,
  );
}

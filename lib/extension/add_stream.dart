
/*
unwrap 方法，通过 where 过滤掉了 null 的事件，并使用 cast() 方法将结果转换为 Stream<T> 类型，
将可空的事件转换为非空的事件流，下面是调用代码：
void main() {
  Stream<int?>.periodic(
    const Duration(seconds: 1),
    (value) => value % 2 == 0 ? value : null,
  ).unwrap().listen((evenValue) {
    print(evenValue);
  });
  /* 输出结果
    0
    2
    4
    6
    ...
*/
}
通过 extension 给 Future 和 Streams 添加 unwrap 函数后让我们的代码看起来清晰简洁多了，有没有？
**/
extension Unwrap<T> on Stream<T?> {
  Stream<T> unwrap() => where((event) => event != null).cast();
}


/*
下面代码为任意类型的可迭代对象（Iterable）添加名为 Flatten 的扩展。在这个扩展中，函数 flatten 使用了递归算法将多层嵌套的 Iterable 里面的所有元素扁平化为单层 Iterable。
注意了代码中使用了 yield 关键字，在 Flutter 中，yield 关键字用于生成迭代器，通常与sync* 或 async* 一起使用。它允许您在处理某些数据时逐步生成数据，而不是在内存中一次性处理所有数据。
对于处理大量数据或执行长时间运行的操作非常有用，因为它可以节省内存并提高性能。

Future<void> main() async {
  final flat = [
    [[1, 2, 3], 4, 5],
    [6, [7, [8, 9]], 10],
    11,12
  ].flatten();
  print(flat); // (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
}
* */
extension Flatten<T extends Object> on Iterable<T> {
  Iterable<T> flatten() {
    Iterable<T> flatten(Iterable<T> list) sync* {
      for (final value in list) {
        if (value is List<T>) {
          yield* flatten(value);
        } else {
          yield value;
        }
      }
    }
    return flatten(this);
  }
}

/*
两个数组合并成一个数组该怎么操作呢？其实和 Map 的合并相似，也是用到了自定义操作符 operator ，来看看怎么实现的。
添加了两个操作符：+ 和 &。将一个元素或者另一个可迭代对象添加到当前的可迭代对象中，然后返回一个新的可迭代对象，
让可迭代对象 terable 有了合并数组的功能。

void main() {
  const Iterable<int> values = [10, 20, 30];
  print((values & [40, 50]));
  // 输出结果：(10, 20, 30, 40, 50)
}
* */
extension InlineAdd<T> on Iterable<T> {
  Iterable<T> operator +(T other) => followedBy([other]);
  Iterable<T> operator &(Iterable<T> other) => followedBy(other);
}


/*
当数组中有一个为 null 的对象时，该如何过滤掉这个 null 对象呢，很简单可以这样做：
void main() {
  const list = ['Hello', null, 'World'];
  print(list); // [Hello, null, World]
  print(list.compactMap()); // [Hello, World]
  print(list.compactMap((e) => e?.toUpperCase())); // [HELLO, WORLD]
}
* */
extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}
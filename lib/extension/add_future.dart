
/*
unwrap 函数将可能为空的 Future 解包，如果 Future 返回的值不为 null，
则将值包装在一个新的 Future 中返回，否则返回一个空的 Future。调用示例：
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();
  static Future<File> pickImageFromGallery() => _imagePicker
      .pickImage(source: ImageSource.gallery)
      .unwrap()
      .then((xFile) => xFile.path)
      .then((filePath) => File(filePath));
}
这里用到图片选择器插件 image_picker，只有当返回的 xFile 不为空时才进行后续操作。
如果不调用 unwrap 函数，此时这里返回的 xFile 为 optional 类型，要使用之前需要判断是否为 null。
日常开发中这种情况还不少，给 Future 添加 Unwrap 函数之后这样非空判断集中在这一个函数里面处理。

* */
extension Unwrap<T> on Future<T?> {
  Future<T> unwrap() => then(
        (value) => value != null
        ? Future<T>.value(value)
        : Future.any([]),
  );
}
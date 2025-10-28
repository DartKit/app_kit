class RegexUtil {
  ///手机号验证
  static bool isChinaPhoneLegal(String str) {
    //r"^1([39][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$" 原来的
    //^1((34[0-8])|(8\d{2})|(([35][0-35-9]|4[579]|66|7[35678]|9[1389])\d{1}))\d{7}$ 网上的
    //^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\d{8}$ 网上的
    return RegExp(r"^1[2-9]\d{9}$").hasMatch(str);
  }

  ///邮箱验证
  static bool isEmail(String str) {
    return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(str);
  }

  ///验证URL
  static bool isUrl(String value) {
    return RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+").hasMatch(value);
  }

  ///验证身份证
  static bool isIdCard(String value) {
    return RegExp(r"\d{17}[\d|x]|\d{15}").hasMatch(value);
  }

  ///验证中文
  static bool isChinese(String value) {
    return RegExp(r"[\u4e00-\u9fa5]").hasMatch(value);
  }

  // 验证是否为纯字母
  static bool isLetter(String str) {
    final reg = RegExp(r"^[ZA-ZZa-z_]+$");
    return reg.hasMatch(str);
  }

  // 验证是否为数字
  static bool isNumber(String str) {
    final reg = RegExp(r"^[0-9_]+$");
    return reg.hasMatch(str);
  }

  // 验证是否为小数点数字
  static bool isDoubleNumber(String str) {
    final reg = RegExp(r"^[0-9._]+$");
    return reg.hasMatch(str);
  }

  // 验证是否为文字+数字
  static bool isLetterAndNum(String str) {
    final reg = RegExp(r"^[A-Za-z0-9_]+$");
    return reg.hasMatch(str);
  }

  //验证是否包含特殊字符
  static bool isHaveSpecialCharacters(String input) {
    final reg = new RegExp(r'[`~!@#$%^&*()_+=|;:(){}'
        ',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？-]');
    return reg.hasMatch(input);
  }
}

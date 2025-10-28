import 'relative_date_util.dart';

class DateFormats {
  static String full = 'yyyy-MM-dd HH:mm:ss';
  static String y_mo_d_h_m = 'yyyy-MM-dd HH:mm';
  static String y_mo_d = 'yyyy-MM-dd';
  static String y_mo = 'yyyy-MM';
  static String mo_d = 'MM-dd';
  static String mo_d_h_m = 'MM-dd HH:mm';
  static String h_m_s = 'HH:mm:ss';
  static String h_m = 'HH:mm';

  static String zh_full = 'yyyy年MM月dd日 HH时mm分ss秒';
  static String zh_y_mo_d_h_m = 'yyyy年MM月dd日 HH时mm分';
  static String zh_y_mo_d = 'yyyy年MM月dd日';
  static String zh_y_mo = 'yyyy年MM月';
  static String zh_mo_d = 'MM月dd日';
  static String zh_mo_d_h_m = 'MM月dd日 HH时mm分';
  static String zh_d_h_m = 'dd日 HH时mm分';
  static String zh_h_m_s = 'HH时mm分ss秒';
  static String zh_h_m = 'HH时mm分';

  static String sp_y_mo_d_h_m = 'yyyy/MM/dd HH:mm';
  static String sp_y_mo_d = 'yyyy/MM/dd';
  static String sp_y_mo = 'yyyy/MM';
  static String sp_mo_d_h_m = 'MM/dd HH:mm';

  static String none_y_mo_d_h_m = 'yyyyMMddHHmm';

  static String po_y_mo_d = 'yyyy.MM.dd';
  static String po_y_mo = 'yyyy.MM';
  static String po_mo_d_h_m = 'MM.dd.HH.mm';
  static String po_mo_d = 'MM.dd';
}

/// month->days.
Map<int, int> MONTH_DAY = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};

/// Date Util.
class DateUtil {
  /// get DateTime By DateStr.
  static DateTime? getDateTime(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime?.toUtc();
      } else {
        dateTime = dateTime?.toLocal();
      }
    }
    return dateTime;
  }

  /// get DateTime By Milliseconds.
  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  /// get DateMilliseconds By DateStr.
  static int? getDateMsByTimeStr(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = getDateTime(dateStr, isUtc: isUtc);
    return dateTime?.millisecondsSinceEpoch;
  }

  /// get Now Date Milliseconds.
  static int getNowDateMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String getNowDateStr({String? format}) {
    return formatDate(DateTime.now(), format: format);
  }

  /// format date by milliseconds.
  /// milliseconds 日期毫秒
  static String formatDateMs(int ms, {bool isUtc = false, String? format}) {
    return formatDate(getDateTimeByMs(ms, isUtc: isUtc), format: format);
  }

  /// format date by date str.
  /// dateStr 日期字符串
  static String formatDateStr(String dateStr, {bool? isUtc, String? format}) {
    return formatDate(getDateTime(dateStr, isUtc: isUtc), format: format);
  }

  /// format date by DateTime.
  /// format 转换格式(已提供常用格式 DateFormats，可以自定义格式：'yyyy/MM/dd HH:mm:ss')
  /// 格式要求
  /// year -> yyyy/yy   month -> MM/M    day -> dd/d
  /// hour -> HH/H      minute -> mm/m   second -> ss/s
  static String formatDate(DateTime? dateTime, {String? format}) {
    if (dateTime == null) return '';
    format = format ?? DateFormats.full;
    if (format.contains('yy')) {
      String year = dateTime.year.toString();
      if (format.contains('yyyy')) {
        format = format.replaceAll('yyyy', year);
      } else {
        format = format.replaceAll(
            'yy', year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  /// com format.
  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  /// get WeekDay.
  /// dateTime
  /// isUtc
  /// languageCode zh or en
  /// short
  static String getWeekday(DateTime? dateTime,
      {String languageCode = 'en', bool short = false}) {
    if (dateTime == null) return "";
    String weekday = "";
    switch (dateTime.weekday) {
      case 1:
        weekday = languageCode == 'zh' ? '星期一' : 'Monday';
        break;
      case 2:
        weekday = languageCode == 'zh' ? '星期二' : 'Tuesday';
        break;
      case 3:
        weekday = languageCode == 'zh' ? '星期三' : 'Wednesday';
        break;
      case 4:
        weekday = languageCode == 'zh' ? '星期四' : 'Thursday';
        break;
      case 5:
        weekday = languageCode == 'zh' ? '星期五' : 'Friday';
        break;
      case 6:
        weekday = languageCode == 'zh' ? '星期六' : 'Saturday';
        break;
      case 7:
        weekday = languageCode == 'zh' ? '星期日' : 'Sunday';
        break;
      default:
        break;
    }
    return languageCode == 'zh'
        ? (short ? weekday.replaceAll('星期', '周') : weekday)
        : weekday.substring(0, short ? 3 : weekday.length);
  }

  /// get WeekDay By Milliseconds.
  static String getWeekdayByMs(int milliseconds,
      {bool isUtc = false, String languageCode = 'en', bool short = false}) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getWeekday(dateTime, languageCode: languageCode, short: short);
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + MONTH_DAY[i]!;
    }
    if (isLeapYearByYear(year) && month > 2) {
      days = days + 1;
    }
    return days;
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYearByMs(int ms, {bool isUtc = false}) {
    return getDayOfYear(DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc));
  }

  ///是否当前时间范围内
  static bool isCurDateTime(String startDate, String endDate,
      {int? extrEndTime}) {
    int? _startDate = getDateMsByTimeStr(startDate);
    int _endDate = (getDateMsByTimeStr(endDate) ?? 0) + (extrEndTime ?? 0);
    int _nowDate = getNowDateMs();
    return _nowDate > _startDate! && _nowDate < _endDate;
  }

  /// is today.
  /// 是否是当天.
  static bool isToday(int? milliseconds, {bool isUtc = false, int? locMs}) {
    if (milliseconds == null || milliseconds == 0) return false;
    DateTime old =
        DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime now;
    if (locMs != null) {
      now = DateUtil.getDateTimeByMs(locMs);
    } else {
      now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  /// is yesterday by dateTime.
  /// 是否是昨天.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// is yesterday by millis.
  /// 是否是昨天.
  static bool isYesterdayByMs(int ms, int locMs) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(ms),
        DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// is Week.
  /// 是否是本周.
  static bool isWeek(int? ms, {bool isUtc = false, int? locMs}) {
    if (ms == null || ms <= 0) {
      return false;
    }
    DateTime _old = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
    DateTime _now;
    if (locMs != null) {
      _now = DateUtil.getDateTimeByMs(locMs, isUtc: isUtc);
    } else {
      _now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }

    DateTime old =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _old : _now;
    DateTime now =
        _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _now : _old;
    return (now.weekday >= old.weekday) &&
        (now.millisecondsSinceEpoch - old.millisecondsSinceEpoch <=
            7 * 24 * 60 * 60 * 1000);
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqualByMs(int ms, int locMs) {
    return yearIsEqual(DateTime.fromMillisecondsSinceEpoch(ms),
        DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYear(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  /// 是否 几天之前
  /// DateTime 判断时间 locDateTime 本地当前时间 dayNum 天数
  static bool isSomeDayAgo(
      DateTime dateTime, DateTime locDateTime, int dayNum) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      return spDay < dayNum;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  static String getFriendlyTimeSpanBySecond(int second) {
    int sysSecond = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    int span = sysSecond - second;

    if (span < 0) return " ";
    if (span < 5) {
      return "刚刚";
    } else if (span < 60) {
      return "$span秒前";
    } else if (span < 3600) {
      return "${span ~/ 60}分钟前";
    } else if (span < 86400) {
      return "${span ~/ 3600}小时前";
    } else {
      return "${span ~/ 86400}天前";
    }
  }

  /// 根据某天获取所属月的最后一天是几号
  static int getLastDayOfMonth(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;

    if (isLeapYearByYear(year) && month == 2) {
      day = 29;
    } else {
      day = MONTH_DAY[month]!;
    }

    return day;
  }

  ///  根据某天获取所属第几季度
  static int getQuarterOfYear(DateTime dateTime) {
    int quarter = 1;
    int month = dateTime.month;
    if (0 < month && month < 4) {
      quarter = 1;
    } else if (3 < month && month < 7) {
      quarter = 2;
    } else if (6 < month && month < 10) {
      quarter = 3;
    } else if (9 < month && month < 13) {
      quarter = 4;
    }

    return quarter;
  }

  /// 转换yyyy-MM-DD => MM.DD
  static String getMdTimeStrMsByTimeStr(String dateString) {
    int? milliseconds = getDateMsByTimeStr(dateString);

    if (milliseconds == null) {
      if (dateString.contains('-')) {
        return dateString.replaceAll('-', '.');
      }

      return dateString;
    }

    late String newDateString =
        formatDateMs(milliseconds, format: DateFormats.po_mo_d);

    return newDateString;
  }

  /// 转换yyyy-MM-DD => yyyy.MM.DD
  static String getYmdTimeStrMsByTimeStr(String dateString, {String? format}) {
    int? milliseconds = getDateMsByTimeStr(dateString);

    if (milliseconds == null) return dateString;

    late String newDateString =
        formatDateMs(milliseconds, format: format ?? DateFormats.po_y_mo_d);

    return newDateString;
  }

  ///时间戳- 几天前
  static int someDaysBefore(DateTime date) {
    int _date = DateUtil.getNowDateMs() - date.millisecondsSinceEpoch;

    int _days = _date ~/ RelativeDateFormat.ONE_DAY;

    int _hours =
        (_date % RelativeDateFormat.ONE_DAY) ~/ RelativeDateFormat.ONE_HOUR;

    if (_hours > 0) {
      _days += 1;
    }

    return _days;
  }

  ///时间戳- 几天后
  static int someDaysAfter(DateTime date) {
    int _date = date.millisecondsSinceEpoch - DateUtil.getNowDateMs();

    int _days = _date ~/ RelativeDateFormat.ONE_DAY;

    int _hours =
        (_date % RelativeDateFormat.ONE_DAY) ~/ RelativeDateFormat.ONE_HOUR;

    if (_hours > 0) {
      _days += 1;
    }

    return _days;
  }
}

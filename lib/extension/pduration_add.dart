import 'package:app_kit/core/kt_export.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';

extension AddPDuration on PDuration {
  String get ymdhms {
    String date =
        '${year?.to2Bit}-${month?.to2Bit}-${day?.to2Bit} ${hour?.to2Bit}:${minute?.to2Bit}:${second?.to2Bit}';
    return date;
  }

  String get ymdhm {
    String date =
        '${year?.to2Bit}-${month?.to2Bit}-${day?.to2Bit} ${hour?.to2Bit}:${minute?.to2Bit}';
    return date;
  }

  String get ymd {
    String date = '${year?.to2Bit}-${month?.to2Bit}-${day?.to2Bit}';
    return date;
  }

  String get ym {
    String date = '${year?.to2Bit}-${month?.to2Bit}';
    return date;
  }

  String get y {
    String date = '${year?.to2Bit}';
    return date;
  }
}

extension AddDateTime on DateTime {
  static Map<String, dynamic> startEndTime() {
    DateTime da = DateTime.now();
    DateTime da2 = da.subtract(Duration(
        days: 3, hours: da.hour, minutes: da.minute, seconds: da.second));
    Map<String, dynamic> map = {
      'startTime': da2.ymd,
      'endTime': da.ymd,
    };
    return map;
  }

  String get ymdhms {
    String date =
        '${year.to2Bit}-${month.to2Bit}-${day.to2Bit} ${hour.to2Bit}:${minute.to2Bit}:${second.to2Bit}';
    return date;
  }

  String get ymdhm {
    String date =
        '${year.to2Bit}-${month.to2Bit}-${day.to2Bit} ${hour.to2Bit}:${minute.to2Bit}';
    // String date = '$year-$month-$day $hour:$minute';
    return date;
  }

  String get ymd {
    String date = '${year.to2Bit}-${month.to2Bit}-${day.to2Bit}';
    // String date = '$year-$month-$day';
    return date;
  }

  String get ym {
    String date = '${year.to2Bit}-${month.to2Bit}';
    // String date = '$year-$month';
    return date;
  }

  String get md {
    String date = '${month.to2Bit}-${day.to2Bit}';
    // String date = '$year-$month';
    return date;
  }

  String get hms {
    String date = '${hour.to2Bit}:${minute.to2Bit}:${second.to2Bit}';
    return date;
  }
}

extension AddDateMode on DateMode {
  static DateMode mode(String code) {
    DateMode mo = DateMode.YMDHM;
    // time_ym 一段时间选择，年月
    // time2_ym 两段时间选择，年月
    // time_ymd 一段时间选择，年月日
    // time2_ymd 两段时间选择，年月日
    // time_ymdhm 一段时间选择，年月日时分
    switch (code) {
      case 'time_y':
        {
          mo = DateMode.Y;
        }
        break;
      case 'time_ym':
      case 'time2_ym':
        {
          mo = DateMode.YM;
        }
        break;
      case 'time_ymd':
      case 'time2_ymd':
        {
          mo = DateMode.YMD;
        }
        break;
      case 'time_ymdhm':
        {
          mo = DateMode.YMDHM;
        }
        break;
      default:
        {}
    }
    return mo;
  }
}

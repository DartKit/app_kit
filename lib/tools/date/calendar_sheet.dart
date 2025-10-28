import 'package:app_kit/core/kt_export.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSheet extends StatefulWidget {
  final bool isBasice;
  final DateTime startTime;
  final DateTime endTime;
  final Function(DateTime) onConfir;
  final Function(DateTime, DateTime)? onWeekConfir;
  const CalendarSheet(
      {super.key,
      required this.isBasice,
      required this.startTime,
      required this.endTime,
      required this.onConfir,
      this.onWeekConfir});

  @override
  State<CalendarSheet> createState() => _CalendarSheetState();
}

class _CalendarSheetState extends State<CalendarSheet> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late DateTime _kFirstDay;
  late DateTime _kLastDay;

  @override
  void initState() {
    super.initState();
    final kToday = DateTime.now();
    _kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    _kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.r),
        topRight: Radius.circular(14.r),
      ),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20.h),
            widget.isBasice ? _basiceWidget() : _calendarWidget(),
            SizedBox(height: 10.h),
            // _buttonWidget(
            //   '确定',
            //   ontap: () {
            //     if (_selectedDay == null && widget.isBasice) {
            //       BotToast.showText(text: '请选择日期');
            //       return;
            //     }
            //     if (!widget.isBasice &&
            //         (_rangeStart == null || _rangeEnd == null)) {
            //       BotToast.showText(text: '请选择日期');
            //       return;
            //     }

            //     widget.isBasice
            //         ? widget.onConfir(_selectedDay!)
            //         : widget.onWeekConfir!(_rangeStart!, _rangeEnd!);
            //     router.pop();
            //   },
            // ),
            _buttonWidget(
              '取消',
              ontap: () {
                // router.pop();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _buttonWidget(String title, {required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border(top: BorderSide(width: 1, color: Color.fromRGBO(220, 220, 220, 1)))),
        child: Text(title, style: TextStyle(color: C.black,fontSize: 16.r, fontWeight: AppFont.medium))),
    );
  }

  _basiceWidget() {
    final DateTime today = DateTime.now();
    final DateTime todayWithoutTime =
        DateTime(today.year, today.month, today.day);

    return TableCalendar(
      locale: 'zh_CN',
      firstDay: _kFirstDay,
      lastDay: _kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }

        Future.delayed(const Duration(milliseconds: 200), () {
          // router.pop();
          Navigator.pop(context);
          Future.delayed(const Duration(milliseconds: 300), () {
            widget.onConfir(_selectedDay!);
          });
        });
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      enabledDayPredicate: (day) {
        // 转换为仅包含年月日的日期（清除时间部分，避免时间影响判断）
        final DateTime dayWithoutTime = DateTime(day.year, day.month, day.day);

        // 今日及之后的日期可点击，之前的不可点击
        return dayWithoutTime.isAfter(todayWithoutTime) ||
            isSameDay(dayWithoutTime, todayWithoutTime);
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
    );
  }

  _calendarWidget() {
    return TableCalendar(
      locale: 'zh_CN',
      firstDay: _kFirstDay,
      lastDay: _kLastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null;
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _focusedDay = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
        });

        if (end != null) {
          Future.delayed(const Duration(milliseconds: 300), () {
            // router.pop();
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 300), () {
              widget.onWeekConfir!(_rangeStart!, _rangeEnd!);
            });
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
    );
  }
}

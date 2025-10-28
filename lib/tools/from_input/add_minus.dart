import 'dart:async';
import 'package:app_kit/core/kt_export.dart';
import '../../../core/app_font.dart';
import '../../../models/core/from_template.dart';
import '../../utils/input_formatter.dart';

class AddMinusInput extends StatefulWidget {
  AddMinusInput(
    this.o, {
    super.key,
    this.fa,
    this.onChanged,
  });
  FromTemplateList o;
  FromTemplateList? fa;
  Function? onChanged;

  @override
  State<AddMinusInput> createState() => _AddMinusInputState();
}

class _AddMinusInputState extends State<AddMinusInput> {
  late StreamSubscription<bool> keyboardSubscription;
  final TextEditingController _vcInput = TextEditingController();
  final FocusNode _fo = FocusNode();
  double min = 0.0, max = 0.0, gap = 1.0;
  String tip = '';
  bool _negative = false;

  @override
  void didUpdateWidget(covariant AddMinusInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (mounted) setState(() {});
    // logs('---widget.o.value--${widget.o.value}---oldWidget:--${oldWidget.o.value}');
    logs(
        '---widget.o.is_required--${widget.o.is_required}---oldWidget:--${oldWidget.o.is_required}');
    // logs('---fa_mo.score--:${widget.fa?.score}---fa_mo?.max_score--:${widget.fa?.max_score}');
    // logs('---oldWidget.score--:${oldWidget.fa?.score}---fa_mo?.max_score--:${oldWidget.fa?.max_score}');
    _reset();
    Future.delayed(Duration(milliseconds: 1000), () {
      // _check();
    });

    // if(widget.o.is_required != oldWidget.o.is_required) if (mounted) setState(() {});
    // logs('---widget.text--${widget.text}---oldWidget.text--${oldWidget.text}');
  }

  Future<void> _reset() async {
    _vcInput.text = widget.o.value ?? (widget.fa != null ? '' : '0');

    logs('---_vcInput.text--${_vcInput.text}');
    if (widget.o.url.urlQuery().containsKey('is_double'))
      gap = widget.o.url.urlQuery()['is_double'].toString().toDouble;
    _negative = widget.o.url.contains('_negative');
    if (widget.fa != null) {
      if (widget.fa!.score.isNotEmpty) min = widget.fa!.score.toDouble.abs();
      if (widget.fa!.max_score.isNotEmpty)
        max = widget.fa!.max_score.toDouble.abs();
      tip = '${min > 0 ? '$min' : ''}${max > 0 ? '~$max' : ''}';
    }

    if (widget.o.url.urlQuery().containsKey('_fill_key')) {
      var fill_key = widget.o.url.urlQuery()['_fill_key'].toString();
      if ((widget.fa?.toJson().containsKey(fill_key) == true) &&
          (widget.fa?.score.isNotEmpty == true)) {
        logs(
            '--- widget.fa?.score--${widget.fa?.score}---_vcInput.text--${_vcInput.text}');
        if (widget.o.value != null) {
          _vcInput.text = widget.fa!.score.toDouble.abs().toString();
          _onChanged();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _reset();
    _fo.addListener(() {
      if (_fo.hasFocus) {
      } else {
        _check();
      }
    });
  }

  Future<void> _check() async {
    if (_vcInput.text.isEmpty || _vcInput.text == '0') return;

    var v = d(_vcInput.text).toDouble();
    logs('---v000--$v---min--$min---_vcInput.text--${_vcInput.text}');
    if (v < min) {
      kitPopText('小于最小值了');
      _vcInput.text = min.toString();
    } else if ((max > 0) && (v > max)) {
      kitPopText('大于最大值了');
      _vcInput.text = max.toString();
    }

    if (v.toString() != _vcInput.text) _onChanged();
    logs('---v111--$v---min--$min---_vcInput.text--${_vcInput.text}');
  }

  Future<void> _onChanged() async {
    if (widget.onChanged != null)
      widget.onChanged!(_vcInput.text.isEmpty
          ? null
          : (_negative ? '-' : '') + _vcInput.text);
  }

  @override
  void dispose() {
    // keyboardSubscription.cancel();
    _fo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1.r, color: C.line.withOpacity(0.5)),
          color: C.white),
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      child: Row(
        children: [
          if (widget.o.is_required.yes)
            Text(
              '∗',
              style: TextStyle(
                  color: C.red, fontSize: 16.r, fontWeight: FontWeight.w700),
            ),
          Expanded(
              child: Text(
            widget.o.title + (max > 0 ? '($tip)' : ''),
            maxLines: 3,
            style: TextStyle(
                fontSize: 16.r,
                fontWeight: FontWeight.w700,
                color: C.deepBlack),
          ).marginOnly(right: 10.r)),
          InkWell(
            onTap: () {
              var doub = _vcInput.text.toDouble;
              if (doub - gap < min) {
                kitPopText('小于最小值了');
                return;
              }
              String v1 = (d(doub.toString()) - d(gap.toString())).toString();
              _vcInput.text = v1;
              _onChanged();
            },
            child: Container(
              width: 28.r,
              height: 28.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Color(0xFFE5F9EC)),
              child: Icon(
                Icons.remove,
                size: 12.r,
                color: C.mainColor,
              ),
            ),
          ),
          Container(
              constraints: BoxConstraints(minWidth: 40.r),
              child: SizedBox(
                width: 50.r,
                height: 50.r,
                child: TextField(
                  controller: _vcInput,
                  focusNode: _fo,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[0-9.]")), //只允许输入小数
                    // FilteringTextInputFormatter.allow(RegExp(r'[1-9]{1}[0-9.]*')), //只允许输入小数。第一位不能为0。0.1输入无效
                    NumberTextInputFormatter(digit: 1), //限制小数位数
                  ],
                  style: TextStyle(
                    color: C.keyfont,
                    fontSize: 15.r,
                    fontWeight: AppFont.heavy,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入',
                    hintStyle: TextStyle(
                      color: C.deepGrey,
                      fontSize: 11.r,
                      fontWeight: AppFont.medium,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  onChanged: (x) {
                    _onChanged();
                  },
                  onSubmitted: (x) {},
                  onTapOutside: (x) {},
                ),
              )),
          InkWell(
            onTap: () {
              var doub = _vcInput.text.toDouble;
              if ((max > 0) && (doub + gap > max)) {
                kitPopText('大于最大值了');
                _vcInput.text = max.toString();
                return;
              }
              var v1 = d(doub.toString()) + d(gap.toString());
              if (v1.toDouble() < min) v1 = d(min.toString());
              _vcInput.text = v1.toString();
              _onChanged();
            },
            child: Container(
              width: 28.r,
              height: 28.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Color(0xFFE5F9EC)),
              child: Icon(
                Icons.add,
                size: 12.r,
                color: C.mainColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

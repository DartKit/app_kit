import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/extension/time.dart';
import '../../../models/core/from_template.dart';

// 问题详情 申诉详情 打标签用到
class PickBox extends StatefulWidget {
  FromTemplateList mo;
  int patrol_type_id;
  Function call;
  bool isDraft;
  // Function callSch;
  PickBox({super.key, required this.mo, required this.patrol_type_id, required this.call, this.isDraft = false});

  @override
  State<PickBox> createState() => _PickBoxState();
}

class _PickBoxState extends State<PickBox> {
  List<FromTemplateList> _ls = [];
  bool _box_one = false;
  FromTemplateList _boxOneMo = FromTemplateList();
  String _hid_nil = '_hid_nil';
  var _filled = false;

  @override
  void didUpdateWidget(covariant PickBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // logs('---widget.mo.url--${widget.mo.url}---oldWidget.mo.url--${oldWidget.mo.url}');
    if (widget.mo.url != oldWidget.mo.url) {
      Future.delayed(Duration(milliseconds: 1000), () {
        widget.mo.value_id = 0;
        widget.call(null);
      });
      _req();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    logs('--widget.mo.value--:${widget.mo.value}');
    _req();
  }

  void _req() async {
    var url = widget.mo.url;
    if (widget.patrol_type_id > 0) url.addPrams('type=${widget.patrol_type_id}&patrol_type_id=${widget.patrol_type_id}');
    if (widget.mo.url.contains('_box_one')) _box_one = true;
    logs('---url-111-$url');

    FromTemplateList? res = await KitService.fire<FromTemplateList>(url,isMoInAppKit: true);
    if (res != null) {
      _ls = res.list;
      if (widget.mo.value_id > 0 && _box_one) {
        //选中已经打卡的上班
        List<FromTemplateList> l1 = [];
        _ls.forEach((mo) {
          if (widget.mo.value_id == mo.id) {
            mo.select = true;
            _boxOneMo = mo;
            l1.add(mo);
            Future.delayed(Duration(milliseconds: 1000), () {
              _checkBox();
            });
          }
        });
        if (l1.isNotEmpty) _ls = l1;
      } else {
        if (widget.mo.value.runtimeType.toString().startsWith('List')) {
          logs('---widget.mo.value--${widget.mo.value}');
          String ids = (widget.mo.value as List).map((e) => e).toList().join('_');
          logs('---ids--$ids');
          _ls.forEach((mo) {
            if (ids.contains(mo.id.toString())) {
              mo.select = true;
            }
          });
        }
      }
      if ((isNil(widget.mo.value_id)) && (_filled == false) && widget.mo.url.contains('_fill') && (widget.isDraft == false)) {
        var fillv = widget.mo.url.urlQuery()['_fill'];
        _filled = true;
        _ls.forEach((mo) {
          if (mo.id.toString() == fillv) mo.select = true;
          _checkBox();
        });
      }

      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_ls.isEmpty && widget.mo.url.contains(_hid_nil))
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (widget.mo.is_required.yes)
                    Text(
                      '∗',
                      style: TextStyle(color: C.red, fontSize: 16.r, fontWeight: FontWeight.w700),
                    ),
                  BlackText(
                    widget.mo.title,
                    fontSize: 16.r,
                  ).paddingSymmetric(vertical: 7.r),
                ],
              ),
              _ls.isEmpty
                  ? CoText14('暂无数据，请联系管理员添加。')
                  : Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 10.r,
                            spacing: 10.r,
                            children: _ls.asMap().entries.map((e) {
                              return _cell(e.key);
                            }).toList(),
                          ),
                        ),
                      ],
                    )
            ],
          );
  }

  void _checkBox() {
    List ls = [];
    for (var o in _ls) {
      if (o.select) {
        ls.add(o.user_id.ifNil(o.id).ifNil(o.value));
      }
    }
    // logs('---ls--${ls}');
    widget.call((_box_one && ls.isNotEmpty) ? ls.first : ls);
  }

  Widget _cell(index) {
    FromTemplateList mo = _ls[index];
    return InkWell(
      onTap: () {
        mo.select = !mo.select;
        if (_box_one) {
          if (_boxOneMo.id > 0) _boxOneMo.select = !_boxOneMo.select;
          _boxOneMo = mo;
        }
        _checkBox();
        if (mounted) setState(() {});
      },
      child: Container(
          width: (Get.width - 85.r) / 2,
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.r), color: mo.select ? C.mainColor : C.lightGrey),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.r),
                child: CoText14(
                  mo.name
                      .ifNil(mo.label)
                      .ifNil(
                        mo.title,
                      )
                      .ifNil(mo.lable),
                  color: C.white,
                ),
              ),
              Top2Text(
                mo.start_time.reduceMinute(mo.start_interval),
                top: 0.0,
                tip: '开始：',
                color: C.lightBlack.withOpacity(0.8),
              ),
              Top2Text(
                mo.end_time.addMinute(mo.end_interval),
                top: 0.0,
                tip: '结束：',
                color: C.lightBlack.withOpacity(0.8),
              ),
            ],
          )),
    );
  }
}

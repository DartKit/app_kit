
import '../../../core/kt_export.dart';
import '../../../models/core/from_template.dart';

class DeductionList extends StatefulWidget {
  FromTemplateList mo;
  Function call;
  DeductionList({super.key, required this.mo, required this.call});

  @override
  State<DeductionList> createState() => _DeductionListState();
}

class _DeductionListState extends State<DeductionList> {
  bool _all = true;
  List<FromTemplateList>? _lsBackScore; //转合格退回分数

  @override
  void initState() {
    super.initState();
    logs('---widget.mo.url--${widget.mo.url}');
    Map<String, dynamic> map = widget.mo.url.urlQuery();
    logs('---map--$map');
    _all = map['_select'] == '0' ? false : true;
    _req();
  }

  // 移交对象
  void _req() async {
    var url = widget.mo.url;
    FromTemplateList? res = await KitService.fire<FromTemplateList>(url,isMoInAppKit: true);
    if (res != null) {
      _checkAll();
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7
                  ),
                  Row(
                    children: [
                      if (widget.mo.is_required.yes)
                        Text(
                          '∗',
                          style: TextStyle(
                              color: C.red,
                              fontSize: 16.r,
                              fontWeight: FontWeight.w700)
                        ),
                      BlackText(
                        '选择退还的评分',
                        fontSize: 15.r,
                        color: C.deepBlack
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25.r,
                        height: 30.r,
                        child: Checkbox(
                            value: _all,
                            onChanged: (x) {
                              _all = x ?? false;
                              _checkAll();
                              if (mounted) setState(() {});
                            }),
                      ),
                      BlackText('全选')
                    ],
                  ),
                ],
              ),
      ],
    );
  }

  void _checkAll() {
    List<int> ls = [];
    for (var o in _lsBackScore!) {
      if (_all) {
        o.select = true;
        ls.add(o.id);
      } else {
        o.select = false;
      }
    }
    widget.call(ls);
  }

  void _checkBox() {
    bool f = true;
    List<int> ls = [];
    for (var o in _lsBackScore!) {
      if (o.select) {
        ls.add(o.id);
      } else {
        f = false;
      }
    }
    widget.call(ls);
    _all = f;
  }

  Widget _cell(index) {
    FromTemplateList mo = _lsBackScore![index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 25.r,
          height: 30.r,
          child: Checkbox(
              value: mo.select,
              onChanged: (x) {
                mo.select = x ?? false;
                _checkBox();
                if (mounted) setState(() {});
              }),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Top2Text(
                mo.reason,
                tip: '评分理由：',
                color: C.mainColor,
              ),
              Top2Text(
                mo.remark,
                tip: '评分备注：',
                color: C.deepGrey,
              ),
              Top2Text(
                mo.score,
                tip: '扣分分数：',
                color: C.deepGrey,
              ),
              Top2Text(
                mo.op_user,
                tip: '操作人员：',
                color: C.deepGrey,
              ),
              Top2Text(
                mo.op_time,
                tip: '操作时间：',
                color: C.deepGrey,
              ),
            ],
          ),
        )
      ],
    );
  }
}

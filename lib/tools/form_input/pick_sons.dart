import 'package:app_kit/core/kt_export.dart';

import '../../../models/core/from_template.dart';

class PickSonsPage extends StatefulWidget {
  FromTemplateList mo;
  PickSonsPage({
    super.key,
    required this.mo,
    this.patrol_type_id = 0,
  });
  int patrol_type_id;
  @override
  State<PickSonsPage> createState() => _PickSonsPageState();
}

const String tip = '点上级可重选';

class _PickSonsPageState extends State<PickSonsPage> {
  bool setBg = false;
  int _sort_id = -1;
  int _num = 0;
  List<SelectTag> _tags = [SelectTag(name: '请选择')];
  bool _isDone = true;
  bool _hasPick = false;
  List<String> _score_ids = [];
  List<FromTemplateList> mods = [];
  var canSelMore = false;

  @override
  void initState() {
    super.initState();
    if (widget.mo.list.isNotEmpty) {
      _tags[_num].ls = widget.mo.list;
      logs('---widget.mo.list--${widget.mo.list}');
    } else {
      _scoreSortList();
    }
    canSelMore = widget.mo.url.contains('more=1');
    Future.delayed(Duration(milliseconds: 500), () {
      setBg = true;
      if (mounted) setState(() {});
    });
  }

  Future<void> _scoreSortList() async {
    Map<String, dynamic> map = {
      if (widget.patrol_type_id > 0) 'patrol_type_id': widget.patrol_type_id,
      'status': 80 // 40 隐藏 80 显示
    };
    FromTemplate? res =
        await KitService.fire<FromTemplate>(widget.mo.url, query: map,isMoInAppKit: true);
    if (res != null) {
      _tags[_num].ls = res.list;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: setBg == true ? Colors.black45 : C.transparent,
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            _tags.isNotEmpty ? _pop() : Container(),
          ],
        ));
  }

  Widget _pop() {
    return SizedBox(
      height: ScreenUtil().screenHeight / 8 * 5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: C.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlackText(widget.mo.title),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              gradient: LinearGradient(
                                  //渐变位置
                                  begin: Alignment.centerLeft, //右上
                                  end: Alignment.centerRight, //左下
                                  stops: const [0.0, 1.0], //[渐变起始点, 渐变结束点]
                                  colors:  [C.mainColor, C.white])),
                        )
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: _tags.asMap().entries.map((e) {
                        return _actionBtn(e.key, e.value);
                      }).toList(),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(top: 10),
                      color: C.mainColor,
                    ),
                    Expanded(child: _list(_tags[_num])),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(i, SelectTag tag) {
    return InkWell(
      onTap: () {
        _num = i;
        _tags.removeRange(i + 1, _tags.length);
        _sort_id = tag.id.toInt;
        if (mounted) setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(left: 0, top: 10, bottom: 0, right: 10),
        child: Text(
          (i != 0 ? '>  ' : '') + tag.name,
          maxLines: 2,
          style: TextStyle(
              color: tag.name.contains('点')
                  ? C.deepGrey
                  : C.mainColor.withOpacity(0.8),
              fontSize: 16,
              fontWeight: AppFont.bold),
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.close,
              color: C.deepGrey,
            ),
          ),
        ),
        Text(
          widget.mo.hint,
          style: TextStyle(
              color: C.black, fontSize: 18, fontWeight: AppFont.medium),
        ),
        InkWell(
          onTap: () {
            if (_hasPick) _backDone();
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.done_outline_rounded,
              color: _hasPick ? C.mainColor : C.transparent,
            ),
          ),
        ),
      ],
    );
  }

  void _backDone() {
    setState(() {
      setBg = !setBg;
      String name = '';
      _score_ids.clear();
      _tags.asMap().entries.map((e) {
        name += e.value.name != tip
            ? '${(e.key != 0 ? ' > ' : '')}${e.value.name}'
            : '';
        _score_ids.add(e.value.id.toString());
      }).toList();

      Map<String, dynamic> map = {
        'id': _sort_id,
        'name': name,
        'f': _isDone,
        if (_tags.isNotEmpty) 'time': _tags.last.time,
      };

      logs('---map--$map');
      Get.back(result: map);
    });
  }

  Widget _list(SelectTag tag) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemBuilder: (BuildContext context, int index) {
        return _cell(index, tag);
      },
      itemCount: tag.ls!.length,
    );
  }

  Widget _cell(int i, SelectTag tag) {
    FromTemplateList v = tag.ls![i];
    return InkWell(
      onTap: () {
        _tags[_num].name = (v.title.add(v.score)).ifNil(v.name);
        _tags[_num].id = v.id.toString();
        _tags[_num].index = i;
        _tags[_num].time = v.time;
        _hasPick = true;
        // // 如果是区级巡查。分类只有一级。没有叶子节点。
        _sort_id = v.id;
        if (v.children.isNotEmpty) {
          _num += 1;
          _tags.add(SelectTag());
          _tags[_num].ls = v.children;
          if (mounted) setState(() {});
        } else {
          if (mounted) setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 6, bottom: 6),
        child: Column(
          children: [
            const Divider(height: 0.5, color: C.transparent),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    v.name.isNotEmpty ? v.name : v.title + '   ' + v.score,
                    style: TextStyle(
                        color:
                            _tags[_num].index == i ? C.mainColor : C.deepGrey,
                        fontSize: 16,
                        fontWeight: _tags[_num].index == i
                            ? AppFont.bold
                            : AppFont.regular),
                  ),
                ),
                Icon(
                  Icons.done,
                  color: _tags[_num].index == i ? C.mainColor : C.transparent,
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 7.0, bottom: 0.0),
              child: const Divider(height: 0.5, color: C.lightBlack),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTag {
  String id;
  String name;
  String time;
  int index;
  List<FromTemplateList>? ls = []; //数据源
  SelectTag(
      {this.id = '',
      this.time = '',
      this.name = tip,
      this.index = -1,
      this.ls = const []});
}

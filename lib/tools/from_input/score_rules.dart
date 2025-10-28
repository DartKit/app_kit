import 'package:app_kit/core/kt_export.dart';

import '../../../models/core/from_template.dart';

class ScoreRulesPage extends StatefulWidget {
  FromTemplateList mo;
  List<FromTemplateList>? ais;
  Map<String, dynamic> fas;
  int patrol_type_id;
  int work_id;
  bool isHot;
  ScoreRulesPage(
      {super.key,
      required this.mo,
      required this.patrol_type_id,
      required this.work_id,
      this.ais,
      this.isHot = false,
      required this.fas});

  @override
  State<ScoreRulesPage> createState() => _ScoreRulesPageState();
}

const String tip = '点上级可重选';

class _ScoreRulesPageState extends State<ScoreRulesPage> {
  bool setBg = false;
  int _sort_id = -1;
  int _num = 0;
  List<SelectTag> _tags = [SelectTag(name: '请选择')];
  // int _parent_id = 0;
  bool _isDone = false;
  // bool _hasPick = false;
  // bool _isEnd = false;
  FromTemplateList _index = FromTemplateList();
  List<String> _score_ids = [];
  List<FromTemplateList> mods = [];

  @override
  void initState() {
    super.initState();
    if (widget.ais == null) {
      if (widget.mo.dats.isNotEmpty) {
        _tags[_num].ls = widget.mo.dats;
      } else {
        _scoreSortList();
      }
    } else {
      _tags[_num].ls = widget.ais!;
    }
    Future.delayed(Duration(milliseconds: 500), () {
      setBg = true;
      if (mounted) setState(() {});
    });
  }

  Future<void> _scoreSortList() async {
    Map<String, dynamic> map = {
      'status': 80, // 40 隐藏 80 显示
    };

    if (widget.mo.url.contains('_fill_fas')) map.addAll(widget.fas);
    List<FromTemplateList>? res =
        await CoService.fireGet<List<FromTemplateList>>(widget.mo.url, params: map);
    if (res != null) {
      _tags[_num].ls = res;
      if (mounted) setState(() {});
    }
  }

  /*
  Future<void> _evaluateList() async {
    Map<String,dynamic> map = {widget.mo.name:_parent_id};
    FromTemplate? res = await  CoService.fire<FromTemplate>(widget.mo.children.first.url,params: map );
    if (res != null) {
      _tags[_num].ls = res.list;
      if (mounted) setState(() {});
    }
  }
   */

  @override
  Widget build(BuildContext context) {
    return Container(
        color: setBg == true ? Colors.black45 : C.transparent,
        child: Column(
          children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      if (widget.ais != null) {
                        Get.back();
                      }
                    },
                    child: Container(
                      color: C.transparent,
                    ))),
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
                                  colors: [C.mainColor, C.white])),
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
          widget.ais != null
              ? ((widget.isHot ? '推荐如下热门' : 'AI检测该图可能有如下') + widget.mo.title)
              : widget.mo.hint,
          style: TextStyle(
              color: C.black, fontSize: 18, fontWeight: AppFont.medium),
        ),
        Offstage(
          // offstage: !_hasPick,
          offstage: false,
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.done_outline_rounded,
                color: C.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _backDone() {
    setBg = !setBg;
    String name = '';
    _score_ids.clear();

    _tags.asMap().entries.map((e) {
      name += e.value.name != tip
          ? '${(e.key != 0 ? ' > ' : '')}${e.value.name}'
          : '';
      _score_ids.add(e.value.id.toString());
    }).toList();

    logs('---score_sort_item---:$_score_ids');
    Map<String, dynamic> map = {
      'id': _sort_id,
      'name': name,
      'f': _isDone,
      'max_score': _index.max_score,
      'score': _index.score,
      if (_tags.isNotEmpty) 'time': _tags.last.time,
    };

    Get.back(result: map);
    if (mounted) setState(() {});
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
        _sort_id = v.id;
        if (v.children.isNotEmpty) {
          _num += 1;
          // _parent_id = v.id;
          _tags.add(SelectTag());
          _tags[_num].ls = v.children;
          if (mounted) setState(() {});
        } else {
          _isDone = true;
          _index = v;
          if (mounted) setState(() {});
          _backDone();
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

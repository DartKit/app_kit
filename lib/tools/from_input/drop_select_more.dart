import 'package:app_kit/core/kt_export.dart';

import '../../../models/core/from_template.dart';

class DropSelectMore extends StatefulWidget {
  FromTemplateList mo;
  DropSelectMore({
    super.key,
    required this.mo,
    this.patrol_type_id = 0,
  });
  int patrol_type_id;
  @override
  State<DropSelectMore> createState() => _DropSelectMoreState();
}

// const String tip = '点上级可重选';

class _DropSelectMoreState extends State<DropSelectMore> {
  bool setBg = false;
  int _num = 0;
  bool _isDone = true;
  bool _hasPick = false;
  late List<FromTemplateList> ls = [];
  // List<String> _score_ids = [];
  // List<FromTemplateList> mods = [];
  // var canSelMore = false;

  @override
  void initState() {
    super.initState();
    if (widget.mo.list.isNotEmpty) {
      ls = widget.mo.list;
      logs('---widget.mo.list--${widget.mo.list}');
    } else {
      _scoreSortList();
    }
    // canSelMore = widget.mo.url.contains('more=1');
    Future.delayed(Duration(milliseconds: 500), () {
      setBg = true;
      if (mounted) setState(() {});
    });
  }

  Future<void> _scoreSortList() async {
    Map<String, dynamic> map = {if (widget.patrol_type_id > 0) 'patrol_type_id': widget.patrol_type_id, 'status': 80};
    if (widget.mo.url.contains('_rsp')) {
      List<FromTemplateList>? res = await CoService.fire<List<FromTemplateList>>(widget.mo.url, query: map, key: widget.mo.url.urlQuery()['_rsp'] ?? '');
      if (res != null) {
        ls = res;
        if (mounted) setState(() {});
      }
    } else {
      FromTemplate? res = await CoService.fire<FromTemplate>(widget.mo.url, query: map);
      if (res != null) {
        ls = res.list;
        if (mounted) setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: setBg == true ? Colors.black45 : C.transparent,
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            ls.isNotEmpty ? _pop() : Container(),
          ],
        ));
  }

  Widget _pop() {
    return SizedBox(
      height: Get.height / 8 * 5,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)), color: C.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.r),
                child: _list(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: Get.back,
          child: Container(padding: EdgeInsets.all(15.r), child: Icon(Icons.close, color: C.deepGrey)),
        ),
        Text(widget.mo.hint, style: TextStyle(color: C.black, fontSize: 18, fontWeight: AppFont.medium)),
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
    setBg = !setBg;
    String name = '';
    // _score_ids.clear();
    // _tags.asMap().entries.map((e) {
    //   name += e.value.name != tip ? '${(e.key != 0 ? ' > ' : '')}${e.value.name}' : '';
    //   // _score_ids.add(e.value.id.toString());
    // }).toList();

    Map<String, dynamic> map = {
      'f': _isDone,
      'ids': ls.where((element) => element.select).map((e) => e.id).toList(),
      'names': ls.where((element) => element.select).map((e) => e.label.ifNil(e.title).ifNil(e.name)).toList(),
    };

    logs('---map--$map');
    Get.back(result: map);
  }

  Widget _list() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemBuilder: (BuildContext context, int index) {
        return _cell(index);
      },
      itemCount: ls.length,
    );
  }

  Future<void> _checkHasPick() async {
    _hasPick = ls.any((element) => element.select);
    if (mounted) setState(() {});
  }

  Widget _cell(int i) {
    FromTemplateList v = ls[i];
    return InkWell(
      onTap: () {
        v.select = !v.select;
        _checkHasPick();
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
                (v.name).ifNil(v.label).ifNil(v.title.add(v.score)),
                    // v.name.isNotEmpty ? v.name : v.title + '   ' + v.score,
                    style: TextStyle(color: v.select ? C.mainColor : C.deepGrey, fontSize: 16, fontWeight: v.select ? AppFont.bold : AppFont.regular),
                  ),
                ),
                Icon(Icons.done, color: v.select ? C.mainColor : C.transparent)
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


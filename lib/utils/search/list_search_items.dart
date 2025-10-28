import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/tools/cell/cell_form.dart';
import 'package:app_kit/tools/from_input/pick_sons.dart';
import 'package:app_kit/widgets/co_pickers.dart';
import 'package:app_kit/widgets/kit_views/kit_views.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';

import '../../../models/core/from_template.dart';
import '../../../models/core/sd_search.dart';
import 'search_list.dart';
import 'text_tag.dart';

extension AddList on List {
  Map<String, dynamic> keyVs() {
    Map<String, dynamic> map = {};

    for (SdSearch o in this) {
      switch (o.type) {
        case 'array':
        case 'array_one':
        case 'list':
        case 'list_one':
          {
            List<String> ls = [];
            for (var o in o.list) {
              if (o.select) ls.add(o.value.toString());
            }
            if (ls.isNotEmpty) map[o.name] = ls;
          }
          break;
        case 'arrayOne':
        case 'listOne':
          {
            List<String> ls = [];
            for (var o in o.list) {
              if (o.select) ls.add(o.value.toString());
            }
            if (ls.isNotEmpty) map[o.name] = ls.last;
          }
          break;
        case 'pick_sons':
          {
            if (o.select) map[o.name] = o.sel_value_id;
          }
          break;
        default:
          {
            for (var o in o.list) {
              logs('---o.sel_value--:${o.sel_value}-o.name--:${o.name}');
              if (o.sel_value.isNotEmpty) map[o.name] = o.sel_value;
            }
          }
      }
    }
    if (map.isNotEmpty) {
      logs('---map--$map');
    }
    return map;
  }
}

// 各个列表右上角的侧滑右边栏搜索筛选
class ListSearchItems extends StatefulWidget {
  const ListSearchItems({super.key, required this.item});
  final List<SdSearch> item;

  @override
  _ListSearchItemsState createState() => _ListSearchItemsState();
}

class _ListSearchItemsState extends State<ListSearchItems> {
  List<SdSearch> _ls = [];

  @override
  void initState() {
    super.initState();
    _ls = widget.item;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onKeywordChanged(int index, String keyword) {
    _ls[index].list[0].value = keyword;
    _ls[index].list[0].sel_value = keyword;
    _ls[index].list[0].select = true;
  }

  void _onClear(index) {
    _ls[index].sel_value = '';
    _ls[index].list[0].select = false;
  }

  void _onSelect({int index = 0, int key = 0}) {
    switch (_ls[index].type) {
      case 'array_one':
      case 'arrayOne':
      case 'list_one':
      case 'listOne':
        {
          for (var i = 0; i < _ls[index].list.length; ++i) {
            var o = _ls[index].list[i];
            if (key == i) continue;
            o.select = false;
          }
        }
        break;
      default:
        {}
    }
    _ls[index].list[key].select = !_ls[index].list[key].select;
    logs('---_ls[index].list[key].select-0-${_ls[index].list[key].select}');
    if (mounted) setState(() {});
  }

  void _onSelectTime({int index = 0, int key = 0, required PDuration item, mode = DateMode.YMD}) {
    String day = '${item.year?.to2Bit}-${item.month?.to2Bit}-${item.day?.to2Bit}';
    if (mode == DateMode.YM) {
      day = '${item.year?.to2Bit}-${item.month?.to2Bit}';
    }
    _ls[index].list[key].value = day;
    _ls[index].list[key].sel_value = day;
    _ls[index].list[key].select = true;
    if (mounted) setState(() {});
  }

  void _onReset() {
    for (var o in _ls) {
      o.sel_value = '';
      o.select = false;
      for (var o in o.list) {
        o.sel_value = '';
        o.select = false;
      }
    }
    if (mounted) setState(() {});
    Future.delayed(Duration(milliseconds: 500), () {
      Get.back(result: _ls);
    });
  }

  Future<void> onSubmit() async {
    bool hasChoose = false;
    for (var o in _ls) {
      if (o.select) {
        hasChoose = true;
        break;
      }
      for (var o in o.list) {
        if (o.select) {
          hasChoose = true;
          break;
        }
      }
    }
    // for(int i = 0; i < _ls.length; i++) {
    //   for(int k = 0; k < _ls[i].list.length; k++) {
    //     if (_ls[i].list[k].select) {
    //       hasChoose = true;
    //       break;
    //     }
    //   }
    // }
    if (isNil(!hasChoose, '请填写或选择搜索项')) return;
    // logs('---_ls_ls---:${jsonEncode(_ls)}');
    Get.back(result: _ls);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(color: C.deepGrey, fontSize: 16.0, fontWeight: FontWeight.w700);
    TextStyle hintStyle = TextStyle(color: C.lightGrey, fontSize: 14.0, fontWeight: FontWeight.w600);
    TextStyle textStyle = TextStyle(color: C.mainColor, fontSize: 14.0, fontWeight: FontWeight.w600);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0x97000000),
        body: Row(
          children: [
            SizedBox(
              width: 70.0,
              child: InkWell(
                onTap: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: C.lightBlack,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(top: 20.r, left: 10.r, right: 10.r),
                      child: ListView(
                        children: List.generate(_ls.length, (index) {
                          SdSearch mo = _ls[index];
                          switch (mo.type) {
                            case 'keyword':
                            case 'code':
                            case 'road':
                              return CellForm(
                                title: mo.title,
                                titleStyle: titleStyle,
                                hintStyle: hintStyle,
                                titlePadding: EdgeInsets.only(top: 0, bottom: 8),
                                text: mo.list.first.sel_value,
                                hintText: mo.list.first.tip,
                                clear: () {
                                  _onClear(index);
                                },
                                input: InputEvent(
                                  maxLines: 1,
                                  onChanged: (x) {
                                    _onKeywordChanged(index, x);
                                  },
                                ),
                              ).paddingOnly(bottom: 10.r);
                            case 'time_ymd': // 年月日
                            case 'time_ym': // 年月
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: CellForm(
                                      title: mo.title,
                                      showArrow: false,
                                      titleStyle: titleStyle,
                                      hintStyle: hintStyle,
                                      textStyle: textStyle,
                                      titlePadding: EdgeInsets.only(top: 0, bottom: 8),
                                      text: mo.list[0].sel_value,
                                      bgColor: C.white,
                                      hintText: mo.list[0].tip,
                                      onTap: () {
                                        Pickers.showDatePicker(
                                          context,
                                          pickerStyle: CoPicker(textSize: 16.r),
                                          // minDate: mo.current_month.isEmpty? null: PDuration.parse(DateTime),
                                          mode: mo.type.contains('_ymd') ? DateMode.YMD : DateMode.YM,
                                          onConfirm: (p) => _onSelectTime(index: index, key: 0, item: p),
                                        );
                                      },
                                    ),
                                  ),
                                  if (mo.list.length > 1)
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15),
                                      child: const Text(
                                        '—',
                                        style: TextStyle(color: C.deepGrey, fontSize: 14.0, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  if (mo.list.length > 1)
                                    Expanded(
                                      child: CellForm(
                                          title: mo.title,
                                          showArrow: false,
                                          titlePadding: EdgeInsets.only(top: 0, bottom: 8),
                                          titleStyle: titleStyle.copyWith(color: C.transparent),
                                          hintStyle: hintStyle,
                                          textStyle: textStyle,
                                          text: mo.list[1].sel_value,
                                          bgColor: C.white,
                                          hintText: mo.list[1].tip,
                                          onTap: () {
                                            Pickers.showDatePicker(
                                              context,
                                              mode: mo.type.contains('_ymd') ? DateMode.YMD : DateMode.YM,
                                              pickerStyle: CoPicker(textSize: 16.r),
                                              onConfirm: (p) => _onSelectTime(index: index, key: 1, item: p),
                                            );
                                          }),
                                    )
                                ],
                              ).paddingOnly(bottom: 10.r);
                            case 'array':
                            case 'array_one':
                            case 'arrayOne':
                              return TextTag(
                                  mo: mo,
                                  onTap: (i) {
                                    logs('---x--$i');
                                    _onSelect(index: index, key: i);
                                  });
                            case 'list':
                            case 'list_one':
                            case 'listOne':
                              return SearchList(
                                  mo: mo,
                                  onTap: (i) {
                                    logs('---x--$i');
                                    _onSelect(index: index, key: i);
                                  });
                            case 'pick_sons':
                              return CellForm(
                                text: mo.sel_value,
                                title: mo.title,
                                titleStyle: titleStyle,
                                hintStyle: hintStyle,
                                hintText: '请选择' + mo.title,
                                onTap: () {
                                  FromTemplateList x = FromTemplateList.fromJson(mo.toJson());
                                  Get.to(
                                    PickSonsPage(mo: x),
                                    fullscreenDialog: true,
                                    opaque: false,
                                    transition: Transition.downToUp,
                                  )?.then((v) {
                                    if ((v != null) && (v['f'] == true)) {
                                      mo.sel_value_id = v['id'];
                                      mo.sel_value = v['name'].toString();
                                      mo.select = true;
                                      if (mounted) setState(() {});
                                    }
                                  });
                                },
                              );
                            default:
                              return Container();
                          }
                        }),
                      ),
                    )),
                    Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(30),
                            decoration: const BoxDecoration(
                              color: C.white,
                              // borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0)),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: SafeArea(
                              top: false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  KitButton(name: '重置', bgColor: C.mainColor.withOpacity(0.3), onTap: _onReset),
                                  KitButton(name: '确定', onTap: onSubmit),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

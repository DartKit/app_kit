import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/models/core/key_vars.dart';
import 'package:app_kit/models/core/oss_obj.dart';
import 'package:app_kit/tools/cell/cell_form.dart';
import 'package:app_kit/widgets/co_pickers.dart';
import 'package:app_kit/widgets/kit_views/kit_views.dart';
import 'package:app_kit/tools/image/photo_picker.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:searchfield/searchfield.dart';
import '../../../models/core/from_template.dart';
import 'add_minus.dart';
import 'decimal_num_picker.dart';
import 'deduction_list.dart';
import 'drop_select_more.dart';
import 'form_input_logic.dart';
import 'form_tool.dart';
import 'map_form_entry.dart';
import 'pick_box.dart';
import 'pick_sons.dart';
import 'pull_search.dart';
import 'score_rules.dart';
import 'sel_multi.dart';

// bool contains_show_var(String fa,String sons)  {
//   bool f = false;
//   List<String> ls = sons.split('_');
//   for (var o in ls) {
//     if(fa.contains(o)) f = true;
//   }
//   return f;
// }

// 随手拍提报 养护处理整改 巡查评价的输入框封装
class FromInput extends StatefulWidget {
  FromInput({
    super.key,
    required this.sure,
    this.patrol_type_id = 0,
    this.work_id = 0,
    this.enable = true,
    this.showTitle = false,
    this.isDraft = false,
    this.cancel,
    this.paths,
    this.actions,
    this.sureName = '确认',
    this.bgColor,
    this.padding,
    // this.max_pic,
    this.aiCall,
    this.goMapCall,
  });

  Function sure;
  Function? cancel;
  Function? aiCall;
  Function? goMapCall;
  String sureName;
  List<OssObj>? paths;
  List<Widget>? actions;

  bool isDraft;
  bool enable;
  bool showTitle;
  int patrol_type_id;
  int work_id;

  // int? max_pic;
  Color? bgColor;
  EdgeInsets? padding;

  @override
  State<FromInput> createState() => _FromInputState();
}

class _FromInputState extends State<FromInput> {
  @override
  void dispose() {
    logs('---dispose-2');
    cForm.mods.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => cForm.isClick.isTrue
        ? InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            // onTap: ()=> Get.focusScope?.unfocus(), // 移除。如果打开在输入框删除文本会灰色背景

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: widget.bgColor ?? C.white,
              ),
              padding: widget.padding ?? EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _initView(),
              ),
            ),
          )
        : Container());
  }

  List<Widget> _initView() {
    List<Widget> ls = [
      if (cForm.isClick.isTrue && (widget.showTitle == true))
        Center(
            child: CoText(
          cForm.info.name,
          fontSize: 17.r,
        ))
    ];
    // logs('---_initView--');
    ls.addAll(_forinChildren(cForm.mods.toList(), fas: {}, isRoot: true));
    ls.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (widget.enable)
            Obx(() {
              if (cForm.hasReqTemps.isFalse) return SizedBox();
              return KitButton(
                  name: widget.sureName,
                  fontSize: 15.r,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.r,
                  ),
                  onTap: () async {
                    cForm.allReqFilled = true;
                    await _forinCheckIsRequired(cForm.mods.toList(), fas: {}, isRoot: true);
                    if (cForm.allReqFilled) widget.sure();
                  });
            }),
          if (widget.cancel != null)
            KitButton(
                name: '取消',
                bgColor: C.mainColor.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 30.r),
                onTap: () {
                  cForm.mods.clear();
                  cForm.isClick.value = false;
                  widget.cancel!();
                }),
          ...widget.actions ?? [],
          if (inDebug)
            KitButton(
                name: 'Log',
                fontSize: 15.r,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.r,
                ),
                onTap: () async {
                  cForm.sure(noReq: true);
                }),
        ],
      ),
    ));
    return ls;
  }

  Future<void> _forinCheckIsRequired(List<FromTemplateList> children, {required Map<String, dynamic> fas, bool isRoot = false}) async {
    for (var o in children) {
      // logs('-o.name--${o.name}--o.show_var--${o.show_var}-o.value--${o.value}--father_v--${father_v}');
      if (isRoot) {
        // 最外层
        if (o.is_required.yes && isNil(o.value)) {
          cForm.allReqFilled = false;
          kPopSnack(o.hint.ifNil(FormTool.hint(o.type) + o.title));
          return;
        }
      } else {
        if (o.show_var.isEmpty) {
          if (o.is_required.yes && fas.isNotEmpty) if (isNil(o.value)) {
            cForm.allReqFilled = false;
            kPopSnack(o.hint.ifNil(FormTool.hint(o.type) + o.title));
            return;
          }
        } else {
          if (o.is_required.yes && o.show_var.contains(fas.values.first.toString())) {
            if (isNil(o.value)) {
              cForm.allReqFilled = false;
              kPopSnack(o.hint.ifNil(FormTool.hint(o.type) + o.title));
              return;
            }
          }
        }
      }
      if (o.children.isNotEmpty) {
        var vaOrid = o.value_id > 0 ? o.value_id : o.value;
        if (vaOrid != null) fas[o.name] = vaOrid;
        // String fa = cForm.valueAndId(o);
        if (fas.isNotEmpty) await _forinCheckIsRequired(o.children, fas: fas);
      }
    }
    // logs('---false-0-${cForm.allReqFilled}---f--${cForm.allReqFilled.hashCode}');
  }

  List<Widget> _forinChildren(List<FromTemplateList> children, {required Map<String, dynamic> fas, bool isRoot = false, FromTemplateList? fa_mo}) {
    List<Widget> ls = [];
    for (var o in children) {
      if (o.status == 40) continue;
      if ((isRoot == false) && (fas.isEmpty)) continue;
      Map<String, dynamic> mapVars = cForm.urlSetValue(url: o.url.toString(), patrol_type_id: widget.patrol_type_id, fas: fas);
      // logs('---mapVars--${mapVars}');
      o.show_var = mapVars['_show_var'] ?? '';
      // logs('--o.name--:${o.name}---o.show_var--${o.show_var}--fas--:${fas}');
      if (o.show_var.isNotEmpty && fas.isNotEmpty) {
        // logs('---fa_mo?.value--${fa_mo?.value}');
        logs('---o.url--${o.url}');
        if ((o.show_var.contains(fas.values.first.toString()) == false)) continue;
        logs('---o.url-2-${o.url}');
        // logs('---mapVars-0-${mapVars}---fas.v、alues.first--${fas.values}---o.show_var--${o.show_var}---o.show_var.contains(fas.values.first.toString())--${o.show_var.contains(fas.values.first.toString())}');
      }
      // if (o.show_var.isNotEmpty && fas.isNotEmpty && (o.show_var.contains(fas.values.first.toString())== false)) continue;
      // logs('---mapVars--${mapVars}');
      o.url = o.url.mapToUrl(map: mapVars);
      // logs('---o.url--${o.url}');
      o.check_box = mapVars['_check_box'] ?? '';
      o.check_yes = mapVars['_check_yes'] ?? '';
      o.fill_op_type = mapVars['_fill_op_type'] ?? '';
      o.fill_api = mapVars['_fill_api'] ?? '';
      o.fill_key = mapVars['_fill_key'] ?? '';
      o.fill_key_id = mapVars['_fill_key_id'] ?? '';
      o.fa_key = mapVars['_fa_key'] ?? '';
      // o.one_fill = mapVars['_one_fill'] ?? '';
      // var _fill_all_fas = mapVars['_fill_all_fas']??'';
      // o.fa_var = mapVars['_fa_var']??'';
      if (o.check_box.isNotEmpty) o.checked ??= o.check_box == '0' ? false : true;

      switch (o.type) {
        case 'image':
        case 'camera':
        case 'image_camera':
          {
            // logs('--o.value.runtimeType-0-:${o.value.runtimeType}');
            if (o.value.runtimeType == List<Map<String, dynamic>>) {
              List<Map<String, dynamic>> mas = o.value;
              o.value = mas.map((e) => OssObj.fromJson(e)).toList();
            } else if (o.value.runtimeType == List<OssObj>) {
            } else if (o.value.runtimeType == List<dynamic>) {
              if (o.value is List<Map<String, dynamic>>) {
                List<Map<String, dynamic>> mas = List<Map<String, dynamic>>.from(o.value);
                o.value = mas.map((e) => OssObj.fromJson(e)).toList();
              } else {
                o.value = List.from(o.value);
              }
            }
            // logs('--o.value.runtimeType-1-:${o.value.runtimeType}');
            List urls = o.value ?? [];
            if (urls.isEmpty && (widget.paths?.isNotEmpty == true) && (o.name == 'path')) {
              o.value = widget.paths;
              urls = widget.paths!;
            }

            ls.add(
              PhotoPicker(
                urls: urls,
                title: o.title,
                isUpLsInStr: o.url.contains('_lsStr=1'),
                type: TypePicker.name(o.type),
                max: o.tip.isNum ? o.tip.toInt : 9,
                is_required: o.is_required.yes,
                margin: EdgeInsets.only(top: 10.r),
                isLook: !widget.enable,
                check_box: o.checked,
                isFile: o.url.contains('_file=1'),
                aiCall: (x) {
                  if (widget.aiCall != null) widget.aiCall!(o);
                },
                onCheckBoxChange: (x) {
                  o.checked = x;
                  if (x == false) {
                    o.value = null;
                    if (mounted) setState(() {});
                  }
                },
                callback: (x) {
                  o.value = x;
                  if (widget.paths != null) {}
                },
              ),
            );
          }
          break;
        case 'file': //
          {
            if (o.value.runtimeType == List<Map<String, dynamic>>) {
              List<Map<String, dynamic>> mas = o.value;
              o.value = mas.map((e) => OssObj.fromJson(e)).toList();
            }
            List<OssObj> urls = o.value ?? [];
            ls.add(PhotoPicker(
                urls: urls,
                isFile: true,
                title: o.title,
                max: o.tip.isNum ? o.tip.toInt : 9,
                is_required: o.is_required.yes,
                margin: EdgeInsets.only(top: 10.r),
                isLook: !widget.enable,
                callback: (x) {
                  o.value = x;
                }));
          }
          break;
        case 'text':
          {
            // var map = o.url.urlQuery();
            ls.add(CellForm(
              text: o.value ?? '',
              title: o.title,
              tip: o.tip,
              is_required: o.is_required.yes,
              hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
              enable: widget.enable,
              check_box: o.checked,
              keyboardType: o.url.contains('_all_num=1') ? TextInputType.number : null,
              onCheckBoxChange: (x) {
                o.checked = x;
                if (x == false) {
                  o.value = null;
                  if (mounted) setState(() {});
                }
              },
              clear: () {
                o.value = null;
                o.value_id = 0;
                if (mounted) setState(() {});
              },
              input: InputEvent(
                  minLines: o.url.contains('line=') ? o.url.urlQuery()['line'].toString().toInt : 3,
                  inputFormatters: o.url.contains('all_num=1')
                      ? ([
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ])
                      : (o.url.contains('dot_num=1')
                          ? [
                              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                            ]
                          : null),
                  onChanged: (x) {
                    o.value = x;
                    logs(x);
                  }),
            ));
          }
          break;
        case 'num':
          {
            ls.add(
              CellForm(
                text: o.value.toString(),
                title: o.title,
                is_required: o.is_required.yes,
                hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
                tip: o.tip,
                enable: widget.enable,
                onTap: () {
                  Get.bottomSheet(
                          DecimalNumPicker(
                            title: o.title,
                            initValue: 1.0,
                            selValue: (o.value.toString().isNum ? double.parse(o.value.toString()) : null),
                            minValue: o.url.contains('_input_min=0.1') ? 0.1 : 0.0,
                            maxValue: 100000.0,
                            decimalPlaces: o.url.contains('_input_type=dot') ? 1 : 0,
                          ),
                          isDismissible: false)
                      .then((value) {
                    if ((value != null) && (o.value != value)) {
                      o.value = value;
                      if (mounted) setState(() {});
                    }
                  });
                },
              ),
            );
          }
          break;
        case 'div_view':
          {}
          break;
        case 'add_minus':
          {
            var show = true;
            if ((fa_mo != null) && ((fa_mo.max_score.toDouble.abs() <= fa_mo.score.toDouble.abs()))) {
              show = false;
              o.value = null;
              o.is_required = 0;
            }
            logs('---show--$show---o.value --:${o.value}');
            if (show) {
              ls.add(AddMinusInput(
                o,
                fa: fa_mo,
                onChanged: (x) {
                  // logs('---x-xxx-${x}');
                  o.value = x;
                },
              ));
            }
          }
          break;
        case 'pull_search':
          {
            ls.add(
              PullSearchField(
                o.title, url: o.url,
                text: o.value ?? '',
                // argument: {
                //   'drop_list':10,
                //   'district_id':mo.region_id
                // },
                emptyHint: '当前暂无' + o.title,
                hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
                tip: o.tip,
                suggestionDirection: SuggestionDirection.flex,
                check_box: o.checked,
                noRed: !o.is_required.yes,
                noRedHasGap: o.is_required.yes,
                onCheckBoxChange: (x) {
                  o.checked = x;
                  if (x) {
                    if (o.check_yes.isNotEmpty) o.value_id = o.check_yes.toInt;
                  } else {
                    o.value = null;
                    o.value_id = 0;
                  }
                  if (mounted) setState(() {});
                },
                call: (KeyVars x) {
                  o.value = x.label;
                  o.value_id = x.value;
                  o.children.forEach((e) {
                    e.dats.clear();
                    e.value_id = 0;
                    e.value = null;
                  });
                  logs('---o.value--${o.value}---o.value_id--${o.value_id}');
                  if (mounted) setState(() {});
                },
                onTap: (FocusNode focus) async {
                  // if (isNil(o.region_id == 0, '请先选择道路所属')) {
                  //   focus.unfocus();
                  //   return;
                  // };
                },
              ),
            );
          }
          break;
        case 'select':
          {
            if (o.url.contains('_fill') && isNil(o.value) && (widget.isDraft == false)) _getCurrentMoData(o, autoFill: true);
            ls.add(
              CellForm(
                text: '${o.value}',
                title: o.title,
                is_required: o.is_required.yes,
                hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
                tip: o.tip,
                enable: mapVars['enable'] == '0' ? false : widget.enable,
                // enable: false,
                check_bool: o.check_yes.isNotEmpty,
                check_box: o.checked,
                onCheckBoxChange: (x) {
                  o.checked = x;
                  if (x) {
                    if (o.check_yes.isNotEmpty) {
                      o.value_id = o.check_yes.toInt;
                    }
                  } else {
                    o.value = null;
                    o.value_id = 0;
                  }
                  if (mounted) setState(() {});
                },
                onTap: () async {
                  await _getCurrentMoData(o);
                  if (isNil(o.dats, '当前无${o.title}可以选择')) return;
                  Pickers.showSinglePicker(
                    context,
                    data: o.dats.map((e) => e.name.ifNil(e.label.ifNil(e.title))).toList(),
                    selectData: o.value,
                    pickerStyle: CoPicker(),
                    onConfirm: (p, position) {
                      FromTemplateList mo = o.dats[position];
                      o.value = mo.name.ifNil(mo.label).ifNil(mo.title);
                      logs('---mo.id--${mo.id}---mo.value--${mo.value}');
                      o.value_id = mo.id;
                      if (mo.value.runtimeType == int && (mo.id == 0)) o.value_id = mo.value;
                      for (var m in o.children) {
                        m.dats = []; //当前层级选中后，清空下级的旧数据。
                        m.value = null;
                        m.value_id = 0;
                      }
                      if (mounted) setState(() {});
                      // widget.call(c.mods);
                    },
                  );
                },
                clear: () {
                  o.value = null;
                  o.value_id = 0;
                  if (mounted) setState(() {});
                },
              ),
            );
          }
          break;
        case 'select_more': // 多级选择 单级多选
          {
            ls.add(
              CellForm(
                text: '${o.value}',
                title: o.title,
                is_required: o.is_required.yes,
                hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
                tip: o.tip,
                enable: widget.enable,
                check_box: o.checked,
                onCheckBoxChange: (x) {
                  o.checked = x;
                  if (x == false) {
                    o.value = null;
                    o.value_id = 0;
                    if (mounted) setState(() {});
                  }
                },
                onTap: () {
                  _select_more(o, fas: fas);
                },
              ),
            );
          }
          break;
        case 'pick_sons':
        case 'pick_tick':
          {
            if (o.dats.isEmpty) _one_fill_belong_depart(o);
            ls.add(
              CellForm(
                text: o.value,
                title: o.title,
                is_required: o.is_required.yes,
                hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
                tip: o.tip,
                enable: widget.enable,
                check_box: o.checked,
                onCheckBoxChange: (x) {
                  o.checked = x;
                  if (x == false) {
                    o.value = null;
                    o.value_id = 0;
                    if (mounted) setState(() {});
                  }
                },
                onTap: () {
                  Get.to(
                    () => PickSonsPage(mo: o, patrol_type_id: widget.patrol_type_id),
                    fullscreenDialog: true,
                    opaque: false,
                    transition: Transition.downToUp,
                  )?.then((v) {
                    if ((v != null) && (v['f'] == true)) {
                      o.value_id = v['id'];
                      // for (var e in o.children) {o.name_children = e.name;}
                      o.value = v['name'].toString();
                      String expiry_time = v['time'];
                      if (expiry_time.isNotEmpty) {
                        for (var m in cForm.mods) {
                          if (m.name == 'expiry_time') m.value = expiry_time;
                        }
                      }
                      logs('---o.value--${o.value}');
                      if (mounted) setState(() {});
                    }
                  });
                },
              ),
            );
          }
          break;
        case 'drop_select_more': // 单层下拉-选择多个数据
          {
            ls.add(
              CellForm(
                text: o.value,
                title: o.title,
                is_required: o.is_required.yes,
                hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
                tip: o.tip,
                enable: widget.enable,
                onTap: () {
                  Get.to(() => DropSelectMore(mo: o, patrol_type_id: widget.patrol_type_id), fullscreenDialog: true, opaque: false, transition: Transition.downToUp)?.then((v) {
                    if ((v != null) && (v['f'] == true)) {
                      o.valueLs = v['ids'];
                      o.value = v['names'].join('; ');
                      logs('---o.value_id--:${o.value_id}--o.value--${o.value}');
                      if (mounted) setState(() {});
                    }
                  });
                },
              ),
            );
          }
          break;
        case 'time_y':
        case 'time_ym':
        case 'time2_ym':
        case 'time_ymd':
        case 'time2_ymd':
        case 'time_ymdhm':
          {
            ls.add(CellForm(
              text: o.value,
              title: o.title,
              is_required: o.is_required.yes,
              hintText: o.hint.ifNil(FormTool.hint(o.type) + o.title),
              tip: o.tip,
              enable: widget.enable,
              check_box: o.checked,
              onCheckBoxChange: (x) {
                o.checked = x;
                if (x == false) {
                  o.value = null;
                  if (mounted) setState(() {});
                }
              },
              onTap: () {
                var selt = PDuration.now();
                if (o.value.toString().length > 4) {
                  try {
                    selt = PDuration.parse(DateTime.parse(o.value.toString().replaceAll("[ -:－]", '')));
                  } catch (err) {
                    selt = PDuration.now();
                  }
                }

                Pickers.showDatePicker(
                  Get.context!,
                  mode: AddDateMode.mode(o.type),
                  // minDate: mapVars.containsKey('_start_time')? PDuration.parse(DateTime.parse(mapVars['_start_time'])): ( o.start_time.isNotEmpty? PDuration.parse(DateTime.parse(o.start_time)): PDuration.now()),
                  minDate: mapVars.containsKey('_start_time') ? PDuration.parse(DateTime.parse(mapVars['_start_time'])) : null,
                  maxDate: mapVars.containsKey('_end_time') ? PDuration.parse(DateTime.parse(mapVars['_end_time'])) : null,
                  // suffix: Suffix(years: ''),
                  selectDate: selt,
                  pickerStyle: CoPicker(textSize: 16.r),
                  onConfirm: (p) {
                    switch (AddDateMode.mode(o.type)) {
                      case DateMode.Y:
                        o.value = p.y;
                        break;
                      case DateMode.YM:
                        o.value = p.ym;
                        break;
                      case DateMode.YMD:
                        o.value = p.ymd;
                        break;
                      default:
                        {
                          o.value = p.ymdhm;
                        }
                    }

                    if (mounted) setState(() {});
                  },
                );
              },
              clear: () {
                o.value = null;
                setState(() {});
              },
            ));
          }
          break;
        case 'check_box':
          {
            ls.add(DeductionList(
              mo: o,
              call: (x) {
                o.value = x;
                logs('---_ids--$x');
              },
            ));
          }

          break;
        case 'pick_box':
          {
            // logs('---pick_box----o.name--${o.name}---o.url--${o.url}');
            PickBox(
              mo: FromTemplateList.fromJson(o.toJson()), // 进行copy入参，不进行依赖入参
              patrol_type_id: widget.patrol_type_id,
              isDraft: widget.isDraft,
              call: (x) {
                o.value = x;
                if (mounted) setState(() {});
                logs('---_ids--$x');
              },
            );
          }
          break;
        case 'map':
          {
            ls.add(
              MapFormEntry(
                  // latitude: o.latitude.isNotEmpty ? o.latitude : cProb.mo.value.latitude,
                  // longitude: o.longitude.isNotEmpty ? o.longitude : cProb.mo.value.longitude,
                  lng_lat: o.value ?? '',
                  address: o.sel_value.isNotEmpty ? o.sel_value : o.address,
                  name: o.title,
                  is_required: o.is_required.yes,
                  call: () {
                    if (widget.goMapCall != null) widget.goMapCall!();
                    // logs('--22-lat--$lat---lon--$lon');
                    // o.value = '$lon,$lat,$addr';
                    // o.sel_value = addr;
                    // if (mounted) setState(() {});
                  }).paddingOnly(top: 10),
            );
          }
          break;
        case 'sel_multi':
          {
            ls.add(SelMulti(
              url: o.url,
              input_type: o.type,
            ));
          }
          break;
        case 'none':
          {
            if (o.url.contains('_fill_me')) {
              Map<String, String> map = o.url.urlQuery();
              o.value = map['_fill_me'];
            }
          }
          break;
        default:
          {}
      }

      if (o.children.isNotEmpty) {
        // String fa = cForm.valueAndId(o);
        var vaOrid = o.value_id > 0 ? o.value_id : o.value;
        if (vaOrid != null) fas[o.name] = vaOrid;
        logs('---fas--$fas');
        if (fas.isNotEmpty) ls.addAll(_forinChildren(o.children, fas: fas, fa_mo: o));
      }
    }

    return ls;
  }

  void _select_more(FromTemplateList o, {List<FromTemplateList>? ais, bool isHot = false, required Map<String, dynamic> fas}) {
    Get.to(
      () => ScoreRulesPage(
        mo: o,
        fas: fas,
        ais: ais,
        isHot: isHot,
        patrol_type_id: widget.patrol_type_id,
        work_id: widget.work_id,
      ),
      fullscreenDialog: true,
      opaque: false,
      transition: Transition.downToUp,
    )?.then((v) {
      if ((v != null) && (v['f'] == true)) {
        o.value_id = v['id'];
        // for (var e in o.children) {o.name_children = e.name;}
        o.value = v['name'].toString();
        logs('---v-vvv-$v');
        if ((v as Map).containsKey('max_score')) o.max_score = v['max_score'];
        if ((v).containsKey('score')) o.score = v['score'];
        String expiry_time = v['time'];
        if (expiry_time.isNotEmpty) {
          for (var m in cForm.mods) {
            if (m.name == 'expiry_time') m.value = expiry_time;
          }
        }
        logs('---o.value--${o.value}');
        if (mounted) setState(() {});
      }
    });
  }

  Future<void> _one_fill_belong_depart(FromTemplateList o) async {
    if (o.value_id == 0 && o.url.contains('_one_fill')) {
      Map<String, dynamic> map = o.url.urlQuery(); // 40 隐藏 80 显示
      FromTemplate? res = await CoService.fire<FromTemplate>(o.url, params: map);
      if (res != null && res.list.length == 1) {
        FromTemplateList mo = res.list.first;
        o.value_id = mo.id;
        o.value = mo.name;
        logs('---o.name--${o.name}---o.value_id--${o.value_id}---o.value--${o.value}');
        if (mounted) setState(() {});
      }
    }
  }

  Future<void> _reqCurrentMoData(FromTemplateList o) async {
    if (o.dats.isNotEmpty) return;
    if (o.select_data.isNotEmpty) {
      //select_data 自定义表单养护日志下拉数据
      o.dats = o.select_data.map((e) {
        FromTemplateList mo = FromTemplateList.fromJson(e);
        mo.id = e['value'];
        return mo;
      }).toList();
      return;
    }

    if (o.url.contains('_rsp_list=1')) {
      List<FromTemplateList>? res = await CoService.fireGet<List<FromTemplateList>>(o.url, unTap: true);
      if (res != null) o.dats = res;
    } else {
      FromTemplate? res = await CoService.fireGet<FromTemplate>(o.url, unTap: true);
      if (res != null) o.dats = res.list;
    }
  }

  Future<void> _getCurrentMoData(FromTemplateList o, {bool autoFill = false}) async {
    await _reqCurrentMoData(o);
    if (autoFill && o.dats.isNotEmpty) {
      var vv = o.url.urlQuery()['_fill'];
      o.url = o.url.replaceAll('_fill', '_set');
      if (o.dats.length == 1) {
        o.value_id = o.dats.first.id;
        o.value = o.dats.first.name;
      } else {
        for (var e in o.dats) {
          if (e.id.toString() == vv) {
            o.value_id = e.id;
            o.value = e.name;
          }
        }
      }
      if (mounted) setState(() {});
    }
  }
}

/*

add_minus 加减填数  ?is_double=0.1&_negative=1，有_negative 会把输入的值转为负数字符串。_fill_key=score填充父级数据的字段
div_view  外边框容器

_show_var       _show_var=10 表示当父级选中10时表单会出现。
_box_one	      平铺单选交互。只在 pick_box 表单中生效，加入此入参可对平铺 Box 多选一。
_check_box		  表单左侧新增单选框，选中后出现表单输入项。_check_box 值对应1或0，对应默认选中或不选中。
_check_yes		  表单左侧只有单选框，选中不出现表单输入项。_check_yes 值对应为选中时的表单接口入参值。该字段依赖 _check_box 为使用前提而使用
_fill_api   	  填充接口 problem：问题详情；problem_log：问题详情接口log_list；complaint:申诉详情；complaint_log：申诉详情接口log_list
_fill_op_type	  填充类型 对应_fill_api选中 problem_log 和 complaint_log 接口时候，log_list中的op_type操作类型。
_fill_key       填充字段名称。可以根据入参的 _fill_api 和 _fill_op_type 定位到具体的字段位置。最终通过 _fill_key 取到该字段值。
_fill_key_id    填充字段的id值。可以根据入参的 _fill_api 和 _fill_op_type 定位到具体的字段位置。最终通过 _fill_key_id 取到该字段值。
                如自动填充上次的评分细则。_fill_key 对应 evaluate_title的值，_fill_key_id 对应 evaluate_id的值
_select         退还分数是否默认全选分数，_select=1或0可进行默认全选或不全选
_one_fill       只有一个数据的时候进行自动请求接口填充。目前适用于 belong_depart_id belong_depart_name
_rsp_list       _rsp_list=1为当select组件类型时候。接口的返回数据是data下面是数组。
_fill_me        _fill_me是当前字段自己填充自己，适用none类型。如_fill_me=10；回o.name入参字段赋值10进行请求
_fill_fa        _fill_fa=biz_type表示调取当前url接口获取数据时候会填充上级选中的值，入参名称为右边的“biz_type”

预定义替换填充字段:  字段名称=k_var，如 patrol_type_id=k_var 会把请求URL中的 k_var 替换成项目中当前的巡查类型id
type              替换填充 patrol_type_id
patrol_type_id    替换填充 patrol_type_id
problem_id        问题详情的问题 problem_id
serial_no         问题详情的问题编号 serial_no
complaint_no      申诉详情的申诉编号 complaint_no
biz_id            巡查类型中的  biz_id
longitude         当前定位的经度 longitude
latitude          当前定位的纬度 latitude
address           当前定位的地址 address
u_id              当前登录用户的 user_id

 */

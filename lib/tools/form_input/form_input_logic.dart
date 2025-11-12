import 'package:get/get.dart';
import '../../../core/app_define.dart';
import '../../../core/kt_export.dart';
import '../../../https/kit_service.dart';
import '../../../models/core/co_state.dart';
import '../../../models/core/from_template.dart';

FormInputLogic get cForm => Get.isRegistered<FormInputLogic>() ? Get.find<FormInputLogic>() : Get.put<FormInputLogic>(FormInputLogic());

class FormInputLogic extends GetxController {

  var isClick = false.obs;


  bool reload = false;

  var current = 1;
  String sortId = '';

  var templates = <FromTemplateList>[].obs; // 未使用的干净模板
  var mods = <FromTemplateList>[].obs; // 初步处理的模板
  var opsProbl = <FromTemplateList>[].obs; //问题操作按钮
  var opsComps = <FromTemplateList>[].obs; //申诉操作按钮
  var info = TemplateInfo();
  var allReqFilled = true;
  var hasReqTemps = true.obs;
  // var hidMap = false.obs;
  // var co = BMFCoordinate(0,0).obs;
  // var mo = SdProblemsList().obs;

  Map<String, dynamic> params = {}; // 提前差异化入参

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<void> reqSetTemMap(Map<String,dynamic> map) async {
    var res =  FromTemplate.fromJson(map);
    info = res.info;
    mods.value = res.list;
    templates.value = res.list;
    isClick.value = true;

  }

  Future<void> req({
    Map<String, dynamic>? mo,
    required String code,
    int work_id = 0,
    int patrol_type_id = 0,
    String url = '',
  }) async {
    if (isNil(url.isNotEmpty, '缺少url')) return;
    mo ??= {};
    Map<String, dynamic> map = {
      'code': code,
      'status': 80,
      if (work_id > 0) 'work_id': work_id,
      if (patrol_type_id > 0) 'patrol_type_id': patrol_type_id,
    };
    hasReqTemps.value = false;

    FromTemplate? res =
    await KitService.fireGet<FromTemplate>(url, query: map);

    if (res != null) {
      hasReqTemps.value = true;
      info = res.info;
      List<FromTemplateList> mos = res.list;

      if (mo.isNotEmpty) {
        logs('--mo--:${json.encode(mo)}');

        // mo['input_score'] = '1.6';
        // logs('----mo-multiple]-${mo['multiple']}');
        _fillValue(mos, mo);
      }
      mods.value = mos;

      // for (var o in mods.value) {
      //   logs('---o.name--${o.name}---value_id--${o.value_id}----o.value--${o.value}');
      // }
      // logs('---mods.toString--${mods.toString()}');
      // Future.delayed(Duration(milliseconds: 4000),(){
      //   logs('---mods.toString--${mods.toString()}');
      // });
      templates.value = res.list;
      // if (code == 'casual_shot') {
      //   if (isNil(templates,'暂无模板\n请联系管理员到后台配置' )) {
      //     Future.delayed(Duration(milliseconds: 500),(){
      //       isClick.value = false;
      //     }); 加减法
      //   }
      // }
    }
  }

  void _fillValue(List<FromTemplateList> mos, Map<String, dynamic> mo) {
    for (var o in mos) {
      logs('---mo[o.name]---o.name--:${o.name}:${mo[o.name]}');
      if (isNil(mo[o.name]) == false) o.value = mo[o.name]; // 同字段取值
      // logs('---mo[o.name]--${mo[o.name]}-：-${o.value}');
      // logs('---mo-1-${mo}');
      // logs('---mos--${mos.length}');
      switch (o.name) {

        case 'longitude,latitude,address':
        case 'longitude,latitude':
        case 'lng,lat,address':
        case 'lng,lat':
          {
            o.value =
            '${mo['longitude'] ?? ''},${mo['latitude'] ?? ''}${(o.name.endsWith(',address') && mo.containsKey('address')) ? ',${mo['address']}' : ''}';
            if (o.name.endsWith(',address')) o.address = mo['address'];
          }
          break;
        default:
          {}
      }
      if (o.children.isNotEmpty) _fillValue(o.children, mo);
    }
  }

  Map<String, dynamic> urlSetValue(
      {required String url,
        int? patrol_type_id,
        required Map<String, dynamic> fas}) {
    Map<String, dynamic> map = url.urlQuery();
    Map<String, String> mapTem = {};
    map.forEach((key, value) {
      String va = value.toString();
      if (va == 'k_var') {
        switch (key) {
          default:
            {
              logs('---params--$params');
              if (params.containsKey(key)) {
                map[key] = params[key].toString();
              }
            }
        }
      }
      if (((key == '_fill_fa') || (key == '_set_fa')) && fas.isNotEmpty) {
        var idOrVal = fas.values.first;
        mapTem[value.toString()] = idOrVal.toString();
      }
    });
    map.addAll(mapTem);
    return map;
  }



  // 各个事件按钮 提交
  Future<bool?> sure({bool autoBack = true, noReq = false}) async {
    logs('---params--$params');
    Map<String, dynamic> map = {};
    map.addAll(params);
    _getFireMaps(mods.toList(), map, isRoot: true, fas: {});
    Map<String, dynamic> mapVars = urlSetValue(url: info.url, fas: {});
    logs('---mapVars--$mapVars');
    mapVars.forEach((key, value) {
      if (!map.containsKey(key)) map[key] = value;
    });
    logs('---map--${json.encode(map)}');
    // params.clear();
    String url = info.url.contains('?') ? info.url.split('?').first : info.url;
    logs('---info.url--${info.url}');
    if (noReq) return false;
    // return false;
    CoState? res = await KitService.fire<CoState>(url,data: map, query: map, unTap: true,isMoInAppKit: true);
    if (res?.state == true) {
      kPopSnack('操作成功',onFinish: (){
        params.clear();
        if (autoBack) Get.back(result: true);
      });
    }
    return res?.state;
  }

  void _getFireMaps(List<FromTemplateList> children, Map<String, dynamic> map,
      {required Map<String, dynamic> fas, bool isRoot = false}) {
    for (var o in children) {
      if (o.status == 40) continue;
      if ((o.type == 'map') && ((o.value.toString().contains(',')))) {
        List v1 = o.value.split(',');
        if (o.name.contains(',')) {
          List n1 = o.name.split(',');
          for (var i = 0; i < n1.length; ++i)
            if (v1.length > i) map[n1[i]] = v1[i];
        } else {
          if (v1.length >= 2) {
            map['longitude'] = v1[0];
            map['latitude'] = v1[1];
          }
          map[o.name] = o.value;
        }
        continue;
      }
      if (isRoot) {
        // 最外层
        // logs('---o.name--${o.name}---value_id--${o.value_id}');
        map.addAll(_setKeyVar(o));
      } else {
        if (o.show_var.isEmpty) {
          map.addAll(_setKeyVar(o));
        } else {
          if (fas.isNotEmpty &&
              o.show_var.contains(fas.values.first.toString()))
            map.addAll(_setKeyVar(o));
        }
      }
      if (o.children.isNotEmpty) {
        var vIdLs = o.value_id > 0 ? o.value_id : o.value;
        if (o.valueLs != null) vIdLs = o.valueLs;
        if (vIdLs != null) fas[o.name] = vIdLs;
        if (fas.isNotEmpty) _getFireMaps(o.children.toList(), map, fas: fas);
      }
    }
  }

  Map<String, dynamic> _setKeyVar(FromTemplateList o) {
    Map<String, dynamic> map = {};
    var vIdLs = o.value_id > 0 ? o.value_id : o.value;
    if (o.valueLs != null) vIdLs = o.valueLs;
    if (vIdLs != null) map[o.name] = vIdLs;
    logs('---o.name--${o.name}---v--$vIdLs');
    return map;
  }

// dynamic valueOrId(FromTemplateList o)  {
//   // String father_var = o.value_id > 0 ?  ('${o.value_id}__'):'';
//   // if(o.value != null) father_var += '${o.value}';
//   // o.showing = father_var.isNotEmpty;
//   return o.value_id > 0 ? o.value_id : o.value;
// }
// String valueAndId(FromTemplateList o)  {
//   String father_var = o.value_id > 0 ?  ('${o.value_id}__'):'';
//   if(o.value != null) father_var += '${o.value}';
//   // o.showing = father_var.isNotEmpty;
//   return father_var;
// }

}

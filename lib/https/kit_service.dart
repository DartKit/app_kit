import 'dart:async';

import 'package:app_kit/https/net.dart';

// List<CommonComplaintList>? res = await (KitService.complaintListV2<List<CommonComplaintList>>(map,url,isGet: widget.isGet));

class KitService {
  static FutureOr<T?> fireGet<T>(url, {Map<String, dynamic>? query, Map? data, onError, bool hud = true, String key = '', bool unTap = false, bool showErr = true, bool isMoInAppKit = false}) {
    // get请求时候 params不能入参 空括号{} 但是可以入参 null,
    if ((query != null) && (query.keys.isEmpty)) query = null;
    return net.get<T>(url, query: query, data: data, onError: onError, hud: hud,  dataKey: key,unTap: unTap, showErr: showErr,isMoInAppKit:isMoInAppKit);
  }

  static FutureOr<T?> fire<T>(url, {data, Map<String, dynamic>? query, onError, bool hud = true, String key = '', bool unTap = false, bool showErr = true, bool isMoInAppKit = false}) {
    //要对应为Map<String, dynamic>? 类型和基类的入参类型一样。否则如下方法走完无反应 .入参Map组装 可能没有加.value
    // if (data) {
    //
    // }
    return net.post<T>(url, query: query, data: data, onError: onError, hud: hud,  dataKey: key,unTap: unTap, showErr: showErr,isMoInAppKit:isMoInAppKit);
  }

  // static Future<T?> fire2<T>(params,{required url,bool isGet = false,onError,bool hud= true}){
  //   if (isGet) {
  //     // get请求时候 params不能入参 空括号{} 但是可以入参 null,
  //     // 要对应为Map<String, dynamic>? 类型和基类的入参类型一样。否则如下方法走完无反应
  //     return net.get<T>(url,query: params, onError: onError,loading:hud);
  //   }else {
  //     return net.post<T>(url,data: params, onError: onError,loading:hud);
  //   }
  // }
}

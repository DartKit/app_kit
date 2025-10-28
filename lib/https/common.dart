import 'package:app_kit/https/net.dart';

// List<CommonComplaintList>? res = await (CoService.complaintListV2<List<CommonComplaintList>>(map,url,isGet: widget.isGet));

class CoService {
  static Future<T?> fireGet<T>(url, {Map<String, dynamic>? params, Map? data, onError, bool hud = true, String key = '', bool unTap = false,bool showErr = true}) {
    // get请求时候 params不能入参 空括号{} 但是可以入参 null,
    if ((params != null) && (params.keys.isEmpty)) params = null;
    return net.get<T>(url, queryParameters: params, data: data, dataKey: key, onError: onError, hud: hud, unTap: unTap,showErr: showErr,);
  }

  static Future<T?> fire<T>(url, {params, onError, bool hud = true, String key = '', bool unTap = false,bool showErr = true}) {
    //要对应为Map<String, dynamic>? 类型和基类的入参类型一样。否则如下方法走完无反应 .入参Map组装 可能没有加.value
    // if (data) {
    //
    // }
    return net.post<T>(url, dataKey: key, data: params, onError: onError, hud: hud, unTap: unTap, showErr: showErr);
  }

  // static Future<T?> fire2<T>(params,{required url,bool isGet = false,onError,bool hud= true}){
  //   if (isGet) {
  //     // get请求时候 params不能入参 空括号{} 但是可以入参 null,
  //     // 要对应为Map<String, dynamic>? 类型和基类的入参类型一样。否则如下方法走完无反应
  //     return net.get<T>(url,queryParameters: params, onError: onError,loading:hud);
  //   }else {
  //     return net.post<T>(url,data: params, onError: onError,loading:hud);
  //   }
  // }
}

import 'package:app_kit/core/kt_dao.dart';
import 'package:app_kit/core/app_device.dart';
import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/widgets/kit_views/kit_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CeshiKit {
  Future<void> app_ceshi({
    required String endPath, //eg:https://www.xxx.com/v5app 中的v5app
  }) async {
    await 6.seconds.delay();
    if (kdao.baseHostAtIndex != 1) return;
    if (kdao.noNet.isTrue) return;
    var a_ky = 'MGU5YWNlYWZiMzA1YzQ3YTcyN2U5NzQ2NmE4NDEzYzA=';
    var tp = '5pyJ5paw54mI5pys5Y+R5LqG44CC6K+35Y+K5pe25LiL6L2944CC';
    // var anzhuang = 'L2FwaXYyL2FwcC9pbnN0YWxs';
    var ck = 'L2FwaXYyL2FwcC9jaGVjaw==';

    Map<String, dynamic> map = {'_api_key': a_ky.e, 'appKey': (isAndroid ? _aKyAnd : _aKyIos).e};

    Dio dio = Dio();
    var response = await dio.post((_pgHst + ck).e, queryParameters: map);
    int buildVersionNo = response.data['data']['buildVersionNo'].toString().toInt;
    if (isDebug) {
      // logs(response);
      logs('---buildVersionNo--$buildVersionNo--AppDevice.versionCode---${AppDevice.versionCode}');
    }
    // kitPopText('---RequestConfig.indexEnv--${RequestConfig.indexEnv}---AppDevice.versionCode--${AppDevice.versionCode}---buildVersionNo--${buildVersionNo}---isRelease--${isRelease}');
    if (AppDevice.versionCode < buildVersionNo && (AppDevice.versionCode > 1)) {
      KitView.alert(sureName: '去更', content: tp.e, barrierDismissible: false, autoDismiss: false, noCancel: false, sure: () => launchUrl(Uri(scheme: (_pgHst).e+endPath)));
    }
    // launchUrl(url)
  }

  var _aKyAnd = 'YmE3N2RjNGVjOTkyMGJjNDE4MmM5NTYyYzNlNmFhZWQ=';
  var _aKyIos = 'ZGI2Y2E1MDU1NWNkZmM4MDhhODQ0ZmYwMWYxN2NlMmI=';
  var _pgHst = 'aHR0cHM6Ly93d3cucGd5ZXIuY29t';
}

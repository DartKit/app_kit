import 'dart:io';

import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/pages/auth/set_loc/set_loc_qa_page.dart';

class SetBgLocPage extends StatefulWidget {
  const SetBgLocPage({super.key});

  @override
  State<SetBgLocPage> createState() => _SetBgLocPageState();
}

class _SetBgLocPageState extends State<SetBgLocPage> {
  Map<String, dynamic> map = {
    '华为': [
      ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】-【应用】\n第二步:点击【权限管理】\n第三步:点击数字园林 APP\n第四步:点击“位置信息”\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:点击手机【设置】-【电池】\n第二步:点击“数字园林 APP”\n第三步:点击“启动管理;\n第四步:点击“允许后台活动”并确认']
    ],
    '小米': [
      ['始终允许访问位置信息开启方法?【共2步，第1步】', '第一步:点击手机【设置】-【应用设置】\n第二步:点击【应用管理】\n第三步:点击“数字园林”APP\n第四步:点击“权限管理”\n第五步:点击“定位”\n第六步:选择“始终允许”'],
      ['始终允许访问位置信息开启方法?【共2步，第2步】', '第一步:从上往下下拉状态栏\n第二步:长按【位置信息】\n第三步:点击“应用位置信息权限”\n第四步:找到并点击“数字园林”APP\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:手机【设置】-【电池与性能】\n第二步:点击“数字园林”APP\n第三步:点击“应用信息”\n第四步:点击“省电策略”\n第五步:选择 “无限制”'],
    ],
    '红米': [
      ['始终允许访问位置信息开启方法?【共2步，第1步】', '第一步:点击手机【设置】-【应用设置】\n第二步:点击【应用管理】\n第三步:点击“数字园林”APP\n第四步:点击“权限管理”\n第五步:点击“定位”\n第六步:选择“始终允许”'],
      ['始终允许访问位置信息开启方法?【共2步，第2步】', '第一步:从上往下下拉状态栏\n第二步:长按【位置信息】\n第三步:点击“应用位置信息权限”\n第四步:找到并点击“数字园林”APP\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:手机【设置】-【省电与电池】\n第二步:点击右上角设置图标\n第三步:点击“应用智能省电”\n第四步:找到并点击“数字园林”APP\n第五步:选择 “无限制”'],
    ],
    'OPPO': [
      ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】-【应用管理】\n第二步:点击“数字园林 APP”\n第三步:点击“应用权限”\n第四步:点击“位置信息”\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:手机【设置】-【应用管理】\n第二步:点击“数字园林 APP”\n第三步:点击“耗电保护”\n第四步:选择 “允许后台运行”'],
    ],
    'VIVO': [
      ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】-【安全与隐私】\n第二步:点击“权限管理”\n第三步:点击“数字园林 APP”\n第四步:点击“定位”\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:手机【设置】-【电池】\n第二步:点击“后台耗电管理”\n第三步:点击“数字园林”\n第四步:选择 “允许后台高耗电”'],
    ],
    '一加': [
      ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】-【应用和通知】\n第二步:点击【应用权限】\n第三步:点击“位置信息”\n第四步:点击“数字园林APP“\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:点击手机【设置】-【电池】\n第二步:点击“电池优化”\n第三步:点击“数字园林APP”\n第四步:点击“不优化”'],
    ],
    '三星': [
      ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】-【应用程序】\n第二步:点击“数字园林 APP”\n第三步:点击“权限”\n第四步:点击“位置信息”\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:手机【设置】-【应用程序】\n第二步:点击“数字园林”\n第二步:点击“电池”\n第四步:选择 “允许后台活动”'],
    ],
    '谷歌': [
      ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】-【应用程序】\n第二步:点击“数字园林 APP”\n第三步:点击“权限”\n第四步:点击“位置信息”\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:手机【设置】-【应用程序】\n第二步:点击“数字园林”\n第二步:点击“电池”\n第四步:选择 “允许后台活动”'],
    ],
    '其他': [
      ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】-【应用】\n第二步:点击【权限管理】\n第三步:点击数字园林 APP\n第四步:点击“位置信息”\n第五步:选择“始终允许”'],
      ['始终允许应用后台活动开启方法?', '第一步:点击手机【设置】-【电池】\n第二步:点击“数字园林 APP”\n第三步:点击“启动管理;\n第四步:点击“允许后台活动”并确认'],
    ],
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isIOS) {
      map = {
        '苹果': [
          ['始终允许访问位置信息开启方法?', '第一步:点击手机【设置】\n第二步:点击【APP】, iOS18以下直接忽略第二步\n第三步:点击数字园林 APP\n第四步:点击“位置”\n第五步:选择“始终”\n第六步:打开“精确位置”'],
        ],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> ls = [];
    return Scaffold(
      appBar: CoAppBar('息屏和后台巡查'),
      body: Column(
        children: map.entries.map((e) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
            margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(width: 1.r, color: CC.line),
            ),
            child: InkWell(
              onTap: () {
                Get.to(() => SetLocQaPage(title: e.key), arguments: e.value);
              },
              child: Row(
                children: [
                  Text('我是' + e.key + '手机', style: TextStyle(color: CC.black, fontSize: 14.r, fontWeight: FontWeight.w400)),
                  Expanded(child: SizedBox()),
                  Icon(Icons.arrow_forward_ios, size: 18.r),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

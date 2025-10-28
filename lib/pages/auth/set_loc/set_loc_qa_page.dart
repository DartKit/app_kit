import 'package:app_kit/core/kt_export.dart';
import 'package:easy_refresh/easy_refresh.dart';

class SetLocQaPage extends StatefulWidget {
  final String title;
  const SetLocQaPage({super.key, required this.title});

  @override
  State<SetLocQaPage> createState() => _SetLocQaPageState();
}

class _SetLocQaPageState extends BaState<SetLocQaPage> {
  late EasyRefreshController _refvc = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  List<List<String>> dats = [];
  @override
  void initState() {
    dats = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CoAppBar(
        widget.title + '手机设置息屏和后台巡查',
      ),
      body: _ct(),
    );
  }

  Widget _ct() {
    return Column(
      children: [
        Expanded(child: _elist()),
      ],
    );
  }

  Widget _elist() {
    return EasyRefresh(
      controller: _refvc,
      child: _list(),
    );
  }

  Widget _list() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.r, vertical: 0.r),
      margin: EdgeInsets.symmetric(horizontal: 15.r, vertical: 0.r),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 15.r),
        itemBuilder: (BuildContext context, int index) {
          List<String> mo = dats[index];
          return Container(
            margin: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 8.r),
            padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(width: 1.r, color: C.line),
            ),
            child: GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.r, vertical: 4.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q：', style: TextStyle(color: C.black, fontSize: 13.r, fontWeight: FontWeight.w500)),
                        Expanded(child: Text(mo.first, style: TextStyle(color: C.black, fontSize: 13.r, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('A：', style: TextStyle(color: C.subText1, fontSize: 13.r, fontWeight: FontWeight.w400)),
                      Expanded(child: Text(mo.last, style: TextStyle(color: C.subText1, fontSize: 13.r, fontWeight: FontWeight.w400))),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: dats.length,
      ),
    );
  }
}

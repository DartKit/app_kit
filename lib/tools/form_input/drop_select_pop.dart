import 'package:app_kit/core/kt_export.dart';

import '../../models/core/key_vars.dart';

class DropSelectPop extends StatefulWidget {
  final String hintText;
  final String url;
  final Map<String, dynamic>? argument;

  const DropSelectPop({
    super.key,
    required this.url,
    this.argument,
    this.hintText = '搜索关键字',
  });

  @override
  State<DropSelectPop> createState() => _DropSelectPopState();
}

class _DropSelectPopState extends State<DropSelectPop> {
  TextEditingController _txtC = TextEditingController();
  List<KeyVars> ls = [];
  List<KeyVars> filter = [];
  final FocusNode focus = FocusNode();
  bool hasReqDone = false;

  @override
  void initState() {
    _req();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _req() async {
    if (widget.url.isEmpty) return;
    Map<String, dynamic> map = widget.url.urlQuery();
    if (widget.argument != null) {
      widget.argument!.forEach((key, value) {
        logs('---key--$key---value--$value');
        map[key] = value.toString();
      });
    }

    if (widget.url.contains('district_id=0')) return;

    if (widget.url.contains('_rsp_list=1')) {
      List<KeyVars>? res = await KitService.fireGet<List<KeyVars>>(widget.url, unTap: true, query: map);
      if (res != null) {
        hasReqDone = true;
        ls = res;
        filter = ls;
        if (mounted) setState(() {});
      }
    } else {
      List<KeyVars>? res = await KitService.fireGet<List<KeyVars>>(widget.url, unTap: true, query: map);
      if (res != null) {
        hasReqDone = true;
        ls = res;
        filter = ls;
        if (mounted) setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _son2();
  }

  Widget _son2() {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.r, color: C.line),
            color: C.bg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 44.r * (ls.length + 1) > Get.height / 2 ? Get.height / 2 : 44.r * (ls.length + 1)),
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        filter[index].select = !filter[index].select;
                        if (mounted) setState(() {});
                      },
                      child: Container(
                        height: 44.r,
                        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                        margin: EdgeInsets.only(left: 10.r, right: 10.r, bottom: 5.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(width: 1.r, color: C.line),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(filter[index].label, style: TextStyle(color: C.font, fontSize: 14.r, fontWeight: AppFont.regular)), if (filter[index].select) Icon(Icons.done)],
                        )),
                      ),
                    );
                  },
                  itemCount: filter.length,
                ),
              ),
              SizedBox(
                height: 44.r,
                child: Center(
                  child: TextField(
                    controller: _txtC,
                    focusNode: focus,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: C.mainColor,
                      fontSize: 14.r,
                      fontWeight: AppFont.medium,
                    ),
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.search_rounded,size: 20.r,color: rgba(102, 102, 102, 1),),
                      prefixStyle: TextStyle(),

                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: C.deepGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                      // isCollapsed:true,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      // disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 4.5.r, left: 10.r, right: 10.r),
                      // suffixIcon: IconButton(
                      //   icon: Obx(() => Icon(Icons.cancel,size: 16.r,color:text.value.isEmpty ? Colors.transparent:  rgba(102, 102, 102, 1))),
                      //   onPressed: () {
                      //     controller.clear();
                      //     _focusNode.unfocus();
                      //     text.value = '';
                      //     widget.call('');
                      //   },
                      // ),

                      // suffixIcon: controller.text.isNotEmpty? Icon(Icons.cancel,size: 23.r,color: rgba(102, 102, 102, 1),): Container(),
                    ),

                    onChanged: (x) {
                      if (x.isEmpty) {
                        filter = ls;
                      } else {
                        filter = ls.where((e) {
                          var has = e.select;

                          // logs('--has--:${has}');
                          if (!has) has = (e.label).contains(x);
                          if (has) {
                            // e.select = true;
                          } else {
                            // e.select = false;
                          }
                          return has;
                        }).toList();
                      }
                      if (mounted) setState(() {});
                      // text.value = x;
                    },
                    onSubmitted: (x) {
                      // widget.call(x);
                    },
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ));
    });
  }
}

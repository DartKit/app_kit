import 'package:app_kit/core/kt_export.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../models/core/key_vars.dart';

class DropSelect extends StatefulWidget {
  const DropSelect(
    this.title, {
    super.key,
    required this.url,
    this.argument,
    this.emptyHint = '暂无内容',
    this.noRed = false,
    this.hintText = '搜索关键字',
    this.text = '',
    this.inputFormatters,
    this.dropArrow = true,
    this.onTap,
    this.call,
  });

  final String title;
  final String text;
  final String hintText;
  final bool noRed;
  final bool dropArrow;
  final String url;
  final String emptyHint;
  final Function? onTap;
  final Function? call;
  final List<TextInputFormatter>? inputFormatters;
  final Map<String, dynamic>? argument;

  @override
  State<DropSelect> createState() => _DropSelectState();
}

class _DropSelectState extends State<DropSelect> {
  TextEditingController _txtC = TextEditingController();
  List<KeyVars> ls = [];
  List<KeyVars> filter = [];
  List<KeyVars> choose = [];
  final FocusNode focus = FocusNode();
  bool hasReqDone = false;
  var hasFocus = false.obs;

  @override
  void initState() {
    _txtC.text = widget.text;
    focus.addListener(() {
      logs('--focus--:${focus.hasFocus}');
      // if (focus.hasFocus == false) {
      //   _txtC.text = '';
      //   filter = ls;
      // }
      if (focus.hasFocus) {
        hasFocus.value = focus.hasFocus;
      } else {
        Future.delayed(Duration(milliseconds: 500), () {
          hasFocus.value = focus.hasFocus;
        });
      }
    });
    // _req();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    focus.removeListener(() {});
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
      List<KeyVars>? res = await KitService.fireGet<List<KeyVars>>(
          widget.url,
          unTap: true,
          query: map);
      if (res != null) {
        hasReqDone = true;
        ls = res;
        filter = ls;
        if (mounted) setState(() {});
      }
    } else {
      List<KeyVars>? res = await KitService.fireGet<List<KeyVars>>(widget.url,
          unTap: true, query: map);
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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Text(
                '∗ ',
                style: TextStyle(
                    color: (widget.noRed) ? CC.transparent : CC.red,
                    fontSize: 16.r,
                    fontWeight: FontWeight.w700),
              ),
              AutoSizeText(widget.title),
              // Text(
              //   widget.title,
              //   style: TextStyle(
              //       color: CC.keyfont,
              //       fontSize: 15.r,
              //       fontWeight: AppFont.medium),
              // )
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: InkWell(
            onTap: () async {
              if (ls.isEmpty) {
                await _req();
                if (ls.isNotEmpty) _onTap();
                return;
              }
              _onTap();
              // Get.bottomSheet(_son2(),isScrollControlled: true).then((x) {});
              // Future.delayed(Duration(milliseconds: 200), () {
              //   focus.requestFocus();
              // });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 5.r),
              constraints: BoxConstraints(
                minHeight: 44.r,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xFFF7F7F7),
              ),
              child: choose.isEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('请选择',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.r,
                                    fontWeight: AppFont.regular))
                            .marginSymmetric(horizontal: 5.r),
                      ],
                    )
                  : Wrap(
                      runAlignment: WrapAlignment.center,
                      children: choose.map((e) {
                        return Container(
                          padding: EdgeInsets.only(left: 5.r, right: 5.r),
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.r, vertical: 2.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(width: 1.r, color: CC.line),
                            color: CC.fiveColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 3.r),
                                  child: Text(e.label,
                                          style: TextStyle(
                                              color: CC.font, fontSize: 14.r))
                                      .marginOnly(right: 5.r)),
                              InkWell(
                                onTap: () {
                                  e.select = false;
                                  choose.remove(e);
                                  if (mounted) setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border:
                                        Border.all(width: 1.r, color: CC.line),
                                  ),
                                  child: Icon(Icons.close,
                                      color: CC.red, size: 16.r),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ),
        ),
      ],
    ).marginOnly(top: 10.r);
  }

  void _onTap() {
    Get.bottomSheet(_son2(), isScrollControlled: true).then((x) {
      var res = choose
          .map((e) {
            return e.label;
          })
          .toList()
          .join('; ');
      logs('--res--:$res');
      if (mounted) setState(() {});
    });
  }

  Widget _son2() {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.r, color: CC.line),
            color: CC.bg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title.replaceAll('：', ''),
                      style: TextStyle(
                          color: CC.font,
                          fontSize: 14.r,
                          fontWeight: AppFont.regular))
                  .marginOnly(bottom: 4.r),
              if (filter.isEmpty)
                Text(widget.emptyHint,
                    style: TextStyle(color: CC.deepGrey, fontSize: 14.r)),
              if (choose.isNotEmpty)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                  child: Text(
                      choose
                          .map((e) {
                            return e.label;
                          })
                          .toList()
                          .join('; '),
                      style: TextStyle(
                          color: CC.mainColor,
                          fontSize: 14.r,
                          fontWeight: AppFont.regular)),
                ),
              if (filter.isNotEmpty)
                Obx(() {
                  return Container(
                    constraints: BoxConstraints(
                        maxHeight: hasFocus.value
                            ? Get.height * 0.3
                            : ((35.r * (filter.length + 1) > Get.height * .6
                                ? Get.height * 0.6
                                : 35.r * (filter.length + 1)))),
                    child: ListView.builder(
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        KeyVars mo = filter[index];
                        return InkWell(
                          onTap: () {
                            mo.select = !mo.select;
                            if (choose.contains(mo) && (mo.select == false))
                              choose.remove(mo);
                            if ((choose.contains(mo) == false) && mo.select)
                              choose.add(mo);
                            if (mounted) setState(() {});
                          },
                          child: Container(
                            height: 35.r,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.r, vertical: 5.r),
                            margin: EdgeInsets.only(
                                left: 10.r, right: 10.r, bottom: 5.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                  width: 1.r,
                                  color: mo.select ? CC.mainColor : CC.line),
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (mo.label.contains(_txtC.text) == false)
                                    ? Text(mo.label,
                                        style: TextStyle(
                                            color: CC.font,
                                            fontSize: 14.r,
                                            fontWeight: AppFont.regular))
                                    : Row(
                                        children: mo.label
                                            .split(_txtC.text)
                                            .asMap()
                                            .entries
                                            .map((e) {
                                          return Row(
                                            children: [
                                              if (e.key > 0)
                                                Text(_txtC.text,
                                                    style: TextStyle(
                                                        color: CC.red,
                                                        fontSize: 14.r,
                                                        fontWeight:
                                                            AppFont.regular)),
                                              Text(e.value,
                                                  style: TextStyle(
                                                      color: CC.font,
                                                      fontSize: 14.r,
                                                      fontWeight:
                                                          AppFont.regular)),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                if (mo.select)
                                  Icon(
                                    Icons.done,
                                    color: CC.mainColor,
                                  )
                              ],
                            )),
                          ),
                        );
                      },
                      itemCount: filter.length,
                    ),
                  );
                }),
              SizedBox(
                height: 44.r,
                child: Center(
                  child: TextField(
                    controller: _txtC,
                    focusNode: focus,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      color: CC.mainColor,
                      fontSize: 14.r,
                      fontWeight: AppFont.medium,
                    ),
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.search_rounded,size: 16.r,color: rgba(102, 102, 102, 1),),
                      // prefixStyle: TextStyle(),
                      suffix: InkWell(
                          onTap: () {
                            _txtC.text = '';
                            setFilterSort(istEmpty: true);
                            if (mounted) setState(() {});
                          },
                          child: Icon(
                            Icons.cancel,
                            size: 16.r,
                            color: _txtC.text.isEmpty
                                ? Colors.transparent
                                : rgba(102, 102, 102, 1),
                          )),
                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: CC.deepGrey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      // isCollapsed:true,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      // disabledBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 4.5.r, left: 10.r, right: 10.r),
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
                      logs('--x--:$x');
                      if (x.isEmpty) {
                        setFilterSort(istEmpty: true);
                      } else {
                        setFilterSort(istEmpty: false);
                        // filter = ls.where((e) {
                        //   var has  = e.select;
                        //   // logs('--has--:${has}');
                        //   // logs('--e.label + e.alias_name--:${e.label + e.alias_name}');
                        //   if (has) {
                        //     tems.add(e);
                        //     return false;
                        //   }
                        //   if (!has) has = (e.label + e.alias_name).contains(x);
                        //   return has;
                        // }).toList();
                        // filter.insertAll(0, tems);
                      }
                      if (mounted) setState(() {});
                      // text.value = x;
                    },
                    onSubmitted: (x) {
                      // widget.call(x);
                    },
                    onTap: () {},
                    onTapOutside: (x) {},
                  ),
                ),
              ),
            ],
          ));
    });
  }

  void setFilterSort({istEmpty = false}) {
    List<KeyVars> tems = [];
    filter = ls.where((e) {
      var has = e.select;
      // logs('--has--:${has}');
      // logs('--e.label + e.alias_name--:${e.label + e.alias_name}');
      if (has) {
        tems.add(e);
        return false;
      }
      if ((istEmpty == false) && (has == false))
        has = (e.label).contains(_txtC.text);
      return istEmpty ? istEmpty : has;
    }).toList();
    filter.insertAll(0, tems);
  }
}

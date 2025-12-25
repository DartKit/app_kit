import 'package:app_kit/core/kt_export.dart';
import 'package:searchfield/searchfield.dart';

import '../../../models/core/key_vars.dart';

class SelMulti extends StatefulWidget {
  const SelMulti(
      {super.key,
        this.ls,
        this.url = '',
        this.title = '',
        this.input_type = ''});
  final List? ls;
  final String url;
  final String title;
  final String input_type;

  @override
  State<SelMulti> createState() => _SelMultiState();
}

class _SelMultiState extends State<SelMulti> {
  List<KeyVars> _ls = [];
  List<KeyVars> _lsSel = []; // 已经选中
  KeyVars _idxSel = KeyVars(); // 当前选中
  bool isMulti = false;
  bool isSearch = false;
  TextEditingController _txtC = TextEditingController();
  List<KeyVars> ls = [];
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    if (widget.ls != null)
      _ls = widget.ls!.map((e) => KeyVars.fromJson(e)).toList();
    isMulti = widget.input_type.contains('multi');
    isSearch = widget.input_type.contains('search');
    super.initState();
    if (_ls.isEmpty && widget.url.isNotEmpty) {
      _req();
    }
  }

  void _req() async {
    List<KeyVars>? res = await KitService.fireGet<List<KeyVars>>(widget.url, unTap: true);
    if (res != null) _ls = res;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_ls.isEmpty && widget.url.isEmpty) return SizedBox();
    return _ct();
  }

  Widget _ct() {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: CC.white),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 0.r, vertical: 10.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close)),
                  MainText(
                    _lsSel.isEmpty
                        ? widget.title
                        : _lsSel.map((e) => e.label).toList().join(', '),
                    color: CC.blue,
                    fontWeight: AppFont.medium,
                    fontSize: 15.r,
                  ),
                  IconButton(
                      onPressed: () {
                        // List<String> dat = _lsSel.map((e) => e.to).toList();
                        // logs('---dat--${dat.runtimeType}---dat--${dat}');
                        Get.back(result: _lsSel.isEmpty ? null : _lsSel);
                      },
                      icon: Icon(Icons.done)),
                ],
              )),
          if (isSearch)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.r, vertical: 3.r),
              child: SearchField(
                controller: _txtC,
                onSearchTextChanged: (query) {
                  if (query.isEmpty) {}
                  final filter =
                  _ls.where((e) => (e.label).contains(query)).toList();
                  logs('---query--$query');
                  logs('---filter--$filter');
                  return filter
                      .map((e) => SearchFieldListItem<KeyVars>(e.label,
                      item: e,
                      child: Text(e.label,
                          style: TextStyle(
                              fontSize: 15.r,
                              color: query.isEmpty ? CC.mainColor : CC.red))))
                      .toList();
                },
                key: const Key('pul_search'),
                hint: '请输入搜索' + widget.title,
                // itemHeight: 50.r, InputDecoration-contentPadding设置后itemHeight 失效
                searchInputDecoration: SearchInputDecoration(
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15.r),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CC.black, width: 1.r),
                    borderRadius: BorderRadius.circular(10.r),
                    gapPadding: 0.r,
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2.r, horizontal: 15.r),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CC.fiveColor, width: 1.r),
                    borderRadius: BorderRadius.circular(10.r),
                    gapPadding: 0.r,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  searchStyle: TextStyle(
                      fontSize: 16.r,
                      color: CC.mainColor,
                      fontWeight: AppFont.bold),
                ),
                suggestionsDecoration: SuggestionDecoration(
                    padding: EdgeInsets.only(left: 15.r, right: 3.r),
                    border: Border.all(color: CC.blue, width: 2.r),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                suggestions: _ls
                    .map((e) => SearchFieldListItem<KeyVars>(e.label,
                    item: e,
                    child: Text(e.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.r, color: CC.mainColor))))
                    .toList(),
                focusNode: focus,
                suggestionState: Suggestion.expand,
                suggestionDirection: SuggestionDirection.up,
                onTap: () {
                  // if(hasReqDone) {
                  //   if (isNil(ls.isEmpty, widget.emptyHint)) {
                  //     focus.unfocus();
                  //     return;
                  //   }
                  // }
                  // if(widget.onTap != null )widget.onTap!(focus);
                },
                onTapOutside: (x) {
                  logs('---x--$x');
                },
                onSuggestionTap: (SearchFieldListItem<KeyVars> x) {
                  logs(
                      '--11-x--${x.item.toString()}---x.searchKey--${x.searchKey}');
                  _txtC.text = '';
                  _onChanged(x.item as KeyVars);
                  focus.unfocus();
                  // if(widget.call != null )widget.call!(x.item);
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                KeyVars mo = _ls[index];
                return InkWell(
                  onTap: () {
                    _onChanged(mo);
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                    margin:
                    EdgeInsets.symmetric(horizontal: 5.r, vertical: 3.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(width: 1.r, color: CC.line),
                        color: mo.select ? CC.blue.withOpacity(0.5) : CC.bg),
                    child: Text(
                      mo.label,
                      style: TextStyle(
                          fontSize: 14.r, fontWeight: AppFont.medium),
                    ),
                  ),
                );
              },
              itemCount: _ls.length,
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(KeyVars mo) {
    if (isMulti) {
      mo.select = !mo.select;
      if (mo.select) {
        if (!_lsSel.contains(mo)) _lsSel.add(mo);
      } else {
        _lsSel.remove(mo);
      }
    } else {
      _idxSel.select = false;
      mo.select = true;
      _idxSel = mo;
      _lsSel.clear();
      _lsSel.add(mo);
    }
    if (mounted) setState(() {});
  }
}

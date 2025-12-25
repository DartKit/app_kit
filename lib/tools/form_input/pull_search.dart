import 'package:app_kit/core/kt_export.dart';
import 'package:searchfield/searchfield.dart';

import '../../../models/core/key_vars.dart';

class PullSearchField extends StatefulWidget {
  const PullSearchField(this.title,
      {super.key,
      this.argument,
      this.emptyHint = '暂无内容',
      this.tip = '',
      this.noRed = false,
      this.noRedHasGap = true,
      this.hintText = '请输入',
      required this.url,
      this.text = '',
      this.inputFormatters,
      this.dropArrow = true,
      this.oneLine = false,
      this.onTap,
      this.call,
      this.suggestionDirection = SuggestionDirection.down,
      this.check_box,
      this.onCheckBoxChange});
  final String title;
  final String text;
  final String hintText;
  final String tip;
  final bool noRed;
  final bool noRedHasGap;
  final bool dropArrow;
  final bool oneLine; // title 和 输入框一行
  final bool? check_box;
  final String url;
  final String emptyHint;
  final Function? onTap;
  final Function? call;
  final Function? onCheckBoxChange;

  final SuggestionDirection suggestionDirection;
  final List<TextInputFormatter>? inputFormatters;
  final Map<String, dynamic>? argument;

  @override
  State<PullSearchField> createState() => _DropSearchFieldState();
}

class _DropSearchFieldState extends State<PullSearchField> {
  TextEditingController _txtC = TextEditingController();
  List<KeyVars> ls = [];
  final FocusNode focus = FocusNode();
  bool hasReqDone = false;
  @override
  void initState() {
    _txtC.text = widget.text;
    if (widget.check_box == null) _req();
    super.initState();
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

    List<KeyVars>? res = await KitService.fireGet<List<KeyVars>>(widget.url, unTap: true, query: map);
    if (res != null) {
      hasReqDone = true;
      ls = res;
      if (mounted) setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant PullSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // logs('---widget.urls-0-${widget.urls}');
    // logs('---oldWidget.urls-0-${oldWidget.urls}');
    // logs('---widget.text--${widget.text}---oldWidget.text--${oldWidget.text}');
    if (widget.text != oldWidget.text) {
      _txtC.text = widget.text;
    }
    if (widget.url != oldWidget.url) {
      _req();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.oneLine) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: _title(),
          ),
          Expanded(
            flex: 5,
            child: _son(),
          ),
        ],
      ).marginOnly(top: 10.r);
    }
    return Column(
      children: [
        _title(),
        if (widget.check_box != false) _son(),
      ],
    ).marginOnly(top: 10.r);
  }

  Future<void> _check_box_fire() async {
    if (widget.check_box != null) {
      var f = !widget.check_box!;
      if (f) _req();
      if (widget.onCheckBoxChange != null && widget.check_box != null) widget.onCheckBoxChange!(f);
    }
  }

  Widget _title() {
    return Row(
      children: [
        if (widget.check_box != null)
          SizedBox(
            height: 20.r,
            width: 30.r,
            child: Checkbox(
                value: widget.check_box,
                onChanged: (x) {
                  _check_box_fire();
                }),
          ),
        Text(
          widget.noRedHasGap ? '∗' : '',
          style: TextStyle(color: (widget.noRed) ? CC.transparent : CC.red, fontSize: 16.r, fontWeight: FontWeight.w700),
        ),
        InkWell(
          onTap: () {
            if (widget.check_box != null) _check_box_fire();
          },
          child: Text(
            widget.title,
            style: TextStyle(color: CC.keyfont, fontSize: 16.r, fontWeight: widget.check_box == null ? AppFont.medium : AppFont.bold),
          ),
        ),
        if (widget.tip.isNotEmpty) Text('(${widget.tip})', style: TextStyle(color: CC.lightGrey, fontSize: 12.r, fontWeight: AppFont.regular)).marginOnly(left: 4.r),
      ],
    ).marginOnly(bottom: widget.oneLine ? 0 : 5.r);
  }

  Widget _son() {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(10.r),
      child: Container(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.r),
            // border: Border.all(width: 1.r,color: CC.line),
            ),
        // height: 44.r,
        child: Center(
          child: SearchField(
            controller: _txtC,
            onSearchTextChanged: (query) {
              if (query.isEmpty) {
                if (widget.call != null) widget.call!(KeyVars());
              }
              final filter = ls.where((e) => (e.label).contains(query)).toList();
              logs('---query--$query');
              return filter.map((e) => SearchFieldListItem<KeyVars>(e.label, item: e, child: Text(e.label, style: TextStyle(fontSize: 15.r, color: query.isEmpty ? CC.mainColor : CC.red)))).toList();
            },
            key: const Key('pul_search'),
            hint: widget.hintText,
            // itemHeight: 50.r, InputDecoration-contentPadding设置后itemHeight 失效
            searchInputDecoration: SearchInputDecoration(
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15.r),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CC.black, width: 1.r),
                borderRadius: BorderRadius.circular(10.r),
                gapPadding: 0.r,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 14.r, horizontal: 15.r),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CC.fiveColor, width: 1.r),
                borderRadius: BorderRadius.circular(10.r),
                gapPadding: 0.r,
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: widget.dropArrow
                  ? Icon(
                      Icons.keyboard_arrow_down,
                    )
                  : null,
              searchStyle: TextStyle(fontSize: 16.r, color: CC.mainColor, fontWeight: AppFont.bold),
            ),
            suggestionsDecoration: SuggestionDecoration(
                padding: EdgeInsets.only(left: 0.r, right: 0.r),
                border: Border.all(color: CC.mainColor),
                // selectionColor: CC.white,
                // shadowColor: CC.random,
                borderRadius: BorderRadius.all(Radius.circular(4.r))),
            suggestionItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              // color: CC.random
            ),
            suggestions: ls.map((e) => SearchFieldListItem<KeyVars>(e.label, item: e, child: Text(e.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.r, color: CC.mainColor)))).toList(),
            focusNode: focus,
            suggestionState: Suggestion.expand,
            suggestionDirection: widget.suggestionDirection,
            onTap: () {
              if (hasReqDone) {
                if (isNil(ls.isEmpty, widget.emptyHint)) {
                  focus.unfocus();
                  return;
                }
              }
              if (widget.onTap != null) widget.onTap!(focus);
            },
            onTapOutside: (x) {
              logs('---x--$x');
            },
            onSuggestionTap: (SearchFieldListItem<KeyVars> x) {
              logs('--11-x--${x.item.toString()}---x.searchKey--${x.searchKey}');
              focus.unfocus();
              if (widget.call != null) widget.call!(x.item);
            },
          ),
        ),
      ),
    );
  }
}

import 'package:app_kit/core/kt_export.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:searchfield/searchfield.dart';

import '../../models/core/key_vars.dart';

class DropSearchField extends StatefulWidget {
  const DropSearchField(this.title, {super.key, this.argument, this.emptyHint = '暂无内容', this.noRed = false, this.hintText = '请输入', required this.url, this.text = '', this.inputFormatters, this.dropArrow = true, this.onTap, this.call, this.suggestionDirection = SuggestionDirection.down});
  final String title;
  final String text;
  final String hintText;
  final bool noRed;
  final bool dropArrow;
  final String url;
  final String emptyHint;
  final Function? onTap;
  final Function? call;
  final SuggestionDirection suggestionDirection;
  final List<TextInputFormatter>? inputFormatters;
  final Map<String, dynamic>? argument;

  @override
  State<DropSearchField> createState() => _DropSearchState();
}

class _DropSearchState extends State<DropSearchField> {
  TextEditingController _txtC = TextEditingController();
  List<KeyVars> ls = [];
  final FocusNode focus = FocusNode();
  bool hasReqDone = false;
  @override
  void initState() {
    _txtC.text = widget.text;
    // _req();
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
  void didUpdateWidget(covariant DropSearchField oldWidget) {
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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Text(
                '∗ ',
                style: TextStyle(color: (widget.noRed) ? CC.transparent : CC.red, fontSize: 16.r, fontWeight: FontWeight.w700),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: _son(),
          ),
        ),
      ],
    ).marginOnly(top: 10.r);
  }

  Widget _son() {
    return SearchField(
      controller: _txtC,
      onSearchTextChanged: (query) {
        if (query.isEmpty) {
          if (widget.call != null) widget.call!(KeyVars());
        }
        final filter = ls.where((e) => (e.label).contains(query)).toList();
        logs('---query--$query');
        return filter.map((e) => SearchFieldListItem<KeyVars>(e.label, item: e, child: Text(e.label, style: TextStyle(fontSize: 15.r, color: query.isEmpty ? CC.mainColor : CC.red)))).toList();
      },
      key: const Key('searchfield'),
      hint: '请输入',
      itemHeight: 40.r,
      searchInputDecoration: SearchInputDecoration(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xFFF7F7F7),
        suffixIcon: widget.dropArrow
            ? Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )
            : null,
        // searchStyle: TextStyle(fontSize: 16.r,color: CC.mainColor,fontWeight: AppFont.bold) ,
      ),
      suggestionsDecoration: SuggestionDecoration(padding: EdgeInsets.only(left: 15.r, right: 3.r), border: Border.all(color: CC.mainColor), borderRadius: BorderRadius.all(Radius.circular(10.r))),
      suggestions: ls.map((e) => SearchFieldListItem<KeyVars>(e.label, item: e, child: Text(e.label , maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.r, color: CC.mainColor)))).toList(),
      focusNode: focus,
      suggestionState: Suggestion.expand,
      suggestionDirection: widget.suggestionDirection,
      onTap: () {
        if (hasReqDone) {
          if (isNil(ls.isEmpty, widget.emptyHint)) {
            focus.unfocus();
            return;
          }
        } else {
          _req();
        }
        if (widget.onTap != null) widget.onTap!(focus);
      },
      onTapOutside: (x) {
        // logs('---x--$x');
      },
      onSuggestionTap: (SearchFieldListItem<KeyVars> x) {
        // logs('--11-x--${x.item.toString()}---x.searchKey--${x.searchKey}');
        focus.unfocus();
        if (widget.call != null) widget.call!(x.item);
      },
    );
  }
}

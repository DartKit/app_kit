import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/widgets/co_pickers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_tabbar_lite/flutter_tabbar_lite.dart';

class NavItem {
  int id;
  String name;
  String obj;
  NavItem([this.id = 0, this.name = '', this.obj = '']);
}

class NavSheet extends StatefulWidget {
  List<NavItem>? ls;
  EdgeInsets? margin;
  Function call;
  Function? callNols;
  bool useList;
  int index;
  NavSheet(
      {super.key,
      this.margin,
      required this.ls,
      required this.call,
      this.callNols,
      this.index = 0,
      this.useList = false,
      });

  @override
  State<NavSheet> createState() => _NavSheetState();
}

class _NavSheetState extends State<NavSheet> {
  NavItem _item = NavItem();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ls == null)
      IconButton(onPressed: () {}, icon: Icon(Icons.refresh));
    if (widget.ls!.isEmpty) return Container();
    if (widget.ls!.isNotEmpty) {
      if (_item.name.isEmpty) {
        _item = widget.ls![widget.index];
      }
    }
    return _navSege();
  }

  Widget _navSege() {
    return  widget.useList? _listSons():_segeSons();
  }

  void _fire (position){
    if (position <= widget.ls!.length) {
      _item = widget.ls![position];
      widget.call(position, _item);
      if (mounted) setState(() {});
    }
  }

  Widget _listSons () {
    return Container(
      color: C.white,
      margin: widget.margin ?? EdgeInsets.only(top: 0.r),
      height: 30.r,
      constraints: BoxConstraints(
        maxWidth: 240.r,
        // minWidth: 70.r,
      ),
      child: FlutterTabBarLite.horizontal(
        scrollable: true,
        itemMargin : EdgeInsets.symmetric(horizontal: 2.r, vertical: 2.r),
        padding: EdgeInsets.symmetric(horizontal: 2.r),
        itemPadding : EdgeInsets.symmetric(horizontal: 2.r, vertical: 2.r),
        titles: widget.ls!.map((e) => e.name).toList(),
        gradient: const LinearGradient(
          colors: [Colors.teal, Colors.green],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        onTabChange: (index) {
          if (widget.ls!.isEmpty) {
            if (widget.callNols != null) {
              widget.callNols!();
            }
            return;
          }
          if (widget.ls!.length == 1) return;
          _fire(index);
        },
      ),
    );

  }

  Widget _segeSons (){
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.r),
        onTap: () {
          if (widget.ls!.isEmpty) {
            if (widget.callNols != null) {
              widget.callNols!();
            }
            return;
          }
          if (widget.ls!.length == 1) return;

          Pickers.showSinglePicker(
            context,
            data: widget.ls!.map((e) => e.name).toList(),
            selectData: _item.name,
            pickerStyle: CoPicker(),
            onConfirm: (p, position) {
              _fire(position);
            },
            onChanged: (p, position) {},
            onCancel: (p) {
            },
          );
        },
        child: Container(
            margin: widget.margin ?? EdgeInsets.only(top: 0.r),
            height: 30.r,
            constraints: BoxConstraints(
              maxWidth: 250.r,
              // minWidth: 70.r,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.r / 2),
                border: Border.all(width: 1.r, color: C.mainColor),
                color:  C.mainColor),
            child:  Container(
                margin: widget.margin ?? EdgeInsets.only(top: 0.r),
                height: 30.r,
                constraints: BoxConstraints(
                  maxWidth: 250.r,
                  // minWidth: 70.r,
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r / 2),
                    border: Border.all(width: 1.r, color: C.mainColor),
                    color: C.mainColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      _item.name,
                      minFontSize: 8,
                      maxFontSize: 14,
                      style:
                      TextStyle(color: C.white, fontWeight: AppFont.semiBold),
                    ),
                    if (widget.ls!.length > 1)
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.r,
                        color: C.white,
                      ).paddingOnly(left: 2.r)
                  ],
                )
            )
        ),
      ),
    );

  }
}

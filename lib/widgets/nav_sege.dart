import 'package:app_kit/core/kt_export.dart';

class SegeItem {
  String? name;
  int? id;
  SegeItem({this.id, this.name});
}

class NavSege extends StatefulWidget {
  List<SegeItem> ls;
  int initIndex;
  Function callback;
  double? width;
  double? height;
  Color? bgColor;
  NavSege(
      {super.key,
      required this.ls,
      this.initIndex = 0,
      required this.callback,
      this.width,
      this.height,
      this.bgColor});

  @override
  State<NavSege> createState() => _NavSegeState();
}

class _NavSegeState extends State<NavSege> {
  @override
  Widget build(BuildContext context) {
    return widget.width != null
        ? SizedBox(width: widget.width, child: _nav())
        : _nav();
  }

  Widget _nav() {
    return Container(
        margin: const EdgeInsets.only(bottom: 0.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: widget.bgColor ?? C.black.withOpacity(0.1)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.ls.asMap().entries.map((e) {
            int index = e.key;
            SegeItem se = e.value;
            return InkWell(
              child: Container(
                width: widget.width != null
                    ? widget.width! / widget.ls.length
                    : null,
                height: widget.height ?? 40.r,
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 8.r, bottom: 8.r, left: 10.r, right: 10.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    color: index == widget.initIndex
                        ? C.mainColor
                        : C.transparent),
                child: Text(
                  se.name ?? '',
                  style: TextStyle(
                      color: index == widget.initIndex ? C.white : C.lightGrey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              onTap: () {
                widget.initIndex = index;
                if (mounted) setState(() {});
                widget.callback(index, e.value);
              },
            );
          }).toList(),
        ));
  }
}

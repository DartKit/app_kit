import 'package:app_kit/core/kt_export.dart';

class RectSegment extends StatelessWidget {
  final Function? call;
  final List<String> ls;
  final EdgeInsets? margin;
  final Color? bdColor;
  final int index;
  const RectSegment(
      {super.key,
      this.call,
      required this.ls,
      this.margin,
      this.bdColor,
      this.index = 0});

//   @override
//   State<RectSegment> createState() => _RectSegmentState();
// }
//
// class _RectSegmentState extends State<RectSegment> {
//   String _index = '';
//
//   @override
//   void initState() {
//     if(ls.isNotEmpty) _index = ls.first;
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return _ct();
  }

  Widget _ct() {
    var cl = Color(0xFFEAEAEA);
    if (ls.isEmpty) return SizedBox();
    return Container(
      // height: 36.r,
      margin: margin ?? EdgeInsets.only(top: 10.r),
      child: SegmentedButton<String>(
        segments: ls.toList().map((e) {
          return ButtonSegment<String>(
            value: e,
            label: Center(
                child: SizedBox(
                    width: 96.r,
                    child: Text(e,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: e == ls[index] ? CC.white : CC.black)))),
            // icon: Icon(Icons.safety_check),
          );
        }).toList(),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
              BorderSide(color: bdColor ?? cl, width: 0)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.r)),
          )),
          textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14.r, fontWeight: AppFont.medium)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // visualDensity: VisualDensity(horizontal: -, vertical: -3),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return CC.mainColor;
              }
              return cl;
            },
          ),
        ),
        showSelectedIcon: false,
        // 是否允许多选
        multiSelectionEnabled: false,
        // 可选空
        emptySelectionAllowed: false,
        selected: {ls[index]},
        onSelectionChanged: (Set<String> e) {
          logs('---e--$e');
          var ind = ls.indexOf(e.first);
          if (call != null) call!(e.first, ind);
        },
      ),
    );
  }
}

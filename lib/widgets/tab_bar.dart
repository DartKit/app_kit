import 'package:app_kit/core/kt_export.dart';

class CoTabBar extends StatefulWidget {
  List<Widget> tabs;
  int index;
  Function onTab;
  EdgeInsets? labelPadding;
  TextStyle? labelStyle;
  Color? lineColor;
  CoTabBar(this.tabs,
      {super.key,
      required this.index,
      required this.onTab,
      this.labelPadding,
      this.labelStyle,
      this.lineColor});

  @override
  State<CoTabBar> createState() => _CoTabBarState();
}

class _CoTabBarState extends State<CoTabBar> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) {
      return SizedBox(
        height: 15,
      );
    }
    return _tab();
  }

  Widget _tab() {
    _tabController = TabController(
        length: widget.tabs.length, vsync: this, initialIndex: widget.index);
    return SizedBox(
      width: double.infinity,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: widget.labelStyle?.color ?? CC.mainColor,
        labelStyle: widget.labelStyle ??
            TextStyle(
                fontSize: 16.r,
                fontWeight: FontWeight.w700,
                color: CC.deepBlack), //设置选中时的字体样式，tabs里面的字体样式优先级最高
        labelPadding:
            widget.labelPadding ?? EdgeInsets.only(left: 15.r, right: 15.r),
        unselectedLabelColor: CC.deepBlack,
        unselectedLabelStyle:
            TextStyle(fontSize: 14.r), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
        indicatorColor: widget.labelStyle?.color ?? CC.mainColor, //选中下划线的颜色
        indicatorSize: TabBarIndicatorSize
            .label, //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
        // indicatorWeight: 3.r,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.r),
              bottomRight: Radius.circular(5.r)),
          color: CC.transparent,
          border: Border(
              bottom: BorderSide(
                  color: widget.lineColor ?? CC.mainColor, width: 3.r)),
        ),
        indicatorWeight: 2,
        // dividerColor: CC.red,
        dividerHeight: 0.0,
        indicatorPadding: EdgeInsets.only(bottom: 7.r, left: 17.r, right: 17.r),
        tabs: widget.tabs,
        tabAlignment: TabAlignment.start,
        splashBorderRadius: BorderRadius.circular(8.r),
        onTap: (e) {
          widget.index = e;
          widget.onTab(e);
          if (mounted) setState(() {});
        },
      ),
    );
  }
}

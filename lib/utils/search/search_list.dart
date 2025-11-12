import 'package:app_kit/core/kt_export.dart';

import '../../../models/core/sd_search.dart';

class SearchList extends StatefulWidget {
  SdSearch mo;
  // int index;
  Function onTap;
  SearchList({super.key, required this.mo, required this.onTap});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    SdSearch m = widget.mo;
    return Container(
        padding: EdgeInsets.only(bottom: 10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10.r, left: 20.r),
              child: Text(
                m.title,
                style: const TextStyle(
                    color: C.deepGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Wrap(
              spacing: 10.0, // 主轴(水平)方向间距
              alignment: WrapAlignment.start, //沿主轴方向居中
              children: List.generate(m.list.length, (key) {
                return InkWell(
                  onTap: () {
                    // m.list[key].select = !m.list[key].select;
                    // if (mounted) setState(() {});
                    widget.onTap(key);
                  },
                  child: Stack(
                    children: [
                      Container(
                          width: 289.r,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.r, vertical: 6.r),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.r, vertical: 7.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                                width: 0.5.r, color: Color(0xFFD0D0D0)),
                            color: m.list[key].select
                                ? Color(0xFFE7F5E9)
                                : C.white,
                          ),
                          child: Text(m.list[key].title,
                              style: TextStyle(
                                  color: C.keyfont,
                                  fontSize: 14.r,
                                  fontWeight: AppFont.medium))),
                      if (m.list[key].select)
                        Positioned(
                            right: 20.r,
                            bottom: 6.r,
                            child: CoImage(
                              'lib/asts/images/sel_tick2.png',
                              size: 16.r,
                              circular: 0,
                              fit: BoxFit.fill,
                            ))
                    ],
                  ),
                );
              }),
            )
          ],
        ));
  }
}

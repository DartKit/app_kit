import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/tools/button/scale_button.dart';
import '../../../models/core/sd_search.dart';

class TextTag extends StatefulWidget {
  SdSearch mo;
  // int index;
  Function onTap;
  TextTag({super.key, required this.mo, required this.onTap});

  @override
  State<TextTag> createState() => _TextTagState();
}

class _TextTagState extends State<TextTag> {
  @override
  Widget build(BuildContext context) {
    SdSearch m = widget.mo;
    return Container(
        padding: EdgeInsets.only(bottom: 10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                m.title,
                style: const TextStyle(
                    color: C.deepGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.r,
              alignment: WrapAlignment.start,
              children: List.generate(m.list.length, (key) {
                return InkWell(
                  child: ScaButton(
                    onTap: () {
                      widget.onTap(key);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                      // margin: EdgeInsets.only(bottom: 10.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              width: 1.r,
                              color: m.list[key].select
                                  ? C.mainColor
                                  : C.deepGrey),
                          color: C.white),
                      child: Text(m.list[key].title,
                          style: TextStyle(
                              color:
                                  m.list[key].select ? C.mainColor : C.deepGrey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                );
              }),
            )
          ],
        ));
  }
}

import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/tools/button/circle_button.dart';
import '../../../models/core/sd_search.dart';
import 'list_search_items.dart';

class NavSearch extends StatelessWidget {
  NavSearch(
    this.search, {
    super.key,
    this.bgColor,
    required this.call,
  });
  List<SdSearch> search;
  Function call;
  Color? bgColor;
  @override
  Widget build(BuildContext context) {
    // logs('---search.keyVs()-1-${search.keyVs()}');
    if (search.isEmpty) return Container();
    return RecButton(
      icon: Icons.search,
      isPatrolingHide: true,
      color: C.white,
      bgColor: search.keyVs().isEmpty ? C.mainColor : C.red,
      onTap: () async {
        Get.to(
                () => ListSearchItems(
                      item: search,
                    ),
                opaque: false)
            ?.then((value) {
          if (value != null) {
            call(value);
          }
        });
      },
    ).marginOnly(right: 10.r);
    // return SearchButton(isGot:search.keyVs().isNotEmpty,onTap:() {
    //   Get.to(()=>ListSearchItems(item: search,),opaque: false)?.then((value) {
    //     if (value != null) {
    //       call(value);
    //     }
    //   });
    // });
  }
}

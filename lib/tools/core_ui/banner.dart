import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/models/core/oss_obj.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';

import '../image/gallery.dart';

class CoBanner extends StatelessWidget {
  const CoBanner(this.ls, {super.key});
  final List<OssObj> ls;

  @override
  Widget build(BuildContext context) {
    if (ls.isEmpty) return SizedBox();
    return Swiper(
        itemWidth: Get.width,
        itemHeight: Get.width / 16 * 9,
        itemCount: ls.length,
        pagination: ls.length == 1
            ? null
            : SwiperPagination(
                margin: EdgeInsets.only(bottom: 15.r),
                builder: SwiperPagination.dots),
        autoplay: true,
        loop: ls.length > 1,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              gotoImagesView(urls: ls, index: index);
            },
            child: CachedNetworkImage(
              imageUrl: ls[index].url, fit: BoxFit.cover, //缓存高
              placeholder: (context, url) {
                return SizedBox.expand(
                  child: Icon(
                    Icons.image,
                    size: 50.r,
                    color: CC.bg,
                  ),
                );
              },
            ),
          );
        });
  }
}

import 'package:app_kit/core/kt_export.dart';
import 'package:cached_network_image/cached_network_image.dart';

const String _path = '';

// class FillImage extends CoImage {
//
//   FillImage({circular = 0}):super(circular: circular,fit: BoxFit.fill);
// }

class CoImage extends StatelessWidget {
  double? width;
  double? height;
  double? size;
  final String url;
  final BoxFit fit;
  final Color? color;
  final double circular;
  final double? aspectRatio;
  final bool noHolder;
  final bool isMask;
  final EdgeInsets? margin;
  final Widget? holdIma;
  final GestureTapCallback? onTap;

  CoImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.color,
    this.circular = 0,
    this.aspectRatio,
    this.noHolder = false,
    this.isMask = false,
    this.margin,
    this.holdIma,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _ct();
  }

  Widget _ct() {
    double pw = 90.r;
    if ((width == null) && (height == null)) {
      width = pw;
      height = pw;
    }
    if ((width == null) && (height != null)) width = height;
    if ((width != null) && (height == null)) height = width;
    if (size != null) {
      height = size;
      width = size;
    }
    EdgeInsets ma = margin ?? EdgeInsets.only(right: 0.r);

    Widget p = Container(
      width: width,
      height: height,
      margin: ma,
      // padding: ma,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circular),
        color: Colors.grey[300],
      ),
      child: holdIma ??
          Icon(
            Icons.photo,
            color: Colors.grey[350],
            size: pw / 2 > 40 ? 40 : pw / 2,
          ),
    );
    if (noHolder == true) p = Container();
    // var p = CircularProgressIndicator();
    if (url.isEmpty) return p;

    Widget image;
    if (url.contains('http')) {
      image = CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => p,
        width: width,
        height: height,
        color: color,
        fadeOutDuration: Duration(milliseconds: 0),
        fit: fit,
      );
    } else {
      String urlEnd = '$_path$url${url.contains('.') ? '' : '.png'}';
      if (url.contains(_path)) urlEnd = url;
      image = Image.asset(
        urlEnd,
        width: width,
        height: height,
        fit: fit,
        color: color,
      );
    }

    var me = ClipRRect(
      borderRadius: BorderRadius.circular(circular),
      child: aspectRatio == null
          ? image
          : AspectRatio(aspectRatio: aspectRatio!, child: image),
    );

    var end = Container(
      margin: ma,
      child: isMask
          ? Stack(
              alignment: Alignment.center,
              children: [
                me,
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(circular),
                    color:
                        isMask == true ? CC.hex(#FF111334, 0.02) : CC.transparent,
                  ),
                )
              ],
            )
          : me,
    );
    return onTap == null
        ? end
        : InkWell(
            onTap: onTap!,
            child: end,
          );
  }
}

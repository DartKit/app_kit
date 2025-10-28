import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textWidget(
  String value,
  TextStyle textStyle, {
  double marginLeft = 0,
  double marginRight = 0,
  double marginTop = 0,
  double marginBottom = 0,
  TextOverflow? textOver,
  int? maxLines,
  TextAlign? textAlign,
  TextDirection? textDirection,
}) {
  return Padding(
    padding: EdgeInsets.only(
        left: marginLeft.w,
        right: marginRight.w,
        top: marginTop.h,
        bottom: marginBottom.h),
    child: Text(
      value,
      overflow: textOver,
      style: textStyle,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
    ),
  );
}

// class TextWidget extends StatelessWidget {
//   final String value;
//   final TextStyle textStyle;
//   final double marginLeft;
//   final double marginRight;

//   const TextWidget({
//     super.key,
//     required this.value,
//     required this.textStyle,
//     this.marginLeft = 0,
//     this.marginRight = 0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: marginLeft.w,
//         right: marginRight.w,
//       ),
//       child: Text(
//         value,
//         style: textStyle,
//       ),
//     );
//   }
// }

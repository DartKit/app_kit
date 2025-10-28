// import 'dart:ui';
//
// import 'package:app_kit/core/kt_export.dart';
//
// class BlurRectWidget extends StatelessWidget {
//   final Widget child;
//   double _padding = 0;
//
//   BlurRectWidget({required this.child,double padding = 0}) {
//     if (padding != 0) _padding = padding;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 50),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(50)),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: 2,
//             sigmaY: 2,
//           ),
//           child: Container(
//             color: Colors.white10,
//             padding: EdgeInsets.all(_padding),
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }

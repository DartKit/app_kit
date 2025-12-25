// import 'package:app_kit/core/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
// // 日历版本的日期选择
// class DatePicker extends StatefulWidget {
//   const DatePicker({Key? key}) : super(key: key);
//
//   @override
//   _DatePickerState createState() => _DatePickerState();
// }
//
// class _DatePickerState extends State<DatePicker> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: const Color(0xee999999),
//         body: Container(
//           padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 80.0, bottom: 60.0),
//           child: Container(
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 color: CC.white
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   child: Row(
//                     children: [
//                       const Expanded(
//                         child: Text('选择日期区间', style: TextStyle(color: Color(0xff000000),fontSize: 18.0, fontWeight: FontWeight.w700),),
//                       ),
//                       Container(
//                         height: 40.0,
//                         width: 40.0,
//                         decoration: const BoxDecoration(
//                           color: CC.white,
//                           shape: BoxShape.circle,
//                         ),
//                         child: InkWell(
//                           child: const Icon(Icons.clear, color: CC.mainColor, size: 24.0,),
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
//                     child: SfDateRangePicker(
//                       selectionMode: DateRangePickerSelectionMode.range,
//                       showNavigationArrow: true,
//                       showActionButtons: true,
//                       confirmText: '确认',
//                       cancelText: '取消',
//                       onSubmit: (value) {
//                         Navigator.pop(context, value);
//                       }
//                     ),
//                   )
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }
//
// }

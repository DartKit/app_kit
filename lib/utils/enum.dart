import 'package:get/get.dart';


const String kPolyline = 'polyline';
const List<String> kPolygons = ['circle', 'polygon', 'rectangle'];

enum MarkerType {
  maintain(20, '养护人员'),
  patrol(30, '巡查人员'),
  problem(40, '问题点位'),
  all(10, '全部点位'),
  none(0, '');

  const MarkerType(this.number, this.text);
  final int number;
  final String text;
}

enum WorkType {
  none(0, ''),
  goWork(10, '上班'),
  endWork(20, '下班'),
  ;

  const WorkType(this.number, this.text);
  final int number;
  final String text;

  static WorkType num(int number) =>
      WorkType.values.firstWhereOrNull((e) => e.number == number) ??
      WorkType.none;
}

// enum ClickType {
//   none(0, '', ''),
//   marker(1, '点', 'lib/asts/images/up_ver.png'),
//   polyline(2, '线', Ast.mapLine),
//   polygon(3, '面', Ast.mapPol),
//   polyCircle(4, '圆', '');
//
//   const ClickType(this.number, this.text, this.icon);
//   final int number;
//   final String text;
//   final String icon;
// }

/*
enum AuditType {
  none(-1,''),
  pass(0, '通过'),
  fail(1, '不通过');
  const AuditType(this.number, this.text);
  final int number;
  final String text;
  static List<AuditType> get list0  => [AuditType.pass];
  static List<AuditType> get list  => [AuditType.pass,AuditType.fail];
  static AuditType name(String title) =>
      AuditType.values.firstWhereOrNull((e) => e.name == title)?? AuditType.none;
  static AuditType num(int number) =>
      AuditType.values.firstWhereOrNull((e) => e.number == number)?? AuditType.none;
  // static String str(int number) =>
  //     AssessType.values.firstWhereOrNull((e) => e.number == number)?.value?? AssessType.none.value;
}
*/

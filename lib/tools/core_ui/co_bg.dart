import 'package:app_kit/core/kt_export.dart';

class CoBg extends StatelessWidget {
  final List<Color>? colors;
  final List<Color>? colors2;
  const CoBg({super.key,this.colors,this.colors2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //渐变位置
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                stops: const [0.0, 1.0],
                colors: colors?? [Color(0xFFB5DBFF).withOpacity(0.7), Color(0xFFAEF089).withOpacity(0.6)]
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //渐变位置
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0],
                colors: colors2?? [CC.white.withOpacity(0.1), CC.white]
            ),
          ),
        ),
      ],
    );
  }
}

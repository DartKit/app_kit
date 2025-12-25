import 'package:app_kit/core/kt_export.dart';


class RecButton extends StatelessWidget {
  IconData icon;
  Function onTap;
  bool isPatrolingHide;
  Color? color;
  Color? bgColor;
  double bottom;
  double circle;
  RecButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
    this.bgColor,
    this.bottom = 0.0,
    this.circle = 0.0,
    this.isPatrolingHide = true,
  });
  @override
  Widget build(BuildContext context) {
    return CircleButton(
      icon: icon,
      onTap: onTap,
      color: color ?? CC.blue,
      bgColor: bgColor ?? CC.white,
      circle: 8.r,
      isPatrolingHide: isPatrolingHide,
    );
  }
}

class CircleButton extends StatelessWidget {
  IconData icon;
  Function onTap;
  bool isPatrolingHide;
  Color? color;
  Color? bgColor;
  double bottom;
  double btnW;
  double circle;
  CircleButton(
      {super.key,
      required this.icon,
      required this.onTap,
      this.color,
      this.bgColor,
      this.bottom = 0.0,
      this.btnW = 30.0,
      this.circle = 0.0,
      this.isPatrolingHide = true});

  @override
  Widget build(BuildContext context) {
    return _ct();
  }

  Widget _ct() {
    return  InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              width: btnW,
              height: btnW,
              margin: EdgeInsets.only(bottom: bottom),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(circle > 0 ? circle : btnW / 2),
                color: bgColor ?? CC.mainColor,
                boxShadow: const [
                  BoxShadow(
                      color: CC.lightGrey,
                      offset: Offset(0.5, .5),
                      blurRadius: 3.0 //阴影扩散程度
                      )
                ],
              ),
              child: Icon(
                icon,
                color: color ?? CC.white,
              ),
            ),
          );
  }
}

import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/tools/button/scale_button.dart';

class CallPhone extends StatelessWidget {
  const CallPhone({super.key, this.call});
  final Function? call;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (call != null) call!();
        },
        child: CoImage(
          'lib/asts/images/ic_call.png',
          width: 36.r,
          height: 36.r,
          circular: 0,
        ));
  }
}

class KitButton extends StatelessWidget {
  const KitButton(
      {super.key,
      required this.name,
      required this.onTap,
      this.bgColor,
      this.fontSize,
      this.padding,
      this.isEnable = true,
      this.height,
      this.txtColor});
  final String name;
  final VoidCallback onTap;
  final Color? bgColor;
  final Color? txtColor;
  final bool isEnable;
  final double? fontSize;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return _button();
  }

  Widget _button() {
    double hight = height ?? 35.r;
    return ScaButton(
      onTap: () {
        if (isEnable) onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: hight,
            padding: padding ?? EdgeInsets.symmetric(horizontal: 15.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(hight / 2),
                gradient: LinearGradient(
                    //渐变位置
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [C.mainColor, Colors.blueGrey.withOpacity(0.7)]),
                color: isEnable
                    ? (bgColor ?? C.mainColor)
                    : C.black.withOpacity(0.5),
                border: Border.all(width: 0.5.r, color: C.white),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(.0, 3),
                    blurRadius: 3.0,
                    color: C.fiveColor,
                  ),
                  BoxShadow(
                    offset: Offset(2.0, 2),
                    blurRadius: 2.0,
                    color: C.fiveColor,
                  ),
                ]),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: C.lightBlack,
                    fontSize: fontSize ?? 16.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


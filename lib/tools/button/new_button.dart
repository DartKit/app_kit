import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/tools/button/scale_button.dart';

class NewButton extends StatelessWidget {
  const NewButton({
    super.key,
    required this.name,
    this.onTap,
    this.bgColor,
    this.gradientColors,
    this.fontSize,
    this.padding,
    this.margin,
    this.isEnable = true,
    this.height,
    this.width,
    this.minWidth,
    this.gradient,
    this.border,
    this.txtColor,
  });
  final String name;
  final VoidCallback? onTap;
  final Color? bgColor;
  final bool isEnable;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? minWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final List<Color>? gradientColors;
  final Gradient? gradient;
  final BoxBorder? border;
  final Color? txtColor;

  @override
  Widget build(BuildContext context) {
    return _button();
  }

  Widget _button() {
    double hight = height ?? 35.r;
    return ScaButton(
        onTap: () {
          Future.delayed(Duration(milliseconds: 300), () {
            if (isEnable && (onTap != null)) onTap!();
          });
        },
        child: Container(
          height: hight,
          width: width,
          constraints: BoxConstraints(minWidth: minWidth ?? 0.0),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 15.r),
          margin: margin ?? EdgeInsets.symmetric(horizontal: 10.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: border,
              gradient: gradient ??
                  LinearGradient(
                    //渐变位置
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.0, 1.0],
                      colors: gradientColors ??
                          [Color(0xFF2FA750), Color(0xFF5ED48D)]),
              color: isEnable
                  ? (bgColor ?? C.mainColor)
                  : C.black.withOpacity(0.5),
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
                  color: txtColor ?? C.lightBlack,
                  fontSize: fontSize ?? 16.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}


import 'package:app_kit/core/kt_export.dart';
import 'package:app_kit/widgets/kit_views.dart';

class TxtButton extends StatelessWidget {
  const TxtButton({
    super.key,
    required this.name,
    this.isEnable = true,
    required this.onTap,
    this.width,
    this.fontSize,
    this.bgColor,
    this.margin,
    this.gradientColors,
    this.gradient,
    this.border,
    this.txtColor,
  });
  final String name;
  final VoidCallback onTap;
  final bool isEnable;
  final double? width;
  final double? fontSize;
  final Color? bgColor;
  final EdgeInsets? margin;
  final List<Color>? gradientColors;
  final Gradient? gradient;
  final BoxBorder? border;
  final Color? txtColor;
  @override
  Widget build(BuildContext context) {
    return NewButton(
        padding: EdgeInsets.symmetric(horizontal: 5.r),
        height: 35.r,
        bgColor: bgColor,
        fontSize: (name.length <= 6 ? fontSize : 13.r),
        isEnable: isEnable,
        width: width,
        gradientColors: gradientColors,
        gradient: gradient,
        margin: margin ?? EdgeInsets.symmetric(horizontal: 4.r),
        border: border,
        txtColor: txtColor,
        name: name,
        onTap: onTap);
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton(
      {super.key,
      required this.name,
      this.isEnable = true,
      required this.onTap,
      this.width,
      this.minWidth,
      this.fontSize,
      this.bgColor,
      this.padding});
  final String name;
  final VoidCallback onTap;
  final bool isEnable;
  final double? width;
  final double? minWidth;
  final double? fontSize;
  final EdgeInsets? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        NewButton(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 10.r),
            height: 35.r,
            bgColor: bgColor,
            minWidth: minWidth,
            fontSize: (name.length <= 6 ? fontSize : 13.r),
            isEnable: isEnable,
            width: width,
            margin: EdgeInsets.symmetric(horizontal: 4.r),
            name: name,
            onTap: onTap),
      ],
    );
  }
}

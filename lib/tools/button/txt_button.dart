import 'package:app_kit/core/kt_export.dart';

import 'new_button.dart';

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


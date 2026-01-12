
import 'package:app_kit/core/kt_export.dart';
import 'new_button.dart';

class InfoButton extends StatelessWidget {
  const InfoButton(
      {super.key,
        required this.name,
        this.isEnable = true,
        required this.onTap,
        this.height,
        this.width,
        this.minWidth,
        this.fontSize,
        this.bgColor,
        this.padding});
  final String name;
  final VoidCallback onTap;
  final bool isEnable;
  final double? height;
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
            height: height??35.r,
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

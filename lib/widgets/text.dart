import 'package:app_kit/core/kt_export.dart';

class MainText extends Text {
  dynamic text;
  String? tip;
  Color? color;
  Color? tipColor;
  double? fontSize;
  double? top;
  FontWeight? fontWeight;
  @override
  TextAlign? textAlign;
  EdgeInsets? padding;
  EdgeInsets? margin;
  bool zeroShow;
  @override
  int? maxLines;
  MainText(this.text,
      {Key? key,
      this.top,
      this.padding,
      this.margin,
      this.color,
      this.tipColor,
      this.zeroShow = true,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.tip,
      this.maxLines})
      : super(text == null ? '' : '$text', key: key);

  @override
  Widget build(BuildContext context) {
    String txt = text == null ? '' : '$text';
    if (txt.isEmpty) return SizedBox();
    if (txt == 'null') return SizedBox();
    if (txt.isNum && (txt.toDouble == 0) && !zeroShow) return SizedBox();
    String tip2 = tip ?? '';
    if (tip2.isEmpty)
      return Text(
        txt,
        maxLines: maxLines ?? 100,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
            color: color ?? (txt.isNum ? C.blue : Color(0xFF5F5F5F)),
            fontSize: fontSize ?? 13.r,
            fontWeight: fontWeight ?? AppFont.semiBold),
      );

    return Text.rich(
      TextSpan(
        children: [
          if (tip2.isNotEmpty)
            TextSpan(
              text: tip,
              style: TextStyle(
                  fontWeight: AppFont.semiBold,
                  fontSize: fontSize ?? 13.r,
                  color: tipColor ?? (color ?? Color(0xFF5F5F5F))),
            ),
          TextSpan(
            text: txt,
          ),
        ],
      ),
      style: TextStyle(
          fontWeight: tip2.isNotEmpty ? AppFont.medium : AppFont.semiBold,
          fontSize: fontSize ?? 13.r,
          color: color ?? (txt.isNum ? C.blue : Color(0xFF5F5F5F))),
      textAlign: TextAlign.start,
    ).marginOnly(top: top ?? 0);

    /*
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          (tip??''),
          maxLines: maxLines??100,
          textAlign: textAlign??TextAlign.start,
          style: TextStyle(
              color: tipColor ?? Color(0xFF5F5F5F),
              fontSize: fontSize ?? 13.r,
              fontWeight: fontWeight ?? AppFont.semiBold),
        ),
        Expanded(
          child: Text(
            text,
            maxLines: maxLines??100,
            textAlign: textAlign??TextAlign.start,
            style: TextStyle(
                color: color ?? Color(0xFF5F5F5F),
                fontSize: fontSize ?? 13.r,
                fontWeight: fontWeight ?? AppFont.medium),
          ),
        )
      ],
    );
    */
  }
}

class CoText extends MainText {
  CoText(super.text,
      {super.key, super.tip, super.textAlign, Color? color, double? fontSize})
      : super(
            color: color ?? C.mainColor,
            fontSize: fontSize ?? 16.r,
            fontWeight: AppFont.bold);
}

class CoText14 extends MainText {
  CoText14(super.text,
      {super.key,
      super.tip,
      int? maxLines,
      Color? color,
      super.textAlign,
      fontWeight})
      : super(
          color: color ?? C.mainColor,
          fontSize: 14.r,
          fontWeight: fontWeight ?? AppFont.bold,
        );
}

class RedText extends MainText {
  RedText(super.text, {super.key, super.tip, super.textAlign})
      : super(color: C.red, fontSize: 14.r, fontWeight: AppFont.semiBold);
}

class BlackText extends MainText {
  BlackText(super.text,
      {super.key,
      super.tip,
      double? fontSize,
      Color? color,
      super.textAlign,
      FontWeight? fontWeight})
      : super(
            color: color ?? C.black,
            fontSize: fontSize ?? 14.r,
            fontWeight: fontWeight ?? AppFont.bold,
            padding: EdgeInsets.only(top: 3.r));
}

class SubText extends MainText {
  SubText(super.text,
      {super.key,
      super.tip,
      double? fontSize,
      super.color,
      super.textAlign,
      FontWeight? fontWeight})
      : super(
            fontSize: fontSize ?? 14.r,
            fontWeight: fontWeight ?? AppFont.medium,
            padding: EdgeInsets.zero);
}

// class Top8Text extends MainText {
//   Top8Text(String text,{String? tip,double? fontSize,Color? color,TextAlign? textAlign})
//       :super(text,tip: tip,color: color??C.deepGrey,fontWeight: AppFont.medium,top: 8.r,textAlign: textAlign);
// }

class Top2Text extends MainText {
  Top2Text(super.text,
      {super.key,
      super.tip,
      double? fontSize,
      super.color,
      super.textAlign,
      double? top,
      FontWeight? fontWeight,
      zeroShow = true,
      super.tipColor})
      : super(
            fontWeight: fontWeight ?? AppFont.medium,
            top: top ?? 2.r,
            zeroShow: zeroShow);
}

class Top2TextBold extends MainText {
  Top2TextBold(super.text,
      {super.key, super.tip, double? fontSize, super.color, super.textAlign,super.tipColor})
      : super(fontWeight: AppFont.semiBold, top: 2.r);
}

class Txt4Must extends MainText {
  Txt4Must(String text,
      {super.key,
      String? tip,
      double? fontSize,
      Color? color,
      TextAlign? textAlign})
      : super(text.isEmpty ? '-' : text,
            tip: tip,
            color: color,
            fontWeight: AppFont.semiBold,
            top: 4.r,
            textAlign: textAlign);
}

class Txt6Must extends MainText {
  Txt6Must(String text,
      {super.key,
      String? tip,
      double? fontSize,
      Color? color,
      TextAlign? textAlign,
      FontWeight? fontWeight})
      : super(text.isEmpty ? '-' : text,
            tip: tip,
            color: color,
            fontWeight: fontWeight ?? AppFont.semiBold,
            top: 6.r,
            textAlign: textAlign,
            fontSize: 14.r);
}
// class Top4Text extends Top2Text {
//   Top4Text()
//       :super(top: 4.r);
// }

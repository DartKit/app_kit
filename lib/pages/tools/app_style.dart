import 'package:app_kit/core/kt_export.dart';

class ListBox extends Container {
  ListBox({
    super.key,
    required final List<Widget> children,
    final GestureTapCallback? onTap,
    EdgeInsets? padding,
    Color? bgColor,
    Color? bdColor,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
    // EdgeInsets? margin
  }) : super(
            margin:
                const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 14),
            padding: padding ??
                const EdgeInsets.only(
                    left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 2.r, color: bdColor ?? C.white),
                color: bgColor ?? C.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(.0, 3),
                    blurRadius: 4.0,
                    color: Color(0x0D000000),
                  ),
                  BoxShadow(
                    offset: Offset(3.0, 5),
                    blurRadius: 1.0,
                    color: Color(0x0D000000),
                  ),
                ]),
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.start,
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                children: children,
              ),
            ));
}

class ListBox2 extends Container {
  ListBox2(
      {super.key,
      required final List<Widget> children,
      final GestureTapCallback? onTap,
      EdgeInsets? padding,
      Color? bgColor,
      Color? bdColor,
      CrossAxisAlignment? crossAxisAlignment,
      MainAxisAlignment? mainAxisAlignment})
      : super(
            margin:
                const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 14),
            padding: padding ??
                const EdgeInsets.only(
                    left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: bgColor ?? C.white,
                gradient: LinearGradient(
                    //渐变位置
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 1.0],
                    colors: const [Color(0xFFECF6F1), Color(0xFFFDFEFE)]),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(.0, 3),
                    blurRadius: 4.0,
                    color: C.fiveColor,
                  ),
                  BoxShadow(
                    offset: Offset(3.0, 3),
                    blurRadius: 4.0,
                    color: C.fiveColor,
                  ),
                ]),
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.start,
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                children: children,
              ),
            ));
}

class ListBoxDot extends ListBox {
  ListBoxDot({
    super.key,
    required final List<Widget> children,
    final GestureTapCallback? onTap,
    super.bgColor,
    super.bdColor,
  }) : super(
            padding: const EdgeInsets.only(
                left: 15.0, right: 0.0, top: 10.0, bottom: 10.0),
            children: [
              InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: C.fiveColor,
                      size: 20.r,
                    ),
                  ],
                ),
              )
            ]);
}

class ListBoxDot2 extends Container {
  ListBoxDot2(
      {super.key,
      required final List<Widget> children,
      final GestureTapCallback? onTap,
      Color? bgColor,
      Color? bdColor,
      EdgeInsets? padding,
      EdgeInsets? margin,
      CrossAxisAlignment? crossAxisAlignment,
      bool hideDot = false,
      MainAxisAlignment? mainAxisAlignment})
      : super(
            margin: margin ??
                const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 14),
            padding: padding ??
                const EdgeInsets.only(
                    left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: bgColor ?? C.white,
                gradient: LinearGradient(
                    //渐变位置
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 1.0],
                    colors: const [Color(0xFFECF6F1), Color(0xFFFDFEFE)]),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(.0, 3),
                    blurRadius: 4.0,
                    color: C.fiveColor,
                  ),
                  BoxShadow(
                    offset: Offset(3.0, 3),
                    blurRadius: 4.0,
                    color: C.fiveColor,
                  ),
                ]),
            child: InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ),
                  if (!hideDot)
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: C.fiveColor,
                      size: 20.r,
                    ),
                ],
              ),
            ));
}

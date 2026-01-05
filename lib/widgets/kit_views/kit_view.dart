import 'package:app_kit/core/kt_export.dart';
import 'package:url_launcher/url_launcher.dart';

class KitView {
  static Future<void> callPhone(String number, {bool now = false}) async {
    if (number.isEmpty) return;
    if (now) {
      launch("tel:$number");
      return;
    }
    if (isIOS) {
      launch("tel:$number");
      return;
    }

    alert(
        content: '您确定要打电话吗?',
        sure: () {
          launch("tel:$number");
        });
  }


  static Future<void> alert({
    title = '提示',
    cancelName = '取消',
    sureName = '确定',
    required content,
    VoidCallback? sure,
    VoidCallback? cancel,
    bool noCancel = false,
    bool autoDismiss = true,
    bool barrierDismissible = true,
    Alignment? alignment,
    Color? sureColor,
  }) async {
    showDialog<void>(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: alignment,
            surfaceTintColor: CC.white,
            // backgroundColor: CC.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            titlePadding: EdgeInsets.zero,
            title: SizedBox(
              height: 45.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 16.r, fontWeight: AppFont.heavy),
                  ),
                ],
              ),
            ),
            // contentTextStyle: TextStyle(fontSize: 16.r,color: CC.black),
            contentPadding: EdgeInsets.zero,
            content: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 1.r, color: CC.lightBlack),
                  SizedBox(
                    height: 16.r,
                  ),
                  content.runtimeType == String
                      ? Text(
                          content.toString(),
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontSize: 15.r,
                              fontWeight: AppFont.medium,
                              color: Color(0xFF666666)),
                        )
                      : content,
                  SizedBox(
                    height: 16.r,
                  ),
                  Container(
                      height: 1.r,
                      color: ((cancel == null) && (sure == null))
                          ? CC.transparent
                          : CC.lightBlack),
                ],
              ),
            ),
            actionsPadding: EdgeInsets.zero,
            actions: ((cancel == null) && (sure == null))
                ? null
                : [
                    Container(
                      padding: EdgeInsets.only(bottom: 0.r),
                      // color: CC.white,
                      height: 45.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (noCancel == false)
                            Expanded(
                              child: InkWell(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12.r)),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    if (cancel != null) cancel();
                                  },
                                  child: Center(
                                      child: Text(
                                    cancelName,
                                    style: TextStyle(
                                        color: CC.subText4,
                                        fontSize: 14.r,
                                        fontWeight: AppFont.medium),
                                  ))),
                            ),
                          if ((noCancel == false) && (sure != null))
                            Container(width: 1.r, color: CC.lightBlack),
                          if (sure != null)
                            Expanded(
                              child: InkWell(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12.r)),
                                  onTap: () async {
                                    if (autoDismiss) Navigator.pop(context);
                                    sure();
                                  },
                                  child: Center(
                                      child: Text(
                                    sureName,
                                    style: TextStyle(
                                        color: sureColor ?? CC.mainColor,
                                        fontSize: 14.r,
                                        fontWeight: AppFont.medium),
                                  ))),
                            ),
                        ],
                      ),
                    )
                  ],
          );
        });
  }

  /// 问题分类
  static Widget sortName(String sortName,
      {EdgeInsets? margin,
      Color? bgColor,
      double? fontSize,
      EdgeInsets? padding}) {
    if (sortName.isEmpty) return Container();
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 5.r),
      padding: padding ??
          EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0, bottom: 3.0),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: CC.fiveColor, offset: Offset(1.0, 1.0), blurRadius: 5.0)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(10)),
          color: bgColor ?? CC.mainColor),
      child: Text(
        sortName.toString(),
        style: TextStyle(
            color: CC.white,
            fontSize: fontSize ?? 12.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }


  static Widget textTag(text,
      {Function? callback,
      double? height,
      Color? bgColor,
      Color? color,
      EdgeInsets? padding,
      EdgeInsets? margin,
      fontSize,
      bool fixFel = false}) {
    // fixFel 异常拉伸撑满屏时候修复
    var vi = Text(
      text.toString(),
      style: TextStyle(
          color: color ?? CC.white,
          fontSize: fontSize ?? 12.r,
          fontWeight: FontWeight.w700),
    );
    return InkWell(
      onTap: () {
        if (callback != null) callback();
      },
      child: Container(
        height: padding != null ? null : height ?? 25.r,
        padding: padding ??
            const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5)),
          color: bgColor ?? CC.mainColor,
        ),
        child: fixFel ? vi : Center(child: vi),
      ),
    );
  }

  static Widget serial_no(String? serial,
      {double? top, String? copy, String? tip, double? fontSize}) {
    if (serial?.isNotEmpty == false) return Container();
    return Container(
      padding: EdgeInsets.only(top: top ?? 0.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainText(
            serial,
            tip: tip ?? '问题编号c',
            fontWeight: AppFont.semiBold,
            color: CC.subText3,
            fontSize: fontSize ?? 13.r,
          ),
          Offstage(
            offstage: ((copy != null) && (copy.isEmpty)),
            child: InkWell(
              onTap: () {
                (copy ?? serial!).copyToClipboard;
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 3.r, right: 0),
                  child: CoImage(
                    'packages/app_kit/lib/ast/images/ic_copy.png',
                    size: 12.r,
                    circular: 0,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  static Widget complaint_no(String serial, {double? top}) {
    return serial_no(serial, top: top, tip: '申诉编号：');
  }
}

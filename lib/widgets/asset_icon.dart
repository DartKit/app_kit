/*
 * @Author: 木筏及 7751579+mufaji@user.noreply.gitee.com
 * @Date: 2024-07-24 14:33:18
 * @LastEditors: 木筏及 7751579+mufaji@user.noreply.gitee.com
 * @LastEditTime: 2024-11-01 16:37:30
 * @FilePath: /lelingbang/lib/presentation/components/widgets/asset_icon.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget assetIconWidget({
  required double widthSize,
  required String iconName,
  double marginLeft = 0,
  double marginRight = 0,
  double marginTop = 0,
  double marginBottom = 0,
  double? heightSize,
  double radiusSize = 0,
  BoxFit boxfit = BoxFit.contain,
  Color? color = null,
  VoidCallback? ontap,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: widthSize.w,
      height: heightSize?.h ?? widthSize.w, //默认以宽为主正方形
      margin: EdgeInsets.only(
          left: marginLeft.w,
          right: marginRight.w,
          top: marginTop.h,
          bottom: marginBottom.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radiusSize.r)),
        // image: DecorationImage(
        //   image: AssetImage(iconName),
        //   fit: boxfit,
        // ),
      ),
      child: Image.asset(
        iconName,
        fit: boxfit,
        color: color,
      ),
    ),
  );
}

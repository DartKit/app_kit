import 'package:app_kit/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Add on Text {
  Text get red => Text(data!, style: style?.copyWith(color: C.red));
  Text get orange => Text(data!, style: style?.copyWith(color: C.orange));
  Text get mainColor => Text(data!, style: style?.copyWith(color: C.mainColor));
  Text get deepGrey => Text(data!, style: style?.copyWith(color: C.deepGrey));
  Text get lightGrey => Text(data!, style: style?.copyWith(color: C.lightGrey));
  Text get lightBlack =>
      Text(data!, style: style?.copyWith(color: C.lightBlack));
  Text get keyColor => Text(data!, style: style?.copyWith(color: C.keyColor));
  Text get white => Text(data!, style: style?.copyWith(color: C.white));

  Text get normal =>
      Text(data!, style: style?.copyWith(fontWeight: FontWeight.w400));
  Text get regular =>
      Text(data!, style: style?.copyWith(fontWeight: FontWeight.w400));
  Text get plain =>
      Text(data!, style: style?.copyWith(fontWeight: FontWeight.w400));
  Text get medium =>
      Text(data!, style: style?.copyWith(fontWeight: FontWeight.w500));
  Text get semiBold =>
      Text(data!, style: style?.copyWith(fontWeight: FontWeight.w600));
  Text get bold =>
      Text(data!, style: style?.copyWith(fontWeight: FontWeight.w700));
  Text get extraBold =>
      Text(data!, style: style?.copyWith(fontWeight: FontWeight.w800));

  Text get ft08 => Text(
        data!,
        style: style?.copyWith(fontSize: 8.r),
      );
  Text get ft09 => Text(
        data!,
        style: style?.copyWith(fontSize: 9.r),
      );
  Text get ft10 => Text(
        data!,
        style: style?.copyWith(fontSize: 10.r),
      );
  Text get ft11 => Text(
        data!,
        style: style?.copyWith(fontSize: 11.r),
      );
  Text get ft12 => Text(
        data!,
        style: style?.copyWith(fontSize: 12.r),
      );
  Text get ft13 => Text(
        data!,
        style: style?.copyWith(fontSize: 13.r),
      );
  Text get ft14 => Text(
        data!,
        style: style?.copyWith(fontSize: 14.r),
      );
  Text get ft15 => Text(
        data!,
        style: style?.copyWith(fontSize: 15.r),
      );
  Text get ft16 => Text(
        data!,
        style: style?.copyWith(fontSize: 16.r),
      );
  Text get ft17 => Text(
        data!,
        style: style?.copyWith(fontSize: 17.r),
      );
  Text get ft18 => Text(
        data!,
        style: style?.copyWith(fontSize: 18.r),
      );
  Text get ft19 => Text(
        data!,
        style: style?.copyWith(fontSize: 19.r),
      );
  Text get ft20 => Text(
        data!,
        style: style?.copyWith(fontSize: 20.r),
      );
  Text get ft21 => Text(
        data!,
        style: style?.copyWith(fontSize: 21.r),
      );
  Text get ft22 => Text(
        data!,
        style: style?.copyWith(fontSize: 22.r),
      );
  Text get ft23 => Text(
        data!,
        style: style?.copyWith(fontSize: 23.r),
      );
  Text get ft24 => Text(
        data!,
        style: style?.copyWith(fontSize: 24.r),
      );
}

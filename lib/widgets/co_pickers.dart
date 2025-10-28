import 'package:app_kit/core/kt_export.dart';
import 'package:flutter_pickers/style/picker_style.dart';

class CoPicker extends PickerStyle {
  CoPicker({Key? key, Widget? title, double? textSize})
      : super(
            textSize: textSize ?? 20.r,
            commitButton: CoText('确认').paddingOnly(right: 20.r),
            cancelButton: CoText(
              '取消',
              color: C.deepBlack,
            ).paddingOnly(left: 20.r),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Container(child: title ?? Container())],
            ),
            headDecoration: BoxDecoration(
                color: C.white.withOpacity(0.93),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))));
}

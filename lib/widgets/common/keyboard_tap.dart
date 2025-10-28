import 'package:flutter/material.dart';

Widget FocueKeyboard(context,
    {required Widget childWidget, VoidCallback? onPointDown}) {
  return Listener(
    behavior: HitTestBehavior.translucent,
    onPointerDown: (PointerDownEvent event) {
      onPointDown ?? FocusScope.of(context).requestFocus(FocusNode());
    },
    child: childWidget,
  );
}

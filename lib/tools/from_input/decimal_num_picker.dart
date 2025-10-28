import 'package:app_kit/core/kt_export.dart';

import '../../utils/input_formatter.dart';
export 'package:decimal/decimal.dart';

class DecimalNumPicker extends StatefulWidget {
  const DecimalNumPicker({
    super.key,
    required this.initValue,
    this.title,
    this.selValue,
    required this.minValue,
    required this.maxValue,
    required this.decimalPlaces,
    // required this.onChanged,
  });

  final String? title;
  final double initValue;
  final double? selValue;
  final double minValue;
  final double maxValue;
  final int decimalPlaces;
  // final ValueChanged<String> onChanged;

  @override
  State<DecimalNumPicker> createState() => _DecimalNumPickerState();
}

class _DecimalNumPickerState extends State<DecimalNumPicker> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: (widget.selValue ?? widget.initValue)
            .toStringAsFixed(widget.decimalPlaces));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get intOnly => widget.decimalPlaces == 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        color: C.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close, color: C.green, size: 26.r),
              ),
              Text(widget.title ?? '',
                  style: TextStyle(
                      color: C.black,
                      fontSize: 14.r,
                      fontWeight: AppFont.regular)),
              InkWell(
                onTap: () {
                  double currentValue =
                      double.tryParse(_controller.text) ?? (intOnly ? 0 : 0.0);
                  logs('--currentValue--:$currentValue');
                  // widget.onChanged(_controller.text);
                  Get.back(result: _controller.text);
                },
                child: Icon(Icons.done_outlined, color: C.green, size: 26.r),
              ),
            ],
          ).marginOnly(bottom: 10.r),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(width: 1.r, color: C.line),
                  color: C.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.r,
                      height: 50.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(width: 1.r, color: C.line),
                        color: C.blue,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.remove, color: C.white),
                          onPressed: () {
                            double currentValue =
                                double.tryParse(_controller.text) ??
                                    (intOnly ? 0 : 0.0);
                            _changeValue(currentValue - (intOnly ? 1 : 0.1));
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: C.bg,
                      ),
                      width: 100.r,
                      child: TextField(
                        controller: _controller,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          intOnly
                              ? FilteringTextInputFormatter.allow(
                                  RegExp(r'[\d]'))
                              : FilteringTextInputFormatter.allow(
                                  RegExp(r'[\d.]')),
                          if (!intOnly)
                            NumberTextInputFormatter(digit: 1), //限制小数位数
                        ],
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: '请输入'),
                        textAlign: TextAlign.center,
                        onChanged: (value) {},
                      ),
                    ),
                    Container(
                      width: 50.r,
                      height: 50.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(width: 1.r, color: C.line),
                          color: C.blue),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.add, color: C.white),
                          onPressed: () {
                            double currentValue =
                                double.tryParse(_controller.text) ??
                                    (intOnly ? 0 : 0.0);
                            _changeValue(currentValue + (intOnly ? 1 : 0.1));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]
            .map((e) => Padding(
                padding: EdgeInsets.only(bottom: 20.r, top: 0.r), child: e))
            .toList(),
      ),
    );
  }

  void _changeValue(double newValue) {
    if (newValue != double.tryParse(_controller.text)) {
      // _changeValue_fire(newValue);
      newValue = newValue.clamp(
        widget.minValue,
        widget.maxValue,
      );
      _controller.text = newValue.toStringAsFixed(widget.decimalPlaces);
      if (mounted) setState(() {});
    }
  }
}

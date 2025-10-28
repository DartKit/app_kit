import 'package:app_kit/core/kt_export.dart';

enum TypeArrow { dowm, right }

class CellForm extends StatefulWidget {
  bool showArrow;
  // bool isInput;
  var onTap;
  var clear;
  // var onChanged;
  Function? onCheckBoxChange;
  String title;
  String? text;
  String hintText;
  String tip;
  InputEvent? input;
  Widget? tail;
  Color? bgColor;
  TypeArrow arrow;
  TextStyle? titleStyle;
  TextStyle? hintStyle;
  TextStyle? textStyle;
  TextStyle? inputTextStyle;
  TextEditingController? controller;
  bool enable;
  bool? check_box;
  bool? check_bool;
  bool is_required;
  EdgeInsets? padding;
  EdgeInsets? titlePadding;
  Decoration? decoration;
  TextInputType? keyboardType;

  CellForm({
    super.key,
    required this.text,
    this.onTap,
    this.showArrow = true,
    this.title = '',
    this.tip = '',
    this.hintText = '请选择',
    this.clear,
    // this.isInput = false,
    // this.onChanged,
    this.input,
    this.tail,
    this.bgColor,
    this.arrow = TypeArrow.dowm,
    this.titleStyle,
    this.hintStyle,
    this.textStyle,
    this.inputTextStyle,
    this.controller,
    this.enable = true,
    this.padding,
    this.check_box,
    this.check_bool,
    this.is_required = false,
    this.onCheckBoxChange,
    this.titlePadding,
    this.decoration,
    this.keyboardType,

  });

  @override
  State<CellForm> createState() => _CellFormState();
}

class _CellFormState extends State<CellForm> {
  // String? _text;
  // bool _isOpen = false;
  final TextEditingController _vcInput = TextEditingController();
// 字母
  RegExp letterReg = RegExp("[a-zA-Z]");
// 中文正则
  RegExp chineseReg = RegExp("[\u4e00-\u9fa5]");
// 字母、数字和汉字正则
  RegExp letterDigitChineseReg = RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]");

  // 字母、数字正则
  RegExp letterDigitReg = RegExp("[a-zA-Z]|[0-9]");
// emoji表情正则
  RegExp emojiReg = RegExp(
      "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]");

  @override
  void initState() {
    super.initState();
    _vcInput.text = widget.text ?? '';

    // if (widget.controller == null) {
    // }else {
    //   // widget.controller!.text = widget.text ?? '';
    // }
  }

  @override
  void didUpdateWidget(covariant CellForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // logs('---widget.text--${widget.text}---oldWidget.text--${oldWidget.text}');
    if (widget.text != oldWidget.text) {
      _vcInput.text = widget.text ?? '';
      _vcInput.selection = TextSelection.fromPosition(
          TextPosition(offset: _vcInput.text.length));
    }
    // _isOpen = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isTextNil = false;
    if ([null, '', 'null', ' '].contains(widget.text)) isTextNil = true;
    // logs('-----widget.text--${widget.text}-isTextNil--${isTextNil}');
    // if (widget.text == null) isTextNil = true;
    // if (widget.text == '') isTextNil = true;
    // if (widget.text == 'null') isTextNil = true;
    // if (widget.text == ' ') isTextNil = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title.isEmpty ? Container() : _title(widget.title),
        if (widget.check_bool != true)
          if (widget.check_box != false)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.onTap != null) {
                  Get.focusScope?.unfocus();
                  if (widget.enable) {
                    widget.onTap();
                  }
                }
                // _isOpen = !_isOpen;
                if (mounted) setState(() {});
              },
              child: Container(
                padding: widget.padding ??
                    const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 13.0, bottom: 13.0),
                decoration: widget.decoration ??
                    BoxDecoration(
                        border: Border.all(color: C.fiveColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: widget.bgColor ?? C.white),
                child: widget.input != null
                    ? _contentInput()
                    : _contentSelect(isTextNil),
              ),
            ),
      ],
    );
  }

  Widget _contentInput() {
    widget.controller ??= _vcInput;
    return Row(
      children: [
        Flexible(
          child: TextField(
            readOnly: !widget.enable,
            enabled: widget.enable,
            controller: widget.controller,
            keyboardType: widget.keyboardType ?? TextInputType.multiline,
            maxLines: widget.input!.maxLines,
            minLines: widget.input!.minLines,
            inputFormatters: widget.input!.inputFormatters ??
                [
                  // 白名单设置，只允许输入小写的a-z
                  // FilteringTextInputFormatter.allow(RegExp("[a-z]")),
                  // 黑名单设置，不允许输入emoji表情和中文
                  FilteringTextInputFormatter.deny(emojiReg),
                  // FilteringTextInputFormatter.deny(chineseReg),
                  // 只允许输入数字
                  // FilteringTextInputFormatter.digitsOnly,
                  // FilteringTextInputFormatter.singleLineFormatter,
                  // LengthLimitingTextInputFormatter(5)
                ],
            style: widget.inputTextStyle ??
                TextStyle(
                    color: C.mainColor,
                    fontSize: 16.r,
                    fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? TextStyle(color: C.deepGrey),
              border: InputBorder.none,
              // border: OutlineInputBorder(
              //   ///设置边框四个角的弧度
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //     ///用来配置边框的样式
              //     borderSide: BorderSide(
              //       ///设置边框的颜色
              //       color: Colors.red,
              //       ///设置边框的粗细
              //       width: 2.0,
              //     ),
              // ),
              isCollapsed: true,
              // disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
            onChanged: (x) {
              if (widget.input?.onChanged != null) {
                logs('---_vcInput.text----x--$x');
                // if (_vcInput.text != x) {
                //   widget.input?.onChanged!(x);
                // }
                widget.input?.onChanged!(x);
              }
              if (mounted) setState(() {});
            },
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
            },
          ),
        ),
        (widget.enable
            ? InkWell(
                child: Icon(
                  Icons.cancel,
                  color: widget.controller!.text.isEmpty
                      ? Colors.transparent
                      : C.fiveColor,
                ),
                onTap: () {
                  if (widget.clear != null) {
                    widget.clear();
                  }
                  widget.controller!.clear();
                  if (widget.input!.onChanged != null) {
                    widget.input?.onChanged!('');
                  }
                  if (mounted) setState(() {});
                })
            : Container()),
        if (widget.tail != null) widget.tail!
      ],
    );
  }

  Widget _contentSelect(bool isTextNil) {
    return Container(
      // height: 20.r,
      child: Row(
        children: [
          Expanded(
            child: Text(
              isTextNil ? widget.hintText : widget.text!,
              maxLines: 30,
              style: TextStyle(
                color: isTextNil
                    ? (widget.hintStyle?.color ?? C.deepGrey)
                    : (widget.textStyle?.color ?? C.mainColor),
                fontSize: isTextNil
                    ? (widget.hintStyle?.fontSize ?? 16.r)
                    : (widget.textStyle?.fontSize ?? 16.r),
                fontWeight: isTextNil
                    ? (widget.hintStyle?.fontWeight ?? FontWeight.w700)
                    : (widget.textStyle?.fontWeight ?? FontWeight.w700),
              ),
            ),
          ),
          widget.clear == null
              ? Container()
              : (widget.enable
                  ? InkWell(
                      onTap: widget.clear,
                      child: Container(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Icon(
                          Icons.cancel,
                          color: isTextNil ? Colors.transparent : C.fiveColor,
                        ),
                      ),
                    )
                  : Container()),
          widget.showArrow == false
              ? Container()
              : Container(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Icon(
                    // _isOpen ? Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,
                    widget.arrow == TypeArrow.dowm
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    color: C.deepGrey,
                  ))
        ],
      ),
    );
  }

  Future<void> _check_box_fire() async {
    if (widget.check_box != null) widget.check_box = !widget.check_box!;
    if (widget.check_box == false) _vcInput.text = '';
    if (mounted) setState(() {});
    if (widget.onCheckBoxChange != null && widget.check_box != null)
      widget.onCheckBoxChange!(widget.check_box);
  }

  Widget _title(String name) {
    return Container(
      padding: widget.titlePadding ?? const EdgeInsets.only(top: 13, bottom: 8),
      child: Row(
        children: [
          if (widget.is_required)
            Text('∗',
                style: TextStyle(
                    color: C.red,
                    fontSize: 16.r,
                    fontWeight: FontWeight.w700)),
          if (widget.check_box != null)
            SizedBox(
              height: 20.r,
              width: 30.r,
              child: Checkbox(
                  value: widget.check_box,
                  onChanged: (x) {
                    _check_box_fire();
                  }),
            ),
          InkWell(
            onTap: _check_box_fire,
            child: Text(
              name,
              style: widget.titleStyle ??
                  TextStyle(
                      color: C.deepBlack,
                      fontSize: 16.r,
                      fontWeight: FontWeight.w700),
            ),
          ),
          if (widget.tip.isNotEmpty)
            Text('(${widget.tip})',
                    style: TextStyle(
                        color: C.lightGrey,
                        fontSize: 12.r,
                        fontWeight: AppFont.regular))
                .marginOnly(left: 4.r),
        ],
      ),
    );
  }
}

class InputEvent {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  InputEvent(
      {this.onChanged,
      this.onSubmitted,
      this.inputFormatters,
      this.maxLines = 15,
      this.minLines = 3
      });
}

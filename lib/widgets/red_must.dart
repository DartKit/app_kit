import 'package:app_kit/core/kt_export.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RedMust extends StatelessWidget {
  const RedMust(this.title,
      {super.key, this.hasGap = true, this.noRed = false, this.dot = '∗ '});
  final String title;
  final String dot;
  final bool hasGap;
  final bool noRed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasGap)
          Text(
            dot,
            style: TextStyle(
                color: (hasGap && noRed) ? C.transparent : C.red,
                fontSize: 16.r,
                fontWeight: FontWeight.w700),
          ),
        Text(
          title,
          style: TextStyle(
              color: C.keyfont, fontSize: 15.r, fontWeight: AppFont.medium),
        )
      ],
    );
  }
}

class RedMustInput extends StatefulWidget {
  const RedMustInput(this.title,
      {super.key,
      this.noRed = false,
      this.call,
      this.hintText = '请输入',
      this.text = '',
      this.inputFormatters,
      this.dropArrow = false,
      this.set4txt = false,
      this.onTap,
      this.keyboardType});
  final String title;
  final String text;
  final String hintText;
  final bool noRed;
  final bool dropArrow;
  final bool set4txt;
  final Function? call;
  final Function? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  @override
  State<RedMustInput> createState() => _RedMustInputState();
}

class _RedMustInputState extends State<RedMustInput> {
  TextEditingController _txtC = TextEditingController();

  @override
  void initState() {
    _txtC.text = widget.text;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RedMustInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // logs('---widget.urls-0-${widget.urls}');
    // logs('---oldWidget.urls-0-${oldWidget.urls}');
    logs('---widget.text--${widget.text}---oldWidget.text--${oldWidget.text}');
    if (widget.text != oldWidget.text) {
      _txtC.text = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: widget.set4txt ? 2 : 1,
          child: Row(
            children: [
              Text(
                '∗ ',
                style: TextStyle(
                    color: (widget.noRed) ? C.transparent : C.red,
                    fontSize: 16.r,
                    fontWeight: FontWeight.w700),
              ),

              AutoSizeText(widget.title),
              // Text(
              //   widget.title,
              //   style: TextStyle(
              //       color: C.keyfont,
              //       fontSize: 15.r,
              //       fontWeight: AppFont.medium),
              // )
            ],
          ),
        ),
        Expanded(
          flex: widget.set4txt ? 5 : 2,
          child: InkWell(
            onTap: () {
              if (widget.onTap != null) widget.onTap!();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: TextField(
                controller: _txtC,
                inputFormatters: widget.inputFormatters ?? [],
                enabled: !widget.dropArrow,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF7F7F7),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon:
                      widget.dropArrow ? Icon(Icons.arrow_drop_down) : null,
                ),
                keyboardType: widget.keyboardType,
                style: TextStyle(color: C.keyfont),
                onTap: () {
                  logs('---_txtC.text--${_txtC.text}');
                },
                onChanged: (x) {
                  if (widget.call != null) widget.call!(x);
                },
              ),
            ),
          ),
        ),
      ],
    ).marginOnly(top: 10.r);
  }
}

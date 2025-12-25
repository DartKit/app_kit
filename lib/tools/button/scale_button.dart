

import '../../core/kt_export.dart';

class ScaButton extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final Duration animationDuration;
  final double scaleFactor;
  final String name;
  final Color? bgColor;
  final Color? txtColor;
  final bool isEnable;
  final double? fontSize;
  final double? height;
  final double? radius;
  final EdgeInsets? padding;
  final bool isExpanded;
  final bool inReq;
  final LinearGradient? gradient;

  const ScaButton({
    Key? key,
    this.child,
    this.onTap,
    this.animationDuration = const Duration(milliseconds: 100),
    this.scaleFactor = 0.85,
    this.name = '',
    this.bgColor,
    this.fontSize,
    this.padding,
    this.isEnable = true,
    this.height,
    this.txtColor,
    this.radius,
    this.isExpanded = false,
    this.inReq = false,
    this.gradient,
  }) : super(key: key);

  @override
  _ScaButtonState createState() => _ScaButtonState();
}

class _ScaButtonState extends State<ScaButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    if (widget.isEnable && (widget.onTap != null)) widget.onTap!();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    // if (widget.onTap != null) {
    //   widget.onTap!();
    // }
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isExpanded? Row(
      children: [
        Expanded(child: _ct())
      ]
    ):_ct();
  }

  Widget _ct (){
    return GestureDetector(
      onTap: _onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child != null? (widget.inReq
            ? _circularProgressIndicator():widget.child) : _button(),
      ),
    );
  }

  Widget _circularProgressIndicator() {
    return SizedBox(height: 16.r, width: 16.r, child: CircularProgressIndicator(strokeWidth: 1.5.r, color: CC.white));
  }

  Widget _button() {
    double hight = widget.height ?? 40.r;
    return Container(
      height: hight,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 15.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius ?? hight / 2),
          gradient: widget.gradient?? LinearGradient(
            //渐变位置
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0],
            colors: [CC.keyColor, Colors.blueGrey.withOpacity(0.7)],
          ),
          color: widget.isEnable ? (widget.bgColor ?? CC.keyColor) : CC.black.withOpacity(0.5),
          border: Border.all(width: 0.5.r, color: CC.white),
          boxShadow: const [
            BoxShadow(offset: Offset(0, 2), blurRadius: 2.0, color: CC.FF666666),
            BoxShadow(offset: Offset(1.0, 2), blurRadius: 2.0, color: CC.FF666666),
          ]),
      child:  Center(
        child: widget.inReq
            ? _circularProgressIndicator()
            : Text(
          widget.name,
          style: TextStyle(color: widget.txtColor?? CC.font, fontSize: widget.fontSize ?? 16.r, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

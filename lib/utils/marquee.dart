import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  const Marquee({required this.child, this.speed = 10.0,this.justOne = false, Key? key})
      : super(key: key);
  final Widget child;
  final num speed;
  final bool justOne;

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;
  late ScrollController _scrctrl;
  SingleChildScrollView? _scrollView;

  double _space = 0;

  @override
  void initState() {
    super.initState();

    _scrctrl = ScrollController();

    if(widget.justOne == false) {
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: widget.speed * 1000 ~/1));
      _animation = Tween(
        begin: 0.1,
        end: 100.0,
      ).animate(_controller!);
      _animation.addListener(() {
        if (_scrctrl.hasClients) {
          if (_scrollView != null && _scrctrl.position.hasContentDimensions) {
            var index = _animation.value / 100;
            _scrctrl.jumpTo(index * _scrctrl.position.maxScrollExtent);
          }
          if (_scrctrl.position.hasViewportDimension && _space == 0) {
            setState(() {
              _space = _scrctrl.position.viewportDimension;
            });
          }
        }
      });
      _controller!.repeat();
    }
    // if(_controller != null) {
    //   logs('---_controller--${_controller}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    _scrollView = SingleChildScrollView(
      controller: _scrctrl,
      scrollDirection: Axis.vertical,
      child: _scrctrl.hasClients
          ? _son()
          : (widget.justOne? _son(): const SizedBox()),
    );
    return _scrollView ?? Row();
  }

  Widget _son (){
    return Column(
      children: [
        SizedBox(
          width: _space,
        ),
        widget.child,
        SizedBox(
          width: _space,
        ),
      ],
    );
  }

  @override
  void dispose() {
     if(widget.justOne == false) {
       if(_controller != null) _controller?.dispose();
     }
    super.dispose();
  }
}


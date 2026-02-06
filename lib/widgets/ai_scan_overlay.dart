import 'package:app_kit/core/kt_export.dart';
import 'dart:math' as math;

/// AI识图扫描组件
/// 用于覆盖在图片上方，展示高科技感的扫描动画
class AiScanOverlay extends StatefulWidget {
  final bool isScanning;
  // final VoidCallback? onScanComplete;

  const AiScanOverlay({Key? key, this.isScanning = true,})
    : super(key: key);

  @override
  State<AiScanOverlay> createState() => _AiScanOverlayState();
}

class _TechDot {
  final Offset position;
  final double maxRadius;
  final double phase; // 0.0 to 1.0, animation offset

  _TechDot({
    required this.position,
    required this.maxRadius,
    required this.phase,
  });
}

class _AiScanOverlayState extends State<AiScanOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scanAnimation;
  final List<_TechDot> _bgDots = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scanAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Initialize random dots
    for (int i = 0; i < 20; i++) {
      _bgDots.add(
        _TechDot(
          position: Offset(_random.nextDouble(), _random.nextDouble()),
          maxRadius: _random.nextDouble() * 2 + 1, // 1.0 - 3.0
          phase: _random.nextDouble(),
        ),
      );
    }

    if (widget.isScanning) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AiScanOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning != oldWidget.isScanning) {
      if (widget.isScanning) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3), // 半透明背景，增强沉浸感
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          // 扫描动画层
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _ScanPainter(
                  scanValue: _scanAnimation.value,
                  color: const Color(0xFF00F0FF), // 赛博朋克青色
                  dots: _bgDots,
                ),
                child: Container(),
              );
            },
          ),

          // ... (rest of the build method) ...
          // Note: Since I am replacing the Class structure to add the dots list,
          // but avoiding replacing the huge chunk of unchanged build method code if possible.
          // However, the cleanest way to introduce `_bgDots` which are needed in `_ScanPainter`
          // is to replace the StatefulWidget and CustomPainter classes entirely or carefully partial replacement.
          // Given the limitations, I'll rewrite the necessary parts.

          // WAIT, I need to provide the *complete* replacement content for the range I select.
          // To be safe and precise, I will just replace the whole file content related to the logic and painter.

          // Let's refine the strategy. I'll replace the State class and the Painter class.
          // But the previous viewing showed I have line numbers.
          // I will target from line 18 (`class _AiScanOverlayState ...`) to the end of the file.

          // Actually, I can keep `_AiScanOverlayState` mostly as is, just add `_bgDots` initialization
          // and pass it to `_ScanPainter`.

          // Let's replace from `class _AiScanOverlayState` down to the end of file.
          // This ensures everything is consistent.

          // Re-reading `build` method in my replacement content below...
          // I'll make sure to include the "AI Analysis..." text part which was in the original file.

          // Wait, the prompt says "Implement random background dots".
          // I will reimplement the whole file content from line 18 to the end to be safe.
          // This avoids "replace multiple non-contiguous" complexity if I just do one big block.
          // But wait, `build` method is long.

          // Let's do it in chunks? No, single replace is better for consistency if the file isn't huge.
          // The file is ~276 lines. That's fine.

          // Let's construct the ReplacementContent carefully.

          // ... (rest of build)
          // 中心文字提示 (可选，增加科技感)
          if (widget.isScanning)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.r,
                      vertical: 6.r,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      border: Border.all(
                        color: const Color(0xFF00F0FF).withOpacity(1),
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 12.r,
                          height: 12.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF00F0FF),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          " AI 分析中...",
                          style: TextStyle(
                            color: const Color(0xFF00F0FF),
                            fontSize: 12,
                            fontFamily: 'Courier',
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: const Color(0xFF00F0FF).withOpacity(1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ScanPainter extends CustomPainter {
  final double scanValue;
  final Color color;
  final List<_TechDot> dots;

  _ScanPainter({
    required this.scanValue,
    required this.color,
    required this.dots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // 绘制随机背景点
    _drawBackgroundDots(canvas, size);

    // 绘制四个角
    final double cornerLength = 400.0;

    // 左上
    canvas.drawPath(
      Path()
        ..moveTo(0, cornerLength)
        ..lineTo(0, 0)
        ..lineTo(cornerLength, 0),
      paint,
    );

    // 右上
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, cornerLength),
      paint,
    );

    // 右下
    canvas.drawPath(
      Path()
        ..moveTo(size.width, size.height - cornerLength)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width - cornerLength, size.height),
      paint,
    );

    // 左下
    canvas.drawPath(
      Path()
        ..moveTo(cornerLength, size.height)
        ..lineTo(0, size.height)
        ..lineTo(0, size.height - cornerLength),
      paint,
    );

    // 绘制扫描线
    final double scanY = size.height * scanValue;

    // 扫描线本体
    canvas.drawLine(
      Offset(0, scanY),
      Offset(size.width, scanY),
      Paint()
        ..color = color
        ..strokeWidth = 2.0
        ..shader = LinearGradient(
          colors: [color.withOpacity(0), color, color.withOpacity(0)],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromLTWH(0, scanY, size.width, 2)),
    );

    // 扫描线拖尾/光效区域
    final Path scanArea = Path()
      ..moveTo(0, scanY)
      ..lineTo(size.width, scanY)
      ..lineTo(size.width, scanY - 40) // 拖尾长度
      ..lineTo(0, scanY - 40)
      ..close();

    // 绘制拖尾光效效果
    canvas.drawPath(
      scanArea,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [color.withOpacity(0.3), Colors.transparent],
        ).createShader(Rect.fromLTWH(0, scanY - 40, size.width, 40)),
    );

    // 随机绘制一些科技感的装饰点或十字准星
    _drawDecorations(canvas, size, paint);
  }

  void _drawBackgroundDots(Canvas canvas, Size size) {
    final dotPaint = Paint()..style = PaintingStyle.fill;

    for (var dot in dots) {
      // 计算每个点的当前缩放/透明度
      // 使用 scanValue 作为时间驱动，加上每个点的 phase
      // sin 产生呼吸效果
      double animationValue = math.sin(
        (scanValue * math.pi * 2) + (dot.phase * math.pi * 2),
      );
      // 归一化到 0.0 - 1.0
      animationValue = (animationValue + 1) / 2;

      final double currentRadius = dot.maxRadius * (0.5 + 0.5 * animationValue);
      final double currentOpacity = 0.3 + 0.5 * animationValue; // 0.3 - 0.8

      dotPaint.color = color.withOpacity(currentOpacity * 0.5); // 基础透明度再乘一下

      canvas.drawCircle(
        Offset(dot.position.dx * size.width, dot.position.dy * size.height),
        currentRadius,
        dotPaint,
      );
    }
  }

  void _drawDecorations(Canvas canvas, Size size, Paint paint) {
    final smallPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 1;

    // 绘制中间的瞄准十字
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final crossSize = 10.0;

    canvas.drawLine(
      Offset(centerX - crossSize, centerY),
      Offset(centerX + crossSize, centerY),
      smallPaint,
    );
    canvas.drawLine(
      Offset(centerX, centerY - crossSize),
      Offset(centerX, centerY + crossSize),
      smallPaint,
    );

    // 绘制边缘的刻度装饰
    for (int i = 1; i < 10; i++) {
      double y = size.height * (i / 10);
      canvas.drawLine(Offset(0, y), Offset(4, y), smallPaint);
      canvas.drawLine(
        Offset(size.width - 4, y),
        Offset(size.width, y),
        smallPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ScanPainter oldDelegate) {
    return oldDelegate.scanValue != scanValue;
  }
}

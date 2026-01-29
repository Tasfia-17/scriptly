import 'package:flutter/material.dart';

class BackgroundDecor extends StatelessWidget {
  final BackgroundStyle style;
  final Widget child;
  const BackgroundDecor({super.key, required this.style, required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final baseTop = switch (style) {
      BackgroundStyle.clouds => [const Color(0xFFEFF7FF), const Color(0xFFCFE9FF)],
      BackgroundStyle.forest => [const Color(0xFFEFFCF3), const Color(0xFFCDEEDC)],
      BackgroundStyle.deepSea => [const Color(0xFFE8F6FF), const Color(0xFFB8E1FF)],
      BackgroundStyle.waves => [const Color(0xFFF2FBFF), const Color(0xFFD9F2FF)],
      BackgroundStyle.pastel => [colors.surface, colors.surfaceContainerHighest],
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: baseTop),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: _SoftShapes(style: style)),
          child,
        ],
      ),
    );
  }
}

enum BackgroundStyle { clouds, forest, deepSea, waves, pastel }

class _SoftShapes extends StatelessWidget {
  final BackgroundStyle style;
  const _SoftShapes({required this.style});
  @override
  Widget build(BuildContext context) {
    final List<Widget> blobs = switch (style) {
      BackgroundStyle.clouds => [
          _Blob(color: const Color(0xCCFFFFFF), top: -40, left: -20, size: 220),
          _Blob(color: const Color(0xCCFFFFFF), top: 80, right: -40, size: 280),
          _Blob(color: const Color(0x88FFFFFF), bottom: -30, left: 40, size: 240),
        ],
      BackgroundStyle.forest => [
          _Blob(color: const Color(0x99E8F9EC), top: -30, left: -40, size: 220),
          _Blob(color: const Color(0x66CFF0DA), bottom: -20, right: -30, size: 260),
        ],
      BackgroundStyle.deepSea => [
          _Blob(color: const Color(0xAAE0F3FF), top: -20, right: -20, size: 240),
          _Blob(color: const Color(0x66B5E2FF), bottom: -50, left: -10, size: 300),
        ],
      BackgroundStyle.waves => [
          _Wave(bottom: 120, intensity: 0.6),
          _Wave(bottom: 60, intensity: 0.8),
          _Wave(bottom: 0, intensity: 1),
        ],
      BackgroundStyle.pastel => [
          _Blob(color: const Color(0x22FFFFFF), top: 20, left: -10, size: 160),
          _Blob(color: const Color(0x22FFFFFF), bottom: 40, right: -10, size: 200),
        ],
    };

    return IgnorePointer(ignoring: true, child: Stack(children: blobs));
  }
}

class _Blob extends StatelessWidget {
  final Color color; final double size; final double? top; final double? left; final double? right; final double? bottom;
  const _Blob({required this.color, required this.size, this.top, this.left, this.right, this.bottom});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, left: left, right: right, bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size)),
      ),
    );
  }
}

class _Wave extends StatelessWidget {
  final double bottom; final double intensity; const _Wave({required this.bottom, required this.intensity});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0, right: 0, bottom: bottom,
      child: SizedBox(
        height: 120,
        child: CustomPaint(painter: _WavePainter(intensity: intensity)),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double intensity; _WavePainter({required this.intensity});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(colors: [const Color(0xFF9ED9FF), const Color(0xFF6BC0FF)])
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path()..moveTo(0, size.height);
    final mid = size.width / 2;
    path.cubicTo(mid * 0.3, 80 * intensity, mid * 0.7, 40 * intensity, mid, 70 * intensity);
    path.cubicTo(mid * 1.3, 100 * intensity, mid * 1.7, 20 * intensity, size.width, 60 * intensity);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

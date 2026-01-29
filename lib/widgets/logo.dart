import 'package:flutter/material.dart';

class ScriptlyLogo extends StatelessWidget {
  final double size; final bool showTagline; final Color? color;
  const ScriptlyLogo({super.key, this.size = 48, this.showTagline = false, this.color});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = color ?? scheme.primary;
    return Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(width: size, height: size, decoration: BoxDecoration(color: c.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(size))),
          CustomPaint(size: Size(size * .9, size * .9), painter: _GlyphPainter(color: c)),
        ],
      ),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Scriptly', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5)),
        if (showTagline)
          Text('From idea to script, visuals, and voice in one flow', style: Theme.of(context).textTheme.labelSmall),
      ])
    ]);
  }
}

class _GlyphPainter extends CustomPainter {
  final Color color; _GlyphPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final pen = Paint()..color = color..style = PaintingStyle.fill;
    final tri = Path()
      ..moveTo(size.width * 0.15, size.height * 0.25)
      ..lineTo(size.width * 0.85, size.height * 0.35)
      ..lineTo(size.width * 0.45, size.height * 0.8)
      ..close();
    canvas.drawPath(tri, pen);
    final circle = Offset(size.width * 0.35, size.height * 0.35);
    canvas.drawCircle(circle, size.width * 0.12, pen..color = color.withValues(alpha: 0.9));
    final stem = RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.55, size.height * 0.18, size.width * 0.12, size.height * 0.6), Radius.circular(size.width * 0.08));
    canvas.drawRRect(stem, pen..color = color);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

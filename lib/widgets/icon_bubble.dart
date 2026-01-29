import 'package:flutter/material.dart';

class IconBubble extends StatelessWidget {
  final IconData icon; final VoidCallback onTap; final List<Color>? colors; final double size;
  const IconBubble({super.key, required this.icon, required this.onTap, this.colors, this.size = 76});
  @override
  Widget build(BuildContext context) {
    final c = colors ?? [const Color(0xFFBEE3FF), const Color(0xFF7DC8FF)];
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: c, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(size),
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: size * 0.5)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GuideOverlay extends StatelessWidget {
  final String text; final VoidCallback? onClose;
  const GuideOverlay({super.key, required this.text, this.onClose});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Material(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(20),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.support_agent, color: Colors.blueAccent),
              const SizedBox(width: 10),
              Flexible(child: Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700))),
              const SizedBox(width: 8),
              if (onClose != null)
                IconButton(onPressed: onClose, icon: const Icon(Icons.close, color: Colors.blueGrey))
            ]),
          ),
        ),
      ),
    );
  }
}

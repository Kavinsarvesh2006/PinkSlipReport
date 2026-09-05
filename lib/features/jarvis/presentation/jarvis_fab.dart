import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class JarvisFab extends StatelessWidget {
  final VoidCallback onTap;

  const JarvisFab({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            center: Alignment(-0.3, -0.3),
            radius: 0.8,
            colors: [Color(0xFF2D2A55), Color(0xFF100E24)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF100E24).withValues(alpha: 0.4),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppTheme.violet600.withValues(alpha: 0.25),
              blurRadius: 0,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF67E8F9), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF67E8F9).withValues(alpha: 0.7),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF67E8F9),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF67E8F9),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

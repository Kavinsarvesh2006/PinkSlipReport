import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:slipreport/core/theme/auth_theme.dart';

// ═══════════════════════════════════════════════════════════════════
//  Sign In Illustration — person with phone & bar chart
// ═══════════════════════════════════════════════════════════════════

class SignInIllustration extends StatelessWidget {
  const SignInIllustration({super.key, this.height = 160});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _SignInPainter()),
    );
  }
}

class _SignInPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.45;
    final cy = size.height * 0.55;

    // ── decorative dots ───────────────────────────────────────
    _drawDot(canvas, Offset(cx + 60, cy - 65), 4, AuthTheme.primaryBlue);
    _drawPlus(canvas, Offset(cx + 55, cy - 50), 6, AuthTheme.primaryBlue);
    _drawDot(canvas, Offset(cx - 55, cy + 30), 3, AuthTheme.illustrationBlue.withValues(alpha: 0.4));

    // ── bar chart ─────────────────────────────────────────────
    final barPaint = Paint()..style = PaintingStyle.fill;
    const barW = 10.0;
    const gap = 6.0;
    final barX = cx - 20.0;
    final barBaseY = cy + 30;

    final bars = [28.0, 42.0, 34.0, 52.0];
    final barColors = [
      AuthTheme.primaryBlue.withValues(alpha: 0.4),
      AuthTheme.primaryBlue.withValues(alpha: 0.6),
      AuthTheme.primaryBlue.withValues(alpha: 0.5),
      AuthTheme.primaryBlue,
    ];

    for (var i = 0; i < bars.length; i++) {
      barPaint.color = barColors[i];
      final x = barX + i * (barW + gap);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, barBaseY - bars[i], barW, bars[i]),
          const Radius.circular(3),
        ),
        barPaint,
      );
    }

    // ── person body ───────────────────────────────────────────
    // Head (yellow circle)
    final headCenter = Offset(cx + 12, cy - 28);
    canvas.drawCircle(
      headCenter,
      18,
      Paint()..color = AuthTheme.illustrationYellow,
    );

    // Hair
    final hairPath = Path()
      ..addArc(
        Rect.fromCircle(center: headCenter, radius: 18),
        -math.pi * 0.85,
        math.pi * 0.7,
      )
      ..close();
    canvas.drawPath(
      hairPath,
      Paint()..color = AuthTheme.primaryBlueDark,
    );

    // Body
    final bodyPath = Path()
      ..moveTo(cx - 2, cy - 10)
      ..quadraticBezierTo(cx - 8, cy + 20, cx - 4, cy + 40)
      ..lineTo(cx + 28, cy + 40)
      ..quadraticBezierTo(cx + 32, cy + 20, cx + 26, cy - 10)
      ..close();
    canvas.drawPath(
      bodyPath,
      Paint()..color = AuthTheme.illustrationBlue,
    );

    // ── phone in hand ─────────────────────────────────────────
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx + 40, cy - 5), width: 16, height: 28),
      const Radius.circular(3),
    );
    canvas.drawRRect(
      phoneRect,
      Paint()..color = AuthTheme.primaryBlueDark,
    );
    // phone screen
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx + 40, cy - 5), width: 12, height: 22),
        const Radius.circular(2),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );

    // ── arm reaching to phone ─────────────────────────────────
    final armPaint = Paint()
      ..color = AuthTheme.illustrationBlue
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx + 22, cy), Offset(cx + 34, cy - 2), armPaint);
  }

  void _drawDot(Canvas canvas, Offset pos, double r, Color c) {
    canvas.drawCircle(pos, r, Paint()..color = c);
  }

  void _drawPlus(Canvas canvas, Offset pos, double s, Color c) {
    final paint = Paint()
      ..color = c
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(pos.dx - s, pos.dy), Offset(pos.dx + s, pos.dy), paint);
    canvas.drawLine(Offset(pos.dx, pos.dy - s), Offset(pos.dx, pos.dy + s), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════
//  Sign Up Illustration — person with floating app icons
// ═══════════════════════════════════════════════════════════════════

class SignUpIllustration extends StatelessWidget {
  const SignUpIllustration({super.key, this.height = 160});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _SignUpPainter()),
    );
  }
}

class _SignUpPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.55;

    // ── decorative elements ───────────────────────────────────
    // Floating app icon — green rounded square
    _drawRoundedSquare(
      canvas,
      Offset(cx - 50, cy - 45),
      14,
      AuthTheme.illustrationGreen,
    );
    // Floating app icon — pink rounded square
    _drawRoundedSquare(
      canvas,
      Offset(cx + 30, cy - 50),
      12,
      AuthTheme.illustrationPink.withValues(alpha: 0.8),
    );
    // small teal dot
    _drawDot(canvas, Offset(cx - 40, cy - 55), 3, Colors.teal);
    // small blue dot
    _drawDot(canvas, Offset(cx + 48, cy - 38), 3, AuthTheme.primaryBlue);

    // ── main circle behind person ─────────────────────────────
    canvas.drawCircle(
      Offset(cx, cy),
      42,
      Paint()..color = AuthTheme.illustrationYellow.withValues(alpha: 0.35),
    );

    // ── person ────────────────────────────────────────────────
    // Head
    final headCenter = Offset(cx, cy - 22);
    canvas.drawCircle(
      headCenter,
      18,
      Paint()..color = AuthTheme.illustrationYellow,
    );

    // Hair (blue)
    final hairPath = Path()
      ..addArc(
        Rect.fromCircle(center: headCenter, radius: 19),
        -math.pi,
        math.pi * 0.55,
      );
    // curl on top
    hairPath.quadraticBezierTo(
      cx - 10, cy - 52,
      cx + 5, cy - 46,
    );
    hairPath.close();
    canvas.drawPath(
      hairPath,
      Paint()..color = AuthTheme.primaryBlueDark,
    );

    // Body
    final bodyPath = Path()
      ..moveTo(cx - 16, cy - 4)
      ..quadraticBezierTo(cx - 22, cy + 22, cx - 18, cy + 42)
      ..lineTo(cx + 18, cy + 42)
      ..quadraticBezierTo(cx + 22, cy + 22, cx + 16, cy - 4)
      ..close();
    canvas.drawPath(
      bodyPath,
      Paint()..color = AuthTheme.illustrationBlue,
    );

    // ── laptop ────────────────────────────────────────────────
    // Screen
    final laptopScreen = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy + 25), width: 50, height: 18),
      const Radius.circular(3),
    );
    canvas.drawRRect(
      laptopScreen,
      Paint()..color = AuthTheme.primaryBlueDark.withValues(alpha: 0.8),
    );
    // base
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 28, cy + 34, 56, 4),
        const Radius.circular(2),
      ),
      Paint()..color = AuthTheme.primaryBlueDark.withValues(alpha: 0.6),
    );

    // ── floating chat / message icon (top-right of person) ───
    final iconBg = Paint()..color = AuthTheme.illustrationBlue.withValues(alpha: 0.2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx - 38, cy - 30), width: 18, height: 18),
        const Radius.circular(4),
      ),
      iconBg,
    );
    // tiny line inside
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(cx - 43, cy - 31), Offset(cx - 33, cy - 31), linePaint);
    canvas.drawLine(Offset(cx - 43, cy - 28), Offset(cx - 36, cy - 28), linePaint);
  }

  void _drawRoundedSquare(Canvas canvas, Offset center, double halfSize, Color c) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: halfSize * 2, height: halfSize * 2),
        Radius.circular(halfSize * 0.35),
      ),
      Paint()..color = c,
    );
  }

  void _drawDot(Canvas canvas, Offset pos, double r, Color c) {
    canvas.drawCircle(pos, r, Paint()..color = c);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════
//  Forgot Password Illustration — person at a laptop
// ═══════════════════════════════════════════════════════════════════

class ForgotPasswordIllustration extends StatelessWidget {
  const ForgotPasswordIllustration({super.key, this.height = 160});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _ForgotPasswordPainter()),
    );
  }
}

class _ForgotPasswordPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.55;

    // ── decorative circles / dots ─────────────────────────────
    canvas.drawCircle(
      Offset(cx + 55, cy - 45),
      5,
      Paint()
        ..color = AuthTheme.illustrationGreen
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    canvas.drawCircle(
      Offset(cx - 50, cy - 40),
      4,
      Paint()
        ..color = AuthTheme.primaryBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    _drawDot(canvas, Offset(cx + 48, cy - 30), 3, AuthTheme.illustrationBlue.withValues(alpha: 0.5));

    // ── person ────────────────────────────────────────────────
    // Head
    final headCenter = Offset(cx + 10, cy - 24);
    canvas.drawCircle(
      headCenter,
      17,
      Paint()..color = AuthTheme.illustrationYellow.withValues(alpha: 0.9),
    );

    // Hair — dark, short
    final hairPath = Path()
      ..addArc(
        Rect.fromCircle(center: headCenter, radius: 18),
        -math.pi * 0.95,
        math.pi * 0.6,
      );
    hairPath.close();
    canvas.drawPath(
      hairPath,
      Paint()..color = const Color(0xFF333333),
    );

    // Glasses
    final glassPaint = Paint()
      ..color = const Color(0xFF333333)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(cx + 5, cy - 23), 5, glassPaint);
    canvas.drawCircle(Offset(cx + 16, cy - 23), 5, glassPaint);
    canvas.drawLine(Offset(cx + 10, cy - 23), Offset(cx + 11, cy - 23), glassPaint);

    // Body (yellow top)
    final bodyPath = Path()
      ..moveTo(cx - 4, cy - 8)
      ..quadraticBezierTo(cx - 10, cy + 16, cx - 6, cy + 38)
      ..lineTo(cx + 26, cy + 38)
      ..quadraticBezierTo(cx + 30, cy + 16, cx + 24, cy - 8)
      ..close();
    canvas.drawPath(
      bodyPath,
      Paint()..color = AuthTheme.illustrationYellow,
    );

    // ── laptop ────────────────────────────────────────────────
    // Screen (angled slightly)
    final screenPath = Path()
      ..moveTo(cx - 35, cy + 8)
      ..lineTo(cx - 15, cy - 8)
      ..lineTo(cx - 5, cy - 8)
      ..lineTo(cx - 12, cy + 8)
      ..close();
    canvas.drawPath(
      screenPath,
      Paint()..color = AuthTheme.primaryBlueDark,
    );
    // Screen highlight
    final highlightPath = Path()
      ..moveTo(cx - 33, cy + 6)
      ..lineTo(cx - 17, cy - 5)
      ..lineTo(cx - 8, cy - 5)
      ..lineTo(cx - 14, cy + 6)
      ..close();
    canvas.drawPath(
      highlightPath,
      Paint()..color = Colors.white.withValues(alpha: 0.2),
    );

    // Keyboard / base
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 38, cy + 8, 36, 5),
        const Radius.circular(1.5),
      ),
      Paint()..color = AuthTheme.primaryBlueDark.withValues(alpha: 0.6),
    );

    // ── arm resting on keyboard ───────────────────────────────
    final armPaint = Paint()
      ..color = AuthTheme.illustrationYellow.withValues(alpha: 0.85)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx, cy + 6), Offset(cx - 20, cy + 10), armPaint);
  }

  void _drawDot(Canvas canvas, Offset pos, double r, Color c) {
    canvas.drawCircle(pos, r, Paint()..color = c);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

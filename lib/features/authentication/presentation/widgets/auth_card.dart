import 'package:flutter/material.dart';
import 'package:slipreport/core/theme/auth_theme.dart';

/// A rounded white card that wraps authentication content.
///
/// Constrains its max width to [maxWidth] (defaults to 420 px) so that
/// the layout looks good on both phones and tablets.
class AuthCard extends StatelessWidget {
  const AuthCard({
    super.key,
    required this.child,
    this.maxWidth = 420,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          padding: const EdgeInsets.symmetric(
            horizontal: AuthTheme.cardPaddingH,
            vertical: AuthTheme.cardPaddingV,
          ),
          decoration: BoxDecoration(
            color: AuthTheme.cardBackground,
            borderRadius: BorderRadius.circular(AuthTheme.cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:slipreport/core/theme/auth_theme.dart';

/// Horizontal divider with a centered label such as "Or Continue with".
class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
    this.label = 'Or Continue with',
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AuthTheme.dividerColor, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(label, style: AuthTheme.bodyText),
        ),
        const Expanded(
          child: Divider(color: AuthTheme.dividerColor, thickness: 1),
        ),
      ],
    );
  }
}

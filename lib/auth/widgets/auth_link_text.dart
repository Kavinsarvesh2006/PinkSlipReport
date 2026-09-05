import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../theme/auth_theme.dart';

/// Rich-text row: gray prefix + blue tappable suffix.
///
/// Example: "Haven't any account? **Sign up**"
class AuthLinkText extends StatelessWidget {
  const AuthLinkText({
    super.key,
    required this.prefix,
    required this.linkLabel,
    required this.onTap,
  });

  final String prefix;
  final String linkLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AuthTheme.bodyText,
        children: [
          TextSpan(text: prefix),
          TextSpan(
            text: linkLabel,
            style: AuthTheme.linkText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

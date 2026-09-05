import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:slipreport/core/theme/auth_theme.dart';

/// Rich-text row: gray prefix + blue tappable suffix.
///
/// Example: "Haven't any account? **Sign up**"
class AuthLinkText extends StatefulWidget {
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
  State<AuthLinkText> createState() => _AuthLinkTextState();
}

class _AuthLinkTextState extends State<AuthLinkText> {
  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void didUpdateWidget(AuthLinkText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onTap != oldWidget.onTap) {
      _recognizer.onTap = widget.onTap;
    }
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AuthTheme.bodyText,
        children: [
          TextSpan(text: widget.prefix),
          TextSpan(
            text: widget.linkLabel,
            style: AuthTheme.linkText,
            recognizer: _recognizer,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:slipreport/core/theme/auth_theme.dart';

/// Primary call-to-action button used across all auth screens.
///
/// Shows a [CircularProgressIndicator] when [isLoading] is true and
/// grays out when [isEnabled] is false.
class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final bool active = isEnabled && !isLoading;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: active ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              active ? AuthTheme.primaryBlue : AuthTheme.primaryBlue.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          disabledBackgroundColor: AuthTheme.primaryBlue.withValues(alpha: 0.5),
          disabledForegroundColor: Colors.white70,
          elevation: active ? 3 : 0,
          shadowColor: AuthTheme.primaryBlue.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AuthTheme.buttonRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(label, style: AuthTheme.buttonLabel),
      ),
    );
  }
}

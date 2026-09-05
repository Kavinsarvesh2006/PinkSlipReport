import 'package:flutter/material.dart';
import '../theme/auth_theme.dart';

/// Outlined social-login button (Google, Facebook, etc.).
///
/// Renders a pill-shaped button with the provider [icon] and [label].
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: iconColor),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AuthTheme.textPrimary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: AuthTheme.inputBorder, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AuthTheme.inputRadius),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

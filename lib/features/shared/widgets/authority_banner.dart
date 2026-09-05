import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AuthorityBanner extends StatelessWidget {
  final bool isHod;
  final String text;

  const AuthorityBanner({
    super.key,
    required this.isHod,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isHod ? AppTheme.green100 : AppTheme.amber100;
    final border = isHod ? const Color(0xFFA7F3D0) : const Color(0xFFFDE7B0);
    final iconColor = isHod ? const Color(0xFF047857) : const Color(0xFF92400E);
    final textColor = isHod ? const Color(0xFF047857) : const Color(0xFF92400E);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(isHod ? Icons.security_rounded : Icons.edit_note_rounded, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

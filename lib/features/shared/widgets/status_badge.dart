import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../pink_slips/domain/models/pink_slip.dart';

class StatusBadge extends StatelessWidget {
  final SlipStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label;

    switch (status) {
      case SlipStatus.pending:
        bg = AppTheme.violet100;
        fg = AppTheme.violet700;
        label = 'Pending';
        break;
      case SlipStatus.hodReview:
        bg = AppTheme.amber100;
        fg = AppTheme.amber500;
        label = 'HOD review';
        break;
      case SlipStatus.approved:
        bg = AppTheme.green100;
        fg = AppTheme.green600;
        label = 'Approved';
        break;
      case SlipStatus.rejected:
        bg = AppTheme.pink100;
        fg = AppTheme.pink500;
        label = 'Rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}

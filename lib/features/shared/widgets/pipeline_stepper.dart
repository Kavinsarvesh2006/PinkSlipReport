import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PipelineStepper extends StatelessWidget {
  final List<int> steps; // [submitted, advisor, hod] (0=todo, 1=current, 2=done)

  const PipelineStepper({
    super.key,
    required this.steps,
  });

  Widget _buildDot(int state) {
    Color color = AppTheme.line;
    if (state == 2) color = AppTheme.green600;
    if (state == 1) color = AppTheme.amber500;

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildLine(bool isDone) {
    return Expanded(
      child: Container(
        height: 2,
        color: isDone ? AppTheme.green600 : AppTheme.line,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Row(
        children: [
          _buildDot(steps.isNotEmpty ? steps[0] : 0),
          _buildLine(steps.length > 1 && steps[0] == 2 && steps[1] >= 1),
          _buildDot(steps.length > 1 ? steps[1] : 0),
          _buildLine(steps.length > 2 && steps[1] == 2 && steps[2] == 2),
          _buildDot(steps.length > 2 ? steps[2] : 0),
        ],
      ),
    );
  }
}

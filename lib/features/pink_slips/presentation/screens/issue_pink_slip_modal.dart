import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';

class IssuePinkSlipModal extends StatefulWidget {
  const IssuePinkSlipModal({super.key});

  @override
  State<IssuePinkSlipModal> createState() => _IssuePinkSlipModalState();
}

class _IssuePinkSlipModalState extends State<IssuePinkSlipModal> {
  String? _selectedStudent;
  String _selectedReason = 'Uninformed Absence';
  final TextEditingController _notesController = TextEditingController();

  final List<String> _reasons = [
    'Uninformed Absence',
    'Fees not paid',
    'Dress code violation',
    'Medical leave without letter',
    'Late coming repeatedly',
  ];

  @override
  Widget build(BuildContext context) {
    final state = AppStateManager.instance;
    final scopedRoster = state.scopedRoster;
    final studentList = scopedRoster.isNotEmpty
        ? scopedRoster.map((s) => '${s.name} (${s.rollNumber})').toList()
        : state.roster.map((s) => '${s.name} (${s.rollNumber})').toList();

    if (_selectedStudent == null || !studentList.contains(_selectedStudent)) {
      _selectedStudent = studentList.isNotEmpty ? studentList.first : 'No students found';
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.line,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Issue New Pink Slip',
            style: AppTheme.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.ink900),
          ),
          const SizedBox(height: 4),
          Text(
            'Issue an official notice or leave justification request (${state.currentProfile.year} · ${state.currentProfile.section})',
            style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600),
          ),
          const SizedBox(height: 20),

          Text('Select Student', style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppTheme.lavenderBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.line),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedStudent,
                isExpanded: true,
                items: studentList.map((s) => DropdownMenuItem(value: s, child: Text(s, style: AppTheme.inter(fontSize: 13, color: AppTheme.ink900)))).toList(),
                onChanged: (v) => setState(() => _selectedStudent = v),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text('Reason', style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppTheme.lavenderBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.line),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedReason,
                isExpanded: true,
                items: _reasons.map((r) => DropdownMenuItem(value: r, child: Text(r, style: AppTheme.inter(fontSize: 13, color: AppTheme.ink900)))).toList(),
                onChanged: (v) => setState(() => _selectedReason = v!),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text('Required Action / Notes', style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900)),
          const SizedBox(height: 6),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'e.g. Submit leave letter with parent signature by Friday',
              hintStyle: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink400),
              filled: true,
              fillColor: AppTheme.lavenderBg,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.line)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.line)),
            ),
          ),
          const SizedBox(height: 24),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pink slip issued and forwarded to HOD queue!')),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Send Pink Slip',
                  style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../domain/models/attendance.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  String _selectedSubject = 'AD8601 · Deep Learning & Neural Networks';
  String _selectedPeriod = 'Period 2 (09:45 AM - 10:45 AM)';

  final List<String> _subjects = [
    'AD8601 · Deep Learning & Neural Networks',
    'AD8602 · Big Data Analytics',
    'IT8076 · Natural Language Processing',
    'CS8791 · Cloud Computing & Security',
  ];

  final List<String> _periods = [
    'Period 1 (08:45 AM - 09:45 AM)',
    'Period 2 (09:45 AM - 10:45 AM)',
    'Period 3 (11:00 AM - 12:00 PM)',
    'Period 4 (12:00 PM - 01:00 PM)',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final roster = state.roster;

        return Scaffold(
          backgroundColor: AppTheme.lavenderBg,
          appBar: AppBar(
            backgroundColor: AppTheme.lavenderBg,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppTheme.ink900),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Mark Attendance',
              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () {
                  state.markAllPresent();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All marked as Present! ✓')),
                  );
                },
                child: Text(
                  'Mark All Present',
                  style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.violet600),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.line),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Subject', style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.ink400)),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSubject,
                        isExpanded: true,
                        items: _subjects.map((s) => DropdownMenuItem(value: s, child: Text(s, style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900)))).toList(),
                        onChanged: (v) => setState(() => _selectedSubject = v!),
                      ),
                    ),
                    const Divider(color: AppTheme.line, height: 12),
                    Text('Period', style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.ink400)),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPeriod,
                        isExpanded: true,
                        items: _periods.map((p) => DropdownMenuItem(value: p, child: Text(p, style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900)))).toList(),
                        onChanged: (v) => setState(() => _selectedPeriod = v!),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  itemCount: roster.length,
                  itemBuilder: (context, index) {
                    final student = roster[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.line),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppTheme.violet100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                student.initials,
                                style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.violet700),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                ),
                                Text(
                                  student.rollNumber,
                                  style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _buildToggleBtn(
                                'P',
                                isSelected: student.status == AttendanceStatus.present,
                                color: AppTheme.green600,
                                bgColor: AppTheme.green100,
                                onTap: () => state.toggleStudentAttendance(student.id, AttendanceStatus.present),
                              ),
                              const SizedBox(width: 6),
                              _buildToggleBtn(
                                'A',
                                isSelected: student.status == AttendanceStatus.absent,
                                color: AppTheme.pink500,
                                bgColor: AppTheme.pink100,
                                onTap: () => state.toggleStudentAttendance(student.id, AttendanceStatus.absent),
                              ),
                              const SizedBox(width: 6),
                              _buildToggleBtn(
                                'L',
                                isSelected: student.status == AttendanceStatus.late,
                                color: AppTheme.amber500,
                                bgColor: AppTheme.amber100,
                                onTap: () => state.toggleStudentAttendance(student.id, AttendanceStatus.late),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Attendance submitted and synced with department! ✓'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.violet600.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Save Attendance',
                        style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleBtn(String label, {required bool isSelected, required Color color, required Color bgColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? color : bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTheme.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}

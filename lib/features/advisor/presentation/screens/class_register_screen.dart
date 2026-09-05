import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../shared/widgets/authority_banner.dart';
import '../../../attendance/domain/models/attendance.dart';
import '../../../attendance/presentation/screens/od_document_viewer_screen.dart';
import '../../../attendance/presentation/screens/apply_od_modal.dart';

class ClassRegisterScreen extends StatefulWidget {
  final String initialFilter;

  const ClassRegisterScreen({super.key, this.initialFilter = 'All'});

  @override
  State<ClassRegisterScreen> createState() => _ClassRegisterScreenState();
}

class _ClassRegisterScreenState extends State<ClassRegisterScreen> {
  late String _selectedFilter;

  final List<String> _filters = [
    'All',
    'Present',
    'On Duty (OD)',
    'Absent today',
    'Uninformed',
    'Letter pending',
    'Overdue',
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  void _openApplyOdModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ApplyOdModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final profile = state.currentProfile;
        final scopedList = state.scopedRoster;
        final roster = scopedList.where((s) {
          if (_selectedFilter == 'Present') return s.status == AttendanceStatus.present;
          if (_selectedFilter == 'On Duty (OD)') return s.isOnDuty || s.status == AttendanceStatus.onDuty || s.leaveType == LeaveType.onDuty;
          if (_selectedFilter == 'Absent today') return s.status == AttendanceStatus.absent;
          if (_selectedFilter == 'Uninformed') return s.leaveType == LeaveType.uninformed;
          if (_selectedFilter == 'Letter pending') return s.letterSubmitted == false && s.status == AttendanceStatus.absent;
          if (_selectedFilter == 'Overdue') return s.dueDate != null && s.dueDate != 'Cleared';
          return true;
        }).toList();

        final sectionLabel = state.isHod
            ? '${state.currentHodYearName} · ${state.currentHodSectionName}'
            : '${profile.year} · ${profile.section}';

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
              'Register · $sectionLabel',
              style: AppTheme.poppins(fontSize: 14.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            centerTitle: true,
            actions: [
              if (state.canCurrentUserEdit || state.isHodAdmin)
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded, color: AppTheme.violet600),
                  tooltip: 'Apply On-Duty (OD)',
                  onPressed: _openApplyOdModal,
                ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthorityBanner(
                isHod: state.isHodAdmin,
                text: state.isHodAdmin
                    ? 'HOD Admin Access · Full authority to view, edit, and modify records'
                    : state.isHod
                        ? 'HOD Viewer Access · Read-only register inspection across all years'
                        : state.isClassRep
                            ? 'Class Rep Access · Confidential attendance view for ${profile.section}'
                            : 'Adviser Access · Confidential attendance editor for ${profile.section}',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatMiniCard(
                        label: 'Strength',
                        value: '${state.totalClassStrength}',
                        valueColor: AppTheme.ink900,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _StatMiniCard(
                        label: 'Present',
                        value: '${state.presentCount}',
                        valueColor: AppTheme.green600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _StatMiniCard(
                        label: 'On Duty',
                        value: '${state.onDutyCount}',
                        valueColor: const Color(0xFF2563EB),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _StatMiniCard(
                        label: 'Absent',
                        value: '${state.absentCount}',
                        valueColor: AppTheme.pink500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final f = _filters[index];
                    final isSel = _selectedFilter == f;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = f),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSel ? AppTheme.violet100 : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isSel ? AppTheme.violet100 : AppTheme.line),
                        ),
                        child: Center(
                          child: Text(
                            f,
                            style: AppTheme.inter(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isSel ? AppTheme.violet700 : AppTheme.ink600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemCount: roster.length,
                  itemBuilder: (context, index) {
                    final student = roster[index];
                    final isAbsent = student.status == AttendanceStatus.absent;
                    final isOd = student.isOnDuty || student.status == AttendanceStatus.onDuty || student.leaveType == LeaveType.onDuty;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isOd ? const Color(0xFF93C5FD) : AppTheme.line,
                          width: isOd ? 1.5 : 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isOd ? const Color(0xFF2563EB).withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: isOd
                                      ? const Color(0xFFEFF6FF)
                                      : isAbsent
                                          ? AppTheme.pink100
                                          : AppTheme.green100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    student.initials,
                                    style: AppTheme.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: isOd
                                          ? const Color(0xFF2563EB)
                                          : isAbsent
                                              ? AppTheme.pink500
                                              : AppTheme.green600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student.name,
                                      style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                    ),
                                    Text(
                                      '${student.rollNumber} · III AI&DS B',
                                      style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isOd
                                      ? const Color(0xFFEFF6FF)
                                      : isAbsent
                                          ? AppTheme.pink100
                                          : AppTheme.green100,
                                  borderRadius: BorderRadius.circular(20),
                                  border: isOd ? Border.all(color: const Color(0xFFBFDBFE)) : null,
                                ),
                                child: Text(
                                  isOd
                                      ? 'On Duty (OD)'
                                      : isAbsent
                                          ? 'Absent'
                                          : 'Present',
                                  style: AppTheme.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: isOd
                                        ? const Color(0xFF2563EB)
                                        : isAbsent
                                            ? AppTheme.pink500
                                            : AppTheme.green600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 2.6,
                            children: [
                              _buildRegGridItem(
                                'Leave type',
                                isOd
                                    ? 'On Duty (OD)'
                                    : student.leaveType == LeaveType.uninformed
                                        ? 'Uninformed'
                                        : student.leaveType == LeaveType.informed
                                            ? 'Informed'
                                            : '-',
                                isWarn: student.leaveType == LeaveType.uninformed,
                                isOk: student.leaveType == LeaveType.informed,
                                isOd: isOd,
                              ),
                              _buildRegGridItem(
                                isOd ? 'Proof of Letter' : 'Letter submitted',
                                isOd
                                    ? (student.proofDocumentName != null ? 'Attached (PDF) ✓' : 'Pending')
                                    : student.letterSubmitted
                                        ? (student.letterApproved ? 'Yes · approved' : 'Yes · pending')
                                        : (isAbsent ? 'No' : '-'),
                                isWarn: !student.letterSubmitted && isAbsent,
                                isOk: student.letterSubmitted || isOd,
                                isOd: isOd,
                              ),
                              _buildRegGridItem(
                                isOd ? 'HOD Permission' : (isAbsent ? 'Submitted to adviser' : 'Biometric'),
                                isOd
                                    ? (student.isHodSigned ? 'Signed & Granted ✓' : 'Pending HOD Sign ⏳')
                                    : isAbsent
                                        ? (student.submittedToAdvisorDate ?? '-')
                                        : (student.biometricTime ?? '-'),
                                isOk: !isAbsent && !isOd || (isOd && student.isHodSigned),
                                isWarn: isOd && !student.isHodSigned,
                              ),
                              _buildRegGridItem(
                                isOd ? 'OD Event' : (isAbsent ? 'Forwarded to HOD' : 'Source'),
                                isOd
                                    ? (student.odReason ?? 'Hackathon 2026')
                                    : isAbsent
                                        ? (student.forwardedToHodDate ?? '-')
                                        : 'Biometric Gate',
                              ),
                              _buildRegGridItem(
                                'Due date',
                                student.dueDate ?? (isOd ? 'OD Sanctioned' : '-'),
                                isWarn: student.dueDate != null && student.dueDate != 'Cleared',
                                isOk: student.dueDate == 'Cleared' || isOd,
                              ),
                              _buildRegGridItem(
                                'Leaves taken (YTD)',
                                '${student.leavesTakenYtd}',
                              ),
                            ],
                          ),

                          // If student is on duty or has letter attached: Show prominent View Proof & Permission Button
                          if (isOd) ...[
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OdDocumentViewerScreen(student: student),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFBFDBFE)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFF2563EB), size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      'View Proof Letter & HOD Signed Document',
                                      style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF1D4ED8)),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF1D4ED8), size: 12),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _openApplyOdModal,
            backgroundColor: AppTheme.violet600,
            icon: const Icon(Icons.note_add_rounded, color: Colors.white),
            label: const Text('Apply OD Request', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }

  Widget _buildRegGridItem(String label, String value, {bool isWarn = false, bool isOk = false, bool isOd = false}) {
    Color valColor = AppTheme.ink900;
    if (isOd) valColor = const Color(0xFF1D4ED8);
    if (isWarn) valColor = AppTheme.pink500;
    if (isOk) valColor = AppTheme.green600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isOd ? const Color(0xFFEFF6FF) : AppTheme.lavenderBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTheme.inter(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: isOd ? const Color(0xFF60A5FA) : AppTheme.ink400,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w700, color: valColor),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StatMiniCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _StatMiniCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTheme.inter(fontSize: 10.5, color: AppTheme.ink600)),
          const SizedBox(height: 4),
          Text(value, style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: valueColor)),
        ],
      ),
    );
  }
}

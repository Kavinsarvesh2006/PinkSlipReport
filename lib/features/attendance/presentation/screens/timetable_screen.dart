import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/timetable.dart';
import 'raptor_camera_scanner_screen.dart';

class TimetableScreen extends StatefulWidget {
  final String year;
  final String section;

  const TimetableScreen({
    super.key,
    this.year = '3rd Year',
    this.section = 'B',
  });

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  late String _selectedDay;
  final int _activePeriodNumber = 2; // Simulated currently active period

  @override
  void initState() {
    super.initState();
    // Default to today's weekday name
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday:
        _selectedDay = 'Monday';
        break;
      case DateTime.tuesday:
        _selectedDay = 'Tuesday';
        break;
      case DateTime.wednesday:
        _selectedDay = 'Wednesday';
        break;
      case DateTime.thursday:
        _selectedDay = 'Thursday';
        break;
      case DateTime.friday:
        _selectedDay = 'Friday';
        break;
      case DateTime.saturday:
        _selectedDay = 'Saturday';
        break;
      default:
        _selectedDay = 'Monday';
    }
  }

  @override
  Widget build(BuildContext context) {
    final daySlots = CollegeTimetableData.scheduleIII_B
        .where((s) => s.day.toLowerCase() == _selectedDay.toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.ink900, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Timetable · III Year - B',
              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            Text(
              'Room: MB III A-202 · ODD Sem 2026-2027',
              style: AppTheme.inter(fontSize: 11, color: AppTheme.ink400),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF10B981)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Period $_activePeriodNumber Live',
                  style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // College & Department Header Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E1065), Color(0xFF4C1D95)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.school_rounded, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'V.S.B. ENGINEERING COLLEGE, KARUR',
                        style: AppTheme.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF67E8F9), letterSpacing: 0.4),
                      ),
                      Text(
                        'Dept. of Artificial Intelligence and Data Science',
                        style: AppTheme.inter(fontSize: 11, color: Colors.white70),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Class Adviser: Dr. R. Murugesan [RM]',
                        style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w600, color: const Color(0xFFA5B4FC)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Day Selection Tabs (Mon - Sat)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _days.map((d) {
                  final isSelected = d.toLowerCase() == _selectedDay.toLowerCase();
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        d.substring(0, 3),
                        style: AppTheme.inter(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.ink600,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFF7C3AED),
                      backgroundColor: const Color(0xFFF3F4F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onSelected: (val) {
                        if (val) {
                          setState(() => _selectedDay = d);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Periods List for Selected Day
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
              itemCount: daySlots.length,
              itemBuilder: (context, idx) {
                final slot = daySlots[idx];
                final isCurrentPeriod = slot.periodNumber == _activePeriodNumber;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isCurrentPeriod ? const Color(0xFF7C3AED) : const Color(0xFFE5E7EB),
                      width: isCurrentPeriod ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isCurrentPeriod
                            ? const Color(0xFF7C3AED).withValues(alpha: 0.15)
                            : Colors.black.withValues(alpha: 0.03),
                        blurRadius: isCurrentPeriod ? 10 : 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Period Number Badge
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: isCurrentPeriod
                                ? AppTheme.primaryGradient
                                : (slot.isLab
                                    ? const LinearGradient(colors: [Color(0xFF0D9488), Color(0xFF14B8A6)])
                                    : const LinearGradient(colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)])),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'P${slot.periodNumber}',
                              style: AppTheme.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: (isCurrentPeriod || slot.isLab) ? Colors.white : AppTheme.ink900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Subject Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    slot.shortCode,
                                    style: AppTheme.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.ink900,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (slot.isLab)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF14B8A6).withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'LAB SESSION',
                                        style: AppTheme.inter(fontSize: 9.5, fontWeight: FontWeight.w700, color: const Color(0xFF0D9488)),
                                      ),
                                    ),
                                  const Spacer(),
                                  Text(
                                    slot.timeRange,
                                    style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.ink400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                slot.subjectName,
                                style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w500, color: AppTheme.ink900),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.person_outline_rounded, size: 14, color: AppTheme.ink400),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${slot.facultyName} ${slot.facultyInitials}',
                                    style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.meeting_room_outlined, size: 14, color: AppTheme.ink400),
                                  const SizedBox(width: 4),
                                  Text(
                                    slot.roomName,
                                    style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF7C3AED)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RaptorCameraScannerScreen(
                    initialYear: '3rd Year',
                    initialSection: 'B',
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Scan Raptor Attendance for P$_activePeriodNumber Live',
                    style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

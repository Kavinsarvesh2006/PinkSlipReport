import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import 'photo_attendance_review_screen.dart';

class AttendanceHistoryGalleryScreen extends StatefulWidget {
  const AttendanceHistoryGalleryScreen({super.key});

  @override
  State<AttendanceHistoryGalleryScreen> createState() => _AttendanceHistoryGalleryScreenState();
}

class _AttendanceHistoryGalleryScreenState extends State<AttendanceHistoryGalleryScreen> {
  String _selectedYear = 'All Years';
  String _selectedSection = 'All Sections';

  final List<String> _years = ['All Years', '1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> _sections = ['All Sections', 'Sec A', 'Sec B', 'Sec C', 'Sec D'];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final sessions = state.classSessionPhotos.where((s) {
          if (_selectedYear != 'All Years' && s.year != _selectedYear) return false;
          if (_selectedSection != 'All Sections' && 'Sec ${s.section}' != _selectedSection) return false;
          return true;
        }).toList();

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
              'Class Photo Attendance Gallery',
              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Filter Chips
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.lavenderBg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.line),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedYear,
                            isExpanded: true,
                            items: _years.map((y) => DropdownMenuItem(value: y, child: Text(y, style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.ink900)))).toList(),
                            onChanged: (v) => setState(() => _selectedYear = v!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.lavenderBg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.line),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSection,
                            isExpanded: true,
                            items: _sections.map((s) => DropdownMenuItem(value: s, child: Text(s, style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.ink900)))).toList(),
                            onChanged: (v) => setState(() => _selectedSection = v!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Sessions List
              Expanded(
                child: sessions.isEmpty
                    ? Center(
                        child: Text(
                          'No session photos for this filter',
                          style: AppTheme.inter(fontSize: 13, color: AppTheme.ink600),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                          final session = sessions[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhotoAttendanceReviewScreen(session: session),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: AppTheme.line),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Photo Thumbnail with Overlay
                                  Container(
                                    height: 140,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=800&q=80',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(alpha: 0.7),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              '${session.year} · Sec ${session.section}',
                                              style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF10B981),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              '${session.presentCount} Faces Detected',
                                              style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Details Section
                                  Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          session.subject,
                                          style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${session.roomName} · ${session.capturedAt}',
                                          style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Adviser: ${session.advisorName}',
                                              style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                            ),
                                            Text(
                                              'View Details →',
                                              style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.violet600),
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
        );
      },
    );
  }
}

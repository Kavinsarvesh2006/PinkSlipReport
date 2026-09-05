import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../domain/models/class_session_photo.dart';
import 'attendance_history_gallery_screen.dart';

class PhotoAttendanceReviewScreen extends StatefulWidget {
  final ClassSessionPhoto session;

  const PhotoAttendanceReviewScreen({super.key, required this.session});

  @override
  State<PhotoAttendanceReviewScreen> createState() => _PhotoAttendanceReviewScreenState();
}

class _PhotoAttendanceReviewScreenState extends State<PhotoAttendanceReviewScreen> {
  bool _showBoundingBoxes = true;
  late ClassSessionPhoto _currentSession;

  @override
  void initState() {
    super.initState();
    _currentSession = widget.session;
  }

  void _sendReportToHod() {
    final updated = _currentSession.copyWith(sentToHod: true);
    setState(() => _currentSession = updated);
    AppStateManager.instance.updateClassSessionPhoto(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.green600,
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Class photo & attendance report forwarded to HOD (Dr. S. Manivannan)!',
                style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detectedCount = _currentSession.presentCount;
    final absentCount = _currentSession.absentCount;

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
          'Photo Attendance Review',
          style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: AppTheme.violet600),
            tooltip: 'View Photo History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AttendanceHistoryGalleryScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Session Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.violet100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_currentSession.year} · Sec ${_currentSession.section}',
                          style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.violet700),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _currentSession.sentToHod ? AppTheme.green100 : AppTheme.amber100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _currentSession.sentToHod ? 'Sent to HOD ✓' : 'Draft Report',
                          style: AppTheme.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _currentSession.sentToHod ? AppTheme.green600 : AppTheme.amber500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _currentSession.subject,
                    style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_currentSession.roomName} · ${_currentSession.capturedAt}',
                    style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                  ),
                  Text(
                    'Adviser: ${_currentSession.advisorName}',
                    style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Photo Evidence with AI Overlay
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Classroom Photo Evidence',
                  style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                ),
                GestureDetector(
                  onTap: () => setState(() => _showBoundingBoxes = !_showBoundingBoxes),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _showBoundingBoxes ? AppTheme.violet100 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.violet100),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _showBoundingBoxes ? Icons.visibility : Icons.visibility_off,
                          size: 14,
                          color: AppTheme.violet700,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Face Tags',
                          style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.violet700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Photo Viewer Container
            Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.line),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=1200&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (_showBoundingBoxes)
                    ..._currentSession.detectedFaces.map((face) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final top = constraints.maxHeight * face.topPercent;
                          final left = constraints.maxWidth * face.leftPercent;
                          final width = constraints.maxWidth * face.widthPercent;
                          final height = constraints.maxHeight * face.heightPercent;

                          return Positioned(
                            top: top,
                            left: left,
                            width: width,
                            height: height,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF10B981), width: 1.8),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0xFF10B981).withValues(alpha: 0.18),
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                  color: const Color(0xFF10B981),
                                  child: Text(
                                    '${face.studentName.split(" ").first} ${face.confidenceDisplay}',
                                    style: AppTheme.inter(fontSize: 8.5, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Metrics Row (Recognized vs Absent)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.line),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI Detected Present', style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600)),
                        const SizedBox(height: 4),
                        Text('$detectedCount Students', style: AppTheme.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.green600)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.line),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Absentees / Missing', style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600)),
                        const SizedBox(height: 4),
                        Text('$absentCount Students', style: AppTheme.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.pink500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recognized Faces List
            Text(
              'Recognized Students (${_currentSession.detectedFaces.length})',
              style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _currentSession.detectedFaces.length,
              itemBuilder: (context, index) {
                final face = _currentSession.detectedFaces[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.line),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppTheme.green100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.face_retouching_natural_rounded, size: 16, color: AppTheme.green600),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(face.studentName, style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
                            Text(face.rollNumber, style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.green100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${face.confidenceDisplay} Match',
                          style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppTheme.green600),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Absentees List
            if (_currentSession.absentStudentNames.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Missing / Absent Students (${_currentSession.absentStudentNames.length})',
                style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _currentSession.absentStudentNames.length,
                itemBuilder: (context, index) {
                  final name = _currentSession.absentStudentNames[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.line),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppTheme.pink100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.person_off_rounded, size: 16, color: AppTheme.pink500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(name, style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.pink100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Marked Absent',
                            style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppTheme.pink500),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 24),

            // Send Report to HOD Button
            GestureDetector(
              onTap: _sendReportToHod,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Forward Report & Photo to HOD',
                      style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../domain/models/class_session_photo.dart';
import 'photo_attendance_review_screen.dart';

class RaptorCameraScannerScreen extends StatefulWidget {
  final String initialYear;
  final String initialSection;

  const RaptorCameraScannerScreen({
    super.key,
    this.initialYear = '2nd Year',
    this.initialSection = 'B',
  });

  @override
  State<RaptorCameraScannerScreen> createState() => _RaptorCameraScannerScreenState();
}

class _RaptorCameraScannerScreenState extends State<RaptorCameraScannerScreen>
    with SingleTickerProviderStateMixin {
  late String _selectedYear;
  late String _selectedSection;
  String _selectedSubject = 'AD8601 · Deep Learning & Neural Networks';
  String _selectedRoom = 'Hall 302 · Raptor Smart Board #4';
  bool _isSmartBoardFeed = true; // Smart board camera vs mobile camera

  bool _isScanning = false;
  double _scanProgress = 0.0;
  Timer? _scanTimer;
  late AnimationController _laserController;

  final List<String> _years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> _sections = ['A', 'B', 'C', 'D'];
  final List<String> _rooms = [
    'Hall 302 · Raptor Smart Board #4',
    'Hall 305 · Raptor Smart Board #7',
    'AI Lab 1 · Raptor Board AI-01',
    'Seminar Hall B · Raptor Board #12',
  ];

  final List<String> _subjects = [
    'AD8601 · Deep Learning & Neural Networks',
    'AD8602 · Big Data Analytics',
    'IT8076 · Natural Language Processing',
    'CS8791 · Cloud Computing & Security',
    'GE8077 · Total Quality Management',
  ];

  // Sample detected faces simulation on the captured classroom frame
  final List<DetectedFace> _simulatedFaces = const [
    DetectedFace(
      id: 'F1',
      studentName: 'Lithesh Hari R',
      rollNumber: '25243100',
      confidence: 0.986,
      topPercent: 0.28,
      leftPercent: 0.18,
      widthPercent: 0.22,
      heightPercent: 0.15,
    ),
    DetectedFace(
      id: 'F2',
      studentName: 'Manikandan M',
      rollNumber: '25243113',
      confidence: 0.974,
      topPercent: 0.26,
      leftPercent: 0.58,
      widthPercent: 0.20,
      heightPercent: 0.14,
    ),
    DetectedFace(
      id: 'F3',
      studentName: 'Janani Y',
      rollNumber: '25243068',
      confidence: 0.991,
      topPercent: 0.48,
      leftPercent: 0.12,
      widthPercent: 0.22,
      heightPercent: 0.15,
    ),
    DetectedFace(
      id: 'F4',
      studentName: 'Deepika S',
      rollNumber: '25243044',
      confidence: 0.965,
      topPercent: 0.46,
      leftPercent: 0.44,
      widthPercent: 0.21,
      heightPercent: 0.15,
    ),
    DetectedFace(
      id: 'F5',
      studentName: 'Karthik Raja S',
      rollNumber: '25243085',
      confidence: 0.982,
      topPercent: 0.49,
      leftPercent: 0.72,
      widthPercent: 0.20,
      heightPercent: 0.14,
    ),
    DetectedFace(
      id: 'F6',
      studentName: 'Praveen Kumar V',
      rollNumber: '25243128',
      confidence: 0.958,
      topPercent: 0.68,
      leftPercent: 0.24,
      widthPercent: 0.21,
      heightPercent: 0.15,
    ),
    DetectedFace(
      id: 'F7',
      studentName: 'Sneha R',
      rollNumber: '25243152',
      confidence: 0.979,
      topPercent: 0.69,
      leftPercent: 0.62,
      widthPercent: 0.20,
      heightPercent: 0.14,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialYear;
    _selectedSection = widget.initialSection;
    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    _laserController.dispose();
    super.dispose();
  }

  void _triggerCaptureAndScan() {
    setState(() {
      _isScanning = true;
      _scanProgress = 0.0;
    });

    _scanTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      setState(() {
        _scanProgress += 0.025;
        if (_scanProgress >= 1.0) {
          _scanProgress = 1.0;
          timer.cancel();
          _onScanComplete();
        }
      });
    });
  }

  void _onScanComplete() {
    final state = AppStateManager.instance;
    final now = DateTime.now();
    final dateStr =
        '${now.day} Aug ${now.year}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final session = ClassSessionPhoto(
      id: 'RAPTOR-SES-${DateTime.now().millisecondsSinceEpoch % 100000}',
      year: _selectedYear,
      section: _selectedSection,
      department: 'AI & DS',
      subject: _selectedSubject,
      period: 'Period 2 (09:45 AM)',
      roomName: _selectedRoom,
      advisorName: state.currentProfile.name,
      capturedAt: dateStr,
      imageType: _isSmartBoardFeed ? 'smart_board' : 'mobile_camera',
      detectedFaces: _simulatedFaces,
      absentStudentNames: const ['Dinesh Kumar P (25243050)', 'Kavitha M (25243091)'],
      totalStrength: 63,
      sentToHod: true,
      hodApproved: false,
    );

    state.addClassSessionPhoto(session);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PhotoAttendanceReviewScreen(session: session),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0E17),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              'Raptor Smart Board AI Camera',
              style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            Text(
              '$_selectedYear · Sec $_selectedSection',
              style: AppTheme.inter(fontSize: 11, color: const Color(0xFF67E8F9)),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isSmartBoardFeed ? Icons.tv_rounded : Icons.phone_android_rounded,
              color: const Color(0xFF67E8F9),
            ),
            tooltip: 'Toggle Smart Board / Mobile Camera',
            onPressed: () {
              setState(() => _isSmartBoardFeed = !_isSmartBoardFeed);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isSmartBoardFeed
                      ? 'Connected to In-Class Raptor Smart Board Camera'
                      : 'Switched to Mobile Camera Capture'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Class & Year Selector Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: const Color(0xFF1E1B2E),
            child: Column(
              children: [
                Row(
                  children: [
                    // Year Selector
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2844),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedYear,
                            dropdownColor: const Color(0xFF2B2844),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70, size: 18),
                            items: _years.map((y) => DropdownMenuItem(value: y, child: Text(y, style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)))).toList(),
                            onChanged: (v) => setState(() => _selectedYear = v!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Section Selector
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2844),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSection,
                            dropdownColor: const Color(0xFF2B2844),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70, size: 18),
                            items: _sections.map((s) => DropdownMenuItem(value: s, child: Text('Sec $s', style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)))).toList(),
                            onChanged: (v) => setState(() => _selectedSection = v!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Room badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF10B981)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _isSmartBoardFeed ? 'Raptor Live' : 'Camera',
                            style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Live Viewfinder / Classroom Canvas
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Simulated Classroom Background with students
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1829),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF67E8F9).withValues(alpha: 0.4), width: 1.5),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=1200&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Dark Scrim Overlay
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                // Viewfinder HUD Corner Brackets
                Positioned(
                  top: 30,
                  left: 30,
                  child: _buildHudCorner(isTop: true, isLeft: true),
                ),
                Positioned(
                  top: 30,
                  right: 30,
                  child: _buildHudCorner(isTop: true, isLeft: false),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: _buildHudCorner(isTop: false, isLeft: true),
                ),
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: _buildHudCorner(isTop: false, isLeft: false),
                ),

                // Live Face Bounding Boxes
                ..._simulatedFaces.map((face) {
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
                            border: Border.all(
                              color: const Color(0xFF10B981),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -20,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${face.studentName.split(" ").first} · ${face.confidenceDisplay}',
                                    style: AppTheme.inter(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),

                // Animated Laser Scanning Line
                if (_isScanning)
                  AnimatedBuilder(
                    animation: _laserController,
                    builder: (context, child) {
                      return Positioned(
                        top: 20 + (MediaQuery.of(context).size.height * 0.45 * _laserController.value),
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.transparent, Color(0xFF67E8F9), Color(0xFF7C3AED), Colors.transparent],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF67E8F9).withValues(alpha: 0.8),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                // Top HUD Stats Pill
                Positioned(
                  top: 28,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF67E8F9).withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.face_retouching_natural_rounded, size: 15, color: Color(0xFF67E8F9)),
                          const SizedBox(width: 6),
                          Text(
                            'AI Face Detection Engine: 7 Faces Locked',
                            style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Scanning Progress Overlay
                if (_isScanning)
                  Positioned(
                    bottom: 30,
                    left: 40,
                    right: 40,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1B2E).withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF7C3AED)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Scanning Classroom & Matching Roster...',
                                style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                              Text(
                                '${(_scanProgress * 100).toInt()}%',
                                style: AppTheme.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF67E8F9)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: _scanProgress,
                              minHeight: 8,
                              backgroundColor: const Color(0xFF2B2844),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF67E8F9)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Bottom Control Panel
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1B2E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: const Color(0xFF1E1B2E),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (ctx) => Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Subject & Room',
                                    style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                  const SizedBox(height: 12),
                                  Text('SUBJECTS', style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF67E8F9))),
                                  ..._subjects.map((sub) => ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(sub, style: AppTheme.inter(fontSize: 12.5, color: Colors.white)),
                                    trailing: _selectedSubject == sub ? const Icon(Icons.check, color: Color(0xFF67E8F9), size: 18) : null,
                                    onTap: () {
                                      setState(() => _selectedSubject = sub);
                                      Navigator.pop(ctx);
                                    },
                                  )),
                                  const SizedBox(height: 8),
                                  Text('SMART BOARD ROOMS', style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF67E8F9))),
                                  ..._rooms.map((rm) => ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(rm, style: AppTheme.inter(fontSize: 12.5, color: Colors.white)),
                                    trailing: _selectedRoom == rm ? const Icon(Icons.check, color: Color(0xFF67E8F9), size: 18) : null,
                                    onTap: () {
                                      setState(() => _selectedRoom = rm);
                                      Navigator.pop(ctx);
                                    },
                                  )),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedSubject.split('·').first.trim(),
                              style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                            Text(
                              _selectedRoom,
                              style: AppTheme.inter(fontSize: 11, color: const Color(0xFFA5B4FC)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF7C3AED)),
                      ),
                      child: Text(
                        'Roster: 63 Students',
                        style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Capture Button
                GestureDetector(
                  onTap: _isScanning ? null : _triggerCaptureAndScan,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          _isScanning ? 'Processing AI Faces...' : 'Capture Class & Scan Faces',
                          style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHudCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: Color(0xFF67E8F9), width: 3) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: Color(0xFF67E8F9), width: 3) : BorderSide.none,
          left: isLeft ? const BorderSide(color: Color(0xFF67E8F9), width: 3) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: Color(0xFF67E8F9), width: 3) : BorderSide.none,
        ),
      ),
    );
  }
}

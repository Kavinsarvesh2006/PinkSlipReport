import 'package:flutter/material.dart';
import '../../authentication/domain/models/user_role.dart';
import '../../pink_slips/domain/models/pink_slip.dart';
import '../../attendance/domain/models/attendance.dart';
import '../../attendance/domain/models/class_session_photo.dart';
import '../../attendance/domain/models/timetable.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;
  final String? miniCardText;
  final List<String>? actionChips;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
    this.miniCardText,
    this.actionChips,
  });
}

class DepartmentSectionStat {
  final String year;
  final String section;
  final String advisorName;
  final double attendanceRate;
  final int totalStudents;
  final int pendingSlips;
  final String roomName;

  const DepartmentSectionStat({
    required this.year,
    required this.section,
    required this.advisorName,
    required this.attendanceRate,
    required this.totalStudents,
    required this.pendingSlips,
    required this.roomName,
  });

  String get sectionName => section;
  double get attendancePct => attendanceRate;
  int get pendingHodCount => pendingSlips;
}

class AppStateManager extends ChangeNotifier {
  static final AppStateManager instance = AppStateManager._internal();

  AppStateManager._internal() {
    _initData();
  }

  // Active User Profile & Authentication State
  bool _isAuthenticated = true;
  bool get isAuthenticated => _isAuthenticated;

  UserProfile _currentUserProfile = UserProfile.hodManivannanProfile;
  UserProfile get currentProfile => _currentUserProfile;
  UserProfile get currentUserProfile => _currentUserProfile;
  UserRole get currentRole => _currentUserProfile.role;

  // Permissions & Authority
  bool get canCurrentUserEdit => _currentUserProfile.canEdit;
  bool get canCurrentUserDelete => _currentUserProfile.canDelete;
  bool get isHodAdmin => _currentUserProfile.isHodAdmin;
  bool get isHod => _currentUserProfile.role == UserRole.hod;
  bool get isClassAdvisor => _currentUserProfile.role == UserRole.advisor;
  bool get isClassRep => _currentUserProfile.role == UserRole.classRep;

  // Single Login authentication methods (No in-dashboard role switching allowed)
  void loginWithProfile(UserProfile profile) {
    _currentUserProfile = profile;
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _currentUserProfile = UserProfile.advisorProfile;
    notifyListeners();
  }

  // HOD Browse Selection (for browsing all 4 years and sections)
  int _selectedHodYearIndex = 2; // Default to 3rd year
  int _selectedHodSectionIndex = 1; // Default to Section B
  int get selectedHodYearIndex => _selectedHodYearIndex;
  int get selectedHodSectionIndex => _selectedHodSectionIndex;

  final List<String> hodYears = const ['1st year', '2nd year', '3rd year', '4th year'];
  final List<String> hodSections = const ['Section A', 'Section B', 'Section C', 'Section D'];

  String get currentHodYearName => _selectedHodYearIndex < hodYears.length ? hodYears[_selectedHodYearIndex] : '3rd year';
  String get currentHodSectionName => _selectedHodSectionIndex < hodSections.length ? hodSections[_selectedHodSectionIndex] : 'Section B';

  void selectHodYear(int index) {
    _selectedHodYearIndex = index;
    notifyListeners();
  }

  void selectHodSection(int index) {
    _selectedHodSectionIndex = index;
    notifyListeners();
  }

  // Active Class Roster (Multi-Section)
  List<StudentRecord> _roster = [];
  List<StudentRecord> get roster => _roster;

  // Pink Slips Collection
  List<PinkSlip> _pinkSlips = [
      PinkSlip(
        id: 'OD-2026-081',
        studentName: 'KANIGA A',
        rollNumber: '922524243068',
        section: 'III AI&DS - Section B',
        reason: 'On-Duty: National Level Hackathon 2026 (Anna University)',
        raisedBy: 'Dr. R. Murugesan [RM]',
        raisedOn: DateTime.now().subtract(const Duration(days: 1)),
        daysPending: 0,
        status: SlipStatus.approved,
        isOd: true,
        attachedProofName: 'Anna_University_Hackathon_Invite_2026.pdf',
        attachedProofSize: '1.8 MB',
        hodSignedDocName: 'HOD_Signed_OD_Permission_922524243068.pdf',
        hodRemarks: 'Granted OD permission with academic attendance credit.',
        hodSigner: 'Dr. S. Karthikeyan, M.E., Ph.D. (HOD / AI&DS)',
        timeline: [
          TimelineStage(
            title: 'OD Request & Proof Uploaded',
            when: '22 Aug, 04:30 PM',
            note: 'Attached Anna_University_Hackathon_Invite_2026.pdf (1.8 MB)',
            isDone: true,
          ),
          TimelineStage(
            title: 'Adviser Verification & Recommendation',
            when: '23 Aug, 05:15 PM',
            note: 'Recommended by Dr. R. Murugesan [RM] (Class Adviser)',
            isDone: true,
          ),
          TimelineStage(
            title: 'HOD Digital Permission & Signed Document',
            when: '24 Aug, 09:15 AM',
            note: 'Digitally signed by Dr. S. Karthikeyan (HOD). Attached HOD_Signed_OD_Permission_922524243068.pdf (2.4 MB)',
            isDone: true,
          ),
        ],
      ),
      PinkSlip(
        id: 'OD-2026-082',
        studentName: 'KARTHICK S',
        rollNumber: '922524243073',
        section: 'III AI&DS - Section B',
        reason: 'On-Duty: State Level Technical Symposium (PSG Tech)',
        raisedBy: 'Dr. R. Murugesan [RM]',
        raisedOn: DateTime.now(),
        daysPending: 1,
        status: SlipStatus.hodReview,
        isOd: true,
        attachedProofName: 'State_Symposium_Paper_Acceptance.pdf',
        attachedProofSize: '1.5 MB',
        timeline: [
          TimelineStage(
            title: 'OD Request & Proof Attached',
            when: 'Today, 08:30 AM',
            note: 'Attached State_Symposium_Paper_Acceptance.pdf (1.5 MB)',
            isDone: true,
          ),
          TimelineStage(
            title: 'Adviser Verification & Recommendation',
            when: 'Today, 09:15 AM',
            note: 'Recommended by Dr. R. Murugesan [RM]',
            isDone: true,
          ),
          TimelineStage(
            title: 'HOD Digital Permission & Signed Document',
            when: 'Awaiting HOD Signature',
            isCurrent: true,
          ),
        ],
      ),];
  List<PinkSlip> get pinkSlips => _pinkSlips;
  List<PinkSlip> get hodApprovalQueue => _pinkSlips.where((s) => s.status == SlipStatus.hodReview).toList();

  // Department Sections
  List<DepartmentSectionStat> _sections = [];
  List<DepartmentSectionStat> get sections => _sections;

  // Biometric Logs
  List<BiometricPunch> _biometricPunches = [];
  List<BiometricPunch> get biometricPunches => _biometricPunches;

  // Student Subject Attendance
  List<SubjectAttendance> _studentSubjects = [];
  List<SubjectAttendance> get studentSubjects => _studentSubjects;

  // Class Session Photos (Raptor Smart Board / In-Class Camera)
  List<ClassSessionPhoto> _classSessionPhotos = [];
  List<ClassSessionPhoto> get classSessionPhotos => _classSessionPhotos;

  // Jarvis Chat State
  List<ChatMessage> _chatMessages = [];
  List<ChatMessage> get chatMessages => _chatMessages;

  // --- STRICT ROLE-BASED SCOPED DATA GETTERS FOR PRIVACY & CONFIDENTIALITY ---

  /// Roster scoped strictly by user role and assigned section
  List<StudentRecord> get scopedRoster {
    if (isHod) {
      final targetYear = currentHodYearName.toLowerCase().replaceAll(' ', '');
      final targetSec = currentHodSectionName.toLowerCase().replaceAll(' ', '');
      final filtered = _roster.where((s) {
        final sy = s.year.toLowerCase().replaceAll(' ', '');
        final ss = s.section.toLowerCase().replaceAll(' ', '');
        return (sy.contains('3') && targetYear.contains('3') || sy.contains('2') && targetYear.contains('2') || sy.contains('1') && targetYear.contains('1') || sy.contains('4') && targetYear.contains('4')) &&
               (ss.contains(targetSec.substring(targetSec.length - 1)));
      }).toList();
      return filtered.isNotEmpty ? filtered : _roster.where((s) => s.section.contains('Section B')).toList();
    } else if (isClassAdvisor || isClassRep) {
      // Strictly confidential to advisor/class rep's assigned section
      final assignedYear = _currentUserProfile.year.toLowerCase().replaceAll(' ', '');
      final assignedSec = _currentUserProfile.section.toLowerCase().replaceAll(' ', '');
      return _roster.where((s) {
        final sy = s.year.toLowerCase().replaceAll(' ', '');
        final ss = s.section.toLowerCase().replaceAll(' ', '');
        return (sy.contains('3') && assignedYear.contains('3') || sy.contains('2') && assignedYear.contains('2') || sy.contains('1') && assignedYear.contains('1') || sy.contains('4') && assignedYear.contains('4')) &&
               (ss.contains(assignedSec.substring(assignedSec.length - 1)));
      }).toList();
    } else {
      return _roster.where((s) => s.rollNumber == _currentUserProfile.id || s.name.toLowerCase().contains(_currentUserProfile.name.toLowerCase())).toList();
    }
  }

  /// Pink slips scoped strictly for the logged-in user
  List<PinkSlip> get scopedPinkSlips {
    if (isHod) {
      return _pinkSlips;
    } else if (isClassAdvisor || isClassRep) {
      final assignedSec = _currentUserProfile.section.toLowerCase().replaceAll(' ', '');
      final secLetter = assignedSec.substring(assignedSec.length - 1);
      return _pinkSlips.where((s) => s.section.toLowerCase().contains(secLetter)).toList();
    } else {
      return _pinkSlips.where((s) => s.rollNumber == _currentUserProfile.id || s.studentName.toLowerCase().contains(_currentUserProfile.name.toLowerCase())).toList();
    }
  }

  /// Class session photos scoped for the logged-in user
  List<ClassSessionPhoto> get scopedClassSessionPhotos {
    if (isHod) {
      return _classSessionPhotos;
    } else if (isClassAdvisor || isClassRep) {
      final assignedSec = _currentUserProfile.section.toLowerCase().replaceAll(' ', '');
      final secLetter = assignedSec.substring(assignedSec.length - 1);
      return _classSessionPhotos.where((p) => p.section.toLowerCase().contains(secLetter)).toList();
    } else {
      return _classSessionPhotos.where((p) => p.section.contains('B')).toList();
    }
  }

  // Scoped Computed Overview Stats
  int get scopedTotalStrength => scopedRoster.isNotEmpty ? scopedRoster.length : 60;
  int get scopedPresentCount => scopedRoster.where((s) => s.status == AttendanceStatus.present).length;
  int get scopedAbsentCount => scopedRoster.where((s) => s.status == AttendanceStatus.absent).length;
  int get scopedOnDutyCount => scopedRoster.where((s) => s.isOnDuty || s.status == AttendanceStatus.onDuty).length;
  double get scopedAttendanceRate => scopedTotalStrength > 0 ? (scopedPresentCount / scopedTotalStrength) * 100 : 0.0;
  int get scopedPendingSlipsCount => scopedPinkSlips.where((s) => s.status != SlipStatus.approved && s.status != SlipStatus.rejected).length;

  // Global / Advisor stats for compatibility
  int get totalClassStrength => scopedTotalStrength;
  int get presentCount => scopedPresentCount;
  int get absentCount => scopedAbsentCount;
  int get onDutyCount => scopedOnDutyCount;
  double get classAttendanceRate => scopedAttendanceRate;
  int get pendingSlipsCount => scopedPendingSlipsCount;
  int get returnCheckCount => 2;

  // Timetable helpers
  TimetableSlot get currentTimetableSlot => CollegeTimetableData.getCurrentOrNextSlot('Monday', defaultPeriod: 2);

  // HOD Dept Stats
  double get deptAttendanceRate => 95.0;
  int get totalDeptStudents => _roster.isNotEmpty ? _roster.length : 234;
  int get awaitingHodCount => _pinkSlips.where((s) => s.status == SlipStatus.hodReview).length;
  int get escalatedCount => 2;


  void _initData() {
    // 60 Real Students for III Year - Section 'B' (Room: MB III A-202)
    final realStudentsData = [
      {'reg': '922524243062', 'name': 'JENITTA BLESSY S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:48 AM'},
      {'reg': '922524243064', 'name': 'KABEESH L', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:52 AM'},
      {'reg': '922524243065', 'name': 'KALAISELVI M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243066', 'name': 'KAMALI M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:55 AM'},
      {'reg': '922524243067', 'name': 'KAMALIKA Y S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:49 AM'},
      {'reg': '922524243068', 'name': 'KANIGA A', 'status': AttendanceStatus.onDuty, 'leave': LeaveType.onDuty, 'bio': 'OD Gate', 'isOd': true, 'odReason': 'National Level Smart India Hackathon 2026', 'odVenue': 'Anna University Main Campus, Guindy, Chennai', 'odDate': '24 Aug 2026 - 26 Aug 2026', 'proofName': 'Anna_University_Hackathon_Invite_2026.pdf', 'proofSize': '1.8 MB', 'isSigned': true, 'signedDoc': 'HOD_Signed_OD_Permission_922524243068.pdf', 'signedDate': '24 Aug 2026, 09:15 AM'},
      {'reg': '922524243069', 'name': 'KANISH M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:53 AM'},
      {'reg': '922524243070', 'name': 'KANISHKA S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:54 AM'},
      {'reg': '922524243071', 'name': 'KANNAN M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:47 AM'},
      {'reg': '922524243072', 'name': 'KARISHMA G', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243073', 'name': 'KARTHICK S', 'status': AttendanceStatus.onDuty, 'leave': LeaveType.onDuty, 'bio': 'OD Gate', 'isOd': true, 'odReason': 'State Level Technical Symposium · Paper Presentation', 'odVenue': 'PSG College of Technology, Coimbatore', 'odDate': '24 Aug 2026 (1 Day)', 'proofName': 'State_Symposium_Paper_Acceptance.pdf', 'proofSize': '1.5 MB', 'isSigned': false},
      {'reg': '922524243074', 'name': 'KARTHIK RAJA S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:52 AM'},
      {'reg': '922524243075', 'name': 'KARUPPADURAI G', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:51 AM'},
      {'reg': '922524243076', 'name': 'KATHIRVEL T', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:48 AM'},
      {'reg': '922524243077', 'name': 'KAVIN A', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:53 AM'},
      {'reg': '922524243078', 'name': 'KAVIN M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:55 AM'},
      {'reg': '922524243079', 'name': 'KAVIN SHARVESH R', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243080', 'name': 'KAVIRAJ R', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:54 AM'},
      {'reg': '922524243081', 'name': 'KAVIYA D', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:49 AM'},
      {'reg': '922524243082', 'name': 'KAVIYA P', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:52 AM'},
      {'reg': '922524243083', 'name': 'KAVIYADHARSHINI S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:51 AM'},
      {'reg': '922524243084', 'name': 'KAVYA SHREE TV', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:46 AM'},
      {'reg': '922524243085', 'name': 'KAWIN D', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:53 AM'},
      {'reg': '922524243086', 'name': 'KEERTHANA B', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243087', 'name': 'KEERTHANA S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:52 AM'},
      {'reg': '922524243088', 'name': 'KEERTHI B', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:55 AM'},
      {'reg': '922524243089', 'name': 'KIRUTHICKRAJA M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:54 AM'},
      {'reg': '922524243090', 'name': 'KIRUTHIKA D', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:48 AM'},
      {'reg': '922524243091', 'name': 'KIRUTHIKA N', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:49 AM'},
      {'reg': '922524243092', 'name': 'KISHORE S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:53 AM'},
      {'reg': '922524243093', 'name': 'KRITHEESH J', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:51 AM'},
      {'reg': '922524243094', 'name': 'LAKSHMI E', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243095', 'name': 'LALITHA M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:47 AM'},
      {'reg': '922524243096', 'name': 'LOGAPRIYA M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:46 AM'},
      {'reg': '922524243097', 'name': 'LOGESH S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:54 AM'},
      {'reg': '922524243098', 'name': 'LOKESH B', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:52 AM'},
      {'reg': '922524243099', 'name': 'MADHAN K', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:53 AM'},
      {'reg': '922524243100', 'name': 'MAHA SMIRTHI SS', 'status': AttendanceStatus.absent, 'leave': LeaveType.uninformed, 'due': '25 Aug'},
      {'reg': '922524243101', 'name': 'MAHALAKSHMI K', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243102', 'name': 'MAHAMANI J', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:51 AM'},
      {'reg': '922524243103', 'name': 'MAHARAJA M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:55 AM'},
      {'reg': '922524243104', 'name': 'MAHISA S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:49 AM'},
      {'reg': '922524243105', 'name': 'MAKITHA R', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:48 AM'},
      {'reg': '922524243106', 'name': 'MANJUSRI R', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243107', 'name': 'MANO T', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:53 AM'},
      {'reg': '922524243108', 'name': 'MEHARAJ BANU S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:48 AM'},
      {'reg': '922524243109', 'name': 'MISBBAHOONNISHAA A', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:46 AM'},
      {'reg': '922524243110', 'name': 'MOHAMMED JAVITH FARVEZ S K', 'status': AttendanceStatus.absent, 'leave': LeaveType.informed, 'due': '26 Aug'},
      {'reg': '922524243111', 'name': 'MOHANRAJ G', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:54 AM'},
      {'reg': '922524243112', 'name': 'MONISH B', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:51 AM'},
      {'reg': '922524243113', 'name': 'MOUNISHA P', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:49 AM'},
      {'reg': '922524243114', 'name': 'MUGESH A', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:55 AM'},
      {'reg': '922524243115', 'name': 'MUGESH YATHRA M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:52 AM'},
      {'reg': '922524243116', 'name': 'MUKILAN M', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:53 AM'},
      {'reg': '922524243117', 'name': 'MUTHU KARTHIGAI SELVAM S', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
      {'reg': '922524243118', 'name': 'MUTHUDEENATHAYALAN V', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:51 AM'},
      {'reg': '922524243119', 'name': 'MYTHILI L', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:48 AM'},
      {'reg': '922524243120', 'name': 'NANDHAKUMAR B', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:54 AM'},
      {'reg': '922524243121', 'name': 'NANMOZHI T', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:49 AM'},
      {'reg': '922524243122', 'name': 'NARASIMMAN A', 'status': AttendanceStatus.absent, 'leave': LeaveType.uninformed, 'due': '25 Aug'},
      {'reg': '922524243123', 'name': 'NAREN KS', 'status': AttendanceStatus.present, 'leave': LeaveType.none, 'bio': '08:50 AM'},
    ];

    final sectionB = realStudentsData.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      final item = entry.value;
      return StudentRecord(
        id: 'STU-3B-$idx',
        name: item['name'] as String,
        rollNumber: item['reg'] as String,
        year: 'III Year',
        section: 'Section B',
        status: item['status'] as AttendanceStatus,
        leaveType: item['leave'] as LeaveType,
        letterSubmitted: item['status'] == AttendanceStatus.absent,
        letterApproved: false,
        dueDate: item['due'] as String?,
        leavesTakenYtd: item['status'] == AttendanceStatus.absent ? 2 : 0,
        biometricTime: item['bio'] as String?,
        isOnDuty: item['isOd'] == true,
        odReason: item['odReason'] as String?,
        odVenue: item['odVenue'] as String?,
        odEventDate: item['odDate'] as String?,
        proofDocumentName: item['proofName'] as String?,
        proofDocumentSize: item['proofSize'] as String?,
        isHodSigned: item['isSigned'] == true,
        hodSignedDocumentName: item['signedDoc'] as String?,
        hodSignedDate: item['signedDate'] as String?,
      );
    }).toList();

    // Section A (III Year · Advisor: Ms. C. Vishnupriya)
    final secANames = [
      'ARAVIND S', 'BHAVANI K', 'CHANDRA M', 'DEEPA R', 'DINESH P',
      'DIVYA S', 'ELANGO T', 'GAYATHRI V', 'GOKUL K', 'HARIHARAN M',
      'HEMALATHA P', 'INDHIRAN R', 'JANANI S', 'JEEVITHA K', 'KAMALESH N',
      'KAVITHA M', 'MADHAVAN B', 'MANIKANDAN P', 'NANDHINI S', 'NAVEEN K',
    ];
    final sectionA = secANames.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      final isAbsent = idx == 5;
      final isOd = idx == 1;
      return StudentRecord(
        id: 'STU-3A-$idx',
        name: entry.value,
        rollNumber: '92252424300$idx',
        year: 'III Year',
        section: 'Section A',
        status: isAbsent ? AttendanceStatus.absent : (isOd ? AttendanceStatus.onDuty : AttendanceStatus.present),
        leaveType: isAbsent ? LeaveType.informed : (isOd ? LeaveType.onDuty : LeaveType.none),
        letterSubmitted: isAbsent,
        biometricTime: isAbsent ? null : '08:45 AM',
        isOnDuty: isOd,
        odReason: isOd ? 'State Level Hackathon (PSG Tech)' : null,
      );
    }).toList();

    // Section C (III Year · Advisor: Mrs. B. Bharathi)
    final secCNames = ['ABINAYA R', 'BALAJI K', 'CHARULATHA S', 'DHANUSH M', 'ESWARAN P', 'GOWTHAM S', 'HARINI V', 'ILAVARASAN T'];
    final sectionC = secCNames.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      return StudentRecord(
        id: 'STU-3C-$idx',
        name: entry.value,
        rollNumber: '92252424320$idx',
        year: 'III Year',
        section: 'Section C',
        status: idx == 4 ? AttendanceStatus.absent : AttendanceStatus.present,
        leaveType: idx == 4 ? LeaveType.uninformed : LeaveType.none,
        biometricTime: idx == 4 ? null : '08:50 AM',
      );
    }).toList();

    // Section D (III Year · Advisor: Mr. V. Velusamy)
    final secDNames = ['ANITHA K', 'BHARATH S', 'DEVIKA M', 'GOKULNATH R', 'HEMANTH P', 'JEEVAN T', 'KAVYA R'];
    final sectionD = secDNames.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      return StudentRecord(
        id: 'STU-3D-$idx',
        name: entry.value,
        rollNumber: '92252424330$idx',
        year: 'III Year',
        section: 'Section D',
        status: idx == 3 ? AttendanceStatus.absent : AttendanceStatus.present,
        leaveType: idx == 3 ? LeaveType.informed : LeaveType.none,
        biometricTime: idx == 3 ? null : '08:48 AM',
      );
    }).toList();

    // 2nd Year Section A
    final sec2ANames = ['ADITYA S', 'DIVESH K', 'HARISH M', 'KAVIN P', 'MEERA S', 'NITHISH R', 'PRAVEEN V'];
    final section2A = sec2ANames.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      return StudentRecord(
        id: 'STU-2A-$idx',
        name: entry.value,
        rollNumber: '92252524300$idx',
        year: '2nd year',
        section: 'Section A',
        status: AttendanceStatus.present,
        biometricTime: '08:47 AM',
      );
    }).toList();

    // 4th Year Section A
    final sec4ANames = ['AJITH KUMAR S', 'DEEPAK RAJ M', 'MONIKA R', 'RAGHUL V', 'SANJAY P', 'VIJAY K'];
    final section4A = sec4ANames.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      return StudentRecord(
        id: 'STU-4A-$idx',
        name: entry.value,
        rollNumber: '92252324300$idx',
        year: '4th year',
        section: 'Section A',
        status: AttendanceStatus.present,
        biometricTime: '08:45 AM',
      );
    }).toList();

    // 1st Year Section A
    final sec1ANames = ['AASHIK M', 'DHANUSH S', 'GOKUL R', 'KISHORE V', 'NANDHINI P', 'RAHUL T'];
    final section1A = sec1ANames.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      return StudentRecord(
        id: 'STU-1A-$idx',
        name: entry.value,
        rollNumber: '92252624300$idx',
        year: '1st year',
        section: 'Section A',
        status: AttendanceStatus.present,
        biometricTime: '08:50 AM',
      );
    }).toList();

    _roster = [
      ...sectionB,
      ...sectionA,
      ...sectionC,
      ...sectionD,
      ...section2A,
      ...section4A,
      ...section1A,
    ];

    _pinkSlips = [
      PinkSlip(
        id: 'OD-2026-081',
        studentName: 'KANIGA A',
        rollNumber: '922524243068',
        section: 'III AI&DS - Section B',
        reason: 'On-Duty: National Level Hackathon 2026 (Anna University)',
        raisedBy: 'Dr. R. Murugesan [RM]',
        raisedOn: DateTime.now().subtract(const Duration(days: 1)),
        daysPending: 0,
        status: SlipStatus.approved,
        isOd: true,
        attachedProofName: 'Anna_University_Hackathon_Invite_2026.pdf',
        attachedProofSize: '1.8 MB',
        hodSignedDocName: 'HOD_Signed_OD_Permission_922524243068.pdf',
        hodRemarks: 'Granted OD permission with academic attendance credit.',
        hodSigner: 'Dr. S. Karthikeyan, M.E., Ph.D. (HOD / AI&DS)',
        timeline: [
          TimelineStage(
            title: 'OD Request & Proof Uploaded',
            when: '22 Aug, 04:30 PM',
            note: 'Attached Anna_University_Hackathon_Invite_2026.pdf (1.8 MB)',
            isDone: true,
          ),
          TimelineStage(
            title: 'Adviser Verification & Recommendation',
            when: '23 Aug, 05:15 PM',
            note: 'Recommended by Dr. R. Murugesan [RM] (Class Adviser)',
            isDone: true,
          ),
          TimelineStage(
            title: 'HOD Digital Permission & Signed Document',
            when: '24 Aug, 09:15 AM',
            note: 'Digitally signed by Dr. S. Karthikeyan (HOD). Attached HOD_Signed_OD_Permission_922524243068.pdf (2.4 MB)',
            isDone: true,
          ),
        ],
      ),
      PinkSlip(
        id: 'OD-2026-082',
        studentName: 'KARTHICK S',
        rollNumber: '922524243073',
        section: 'III AI&DS - Section B',
        reason: 'On-Duty: State Level Technical Symposium (PSG Tech)',
        raisedBy: 'Dr. R. Murugesan [RM]',
        raisedOn: DateTime.now(),
        daysPending: 1,
        status: SlipStatus.hodReview,
        isOd: true,
        attachedProofName: 'State_Symposium_Paper_Acceptance.pdf',
        attachedProofSize: '1.5 MB',
        timeline: [
          TimelineStage(
            title: 'OD Request & Proof Attached',
            when: 'Today, 08:30 AM',
            note: 'Attached State_Symposium_Paper_Acceptance.pdf (1.5 MB)',
            isDone: true,
          ),
          TimelineStage(
            title: 'Adviser Verification & Recommendation',
            when: 'Today, 09:15 AM',
            note: 'Recommended by Dr. R. Murugesan [RM]',
            isDone: true,
          ),
          TimelineStage(
            title: 'HOD Digital Permission & Signed Document',
            when: 'Awaiting HOD Signature',
            isCurrent: true,
          ),
        ],
      ),
      PinkSlip(
        id: 'SLIP-001',
        studentName: 'MAHA SMIRTHI SS',
        rollNumber: '922524243100',
        section: 'III AI&DS · Section B',
        reason: 'Uninformed Absence (Due Date: 25 Aug)',
        raisedBy: 'Dr. R. Murugesan',
        raisedOn: DateTime.now().subtract(const Duration(days: 2)),
        daysPending: 2,
        status: SlipStatus.hodReview,
        timeline: const [
          TimelineStage(
            title: 'Submitted by adviser',
            when: '29 Aug · 10:14 AM',
            note: 'Parent contacted regarding uninformed absence.',
            isDone: true,
          ),
          TimelineStage(
            title: 'Adviser confirmation',
            when: '30 Aug · 02:30 PM',
            note: 'Verified with hostel warden.',
            isDone: true,
          ),
          TimelineStage(
            title: 'HOD approval',
            when: 'Pending review',
            note: 'Awaiting signature from Dr. S. Manivannan.',
            isDone: false,
          ),
        ],
      ),
      PinkSlip(
        id: 'SLIP-002',
        studentName: 'MOHAMMED JAVITH FARVEZ S K',
        rollNumber: '922524243110',
        section: 'III AI&DS · Section B',
        reason: 'Medical leave certificate verification',
        raisedBy: 'Dr. R. Murugesan',
        raisedOn: DateTime.now().subtract(const Duration(days: 1)),
        daysPending: 1,
        status: SlipStatus.hodReview,
        timeline: const [
          TimelineStage(
            title: 'Submitted by adviser',
            when: '30 Aug · 09:30 AM',
            note: 'Medical fitness certificate submitted.',
            isDone: true,
          ),
          TimelineStage(
            title: 'Adviser confirmation',
            when: '30 Aug · 11:00 AM',
            note: 'Approved by class advisor.',
            isDone: true,
          ),
          TimelineStage(
            title: 'HOD approval',
            when: 'Pending',
            note: 'Forwarded to HOD.',
            isDone: false,
          ),
        ],
      ),
    ];

    _sections = const [
      DepartmentSectionStat(
        year: 'III Year',
        section: 'Section B',
        advisorName: 'Dr. R. Murugesan [RM]',
        attendanceRate: 95.0,
        totalStudents: 61,
        pendingSlips: 2,
        roomName: 'MB III A-202',
      ),
      DepartmentSectionStat(
        year: 'III Year',
        section: 'Section A',
        advisorName: 'Ms. C. Vishnupriya [CV]',
        attendanceRate: 94.1,
        totalStudents: 58,
        pendingSlips: 1,
        roomName: 'MB III A-201',
      ),
      DepartmentSectionStat(
        year: 'III Year',
        section: 'Section C',
        advisorName: 'Mrs. B. Bharathi [BB]',
        attendanceRate: 91.8,
        totalStudents: 57,
        pendingSlips: 3,
        roomName: 'MB III A-203',
      ),
      DepartmentSectionStat(
        year: 'III Year',
        section: 'Section D',
        advisorName: 'Mr. V. Velusamy [VV]',
        attendanceRate: 93.6,
        totalStudents: 58,
        pendingSlips: 2,
        roomName: 'MB III A-204',
      ),
    ];

    _biometricPunches = [
      const BiometricPunch(
        id: 'PUNCH-001',
        studentName: 'JENITTA BLESSY S',
        rollNumber: '922524243062',
        inTime: '08:48 AM',
        description: 'MB III Floor Entrance · Reader #2 · On Time',
        dotColor: Color(0xFF10B981),
      ),
      const BiometricPunch(
        id: 'PUNCH-002',
        studentName: 'KABEESH L',
        rollNumber: '922524243064',
        inTime: '08:52 AM',
        description: 'MB III Floor Entrance · Reader #2 · On Time',
        dotColor: Color(0xFF10B981),
      ),
      const BiometricPunch(
        id: 'PUNCH-003',
        studentName: 'NARASIMMAN A',
        rollNumber: '922524243122',
        inTime: '09:22 AM',
        description: 'MB III Floor Entrance · Reader #1 · Late Entry',
        dotColor: Color(0xFFF59E0B),
      ),
    ];

    // Real Syllabus Subjects for III Year B.Tech AI&DS
    _studentSubjects = const [
      SubjectAttendance(
        name: 'Deep Learning [DL]',
        code: '23ADT501',
        presentCount: 42,
        totalCount: 45,
      ),
      SubjectAttendance(
        name: 'Data and Information Security [DIS]',
        code: '23CBT502',
        presentCount: 41,
        totalCount: 44,
      ),
      SubjectAttendance(
        name: 'Distributed Computing [DC]',
        code: '23CST504',
        presentCount: 39,
        totalCount: 42,
      ),
      SubjectAttendance(
        name: 'Cloud Service Management [CSM]',
        code: '23CSE011',
        presentCount: 40,
        totalCount: 43,
      ),
      SubjectAttendance(
        name: 'Big Data Analytics [BDA]',
        code: '23ADT502',
        presentCount: 38,
        totalCount: 40,
      ),
      SubjectAttendance(
        name: 'Business Analytics [BA]',
        code: '23CSE005',
        presentCount: 39,
        totalCount: 42,
      ),
      SubjectAttendance(
        name: 'Web Development [WD]',
        code: 'LAB / SKILL',
        presentCount: 42,
        totalCount: 44,
      ),
      SubjectAttendance(
        name: 'Aptitude [AP]',
        code: 'TRAINING',
        presentCount: 41,
        totalCount: 44,
      ),
    ];

    _chatMessages = [
      ChatMessage(
        text: 'Good morning Dr. R. Murugesan. I have loaded the timetable for III Year Section B (Room MB III A-202). Period 2 (Aptitude) is currently active.',
        isUser: false,
        time: '9:41 AM',
      ),
      ChatMessage(
        text: 'How many students are absent today in III Year B?',
        isUser: true,
        time: '9:41 AM',
      ),
      ChatMessage(
        text: 'Found 3 absentees today in Section B: MAHA SMIRTHI SS (922524243100), MOHAMMED JAVITH FARVEZ (922524243110), and NARASIMMAN A (922524243122).',
        isUser: false,
        time: '9:42 AM',
        miniCardText: '3 absentees in III B · 58 present (95.0% attendance rate). Next period: P3 (11:00 AM) Aptitude.',
        actionChips: [
          'Open Timetable',
          'Scan Raptor Camera',
          'Open Class Register',
          'View Pending Slips',
        ],
      ),
    ];

    _classSessionPhotos = [
      ClassSessionPhoto(
        id: 'RAPTOR-SES-001',
        year: '3rd Year',
        section: 'B',
        department: 'AI & DS',
        subject: '23ADT501 · Deep Learning [DL]',
        period: 'Period 2 (10:00 AM)',
        roomName: 'MB III A-202 · Raptor Smart Board',
        advisorName: 'Dr. R. Murugesan [RM]',
        capturedAt: '31 Aug 2026, 10:05 AM',
        imageType: 'smart_board',
        detectedFaces: const [
          DetectedFace(
            id: 'F1',
            studentName: 'JENITTA BLESSY S',
            rollNumber: '922524243062',
            confidence: 0.986,
            topPercent: 0.28,
            leftPercent: 0.18,
            widthPercent: 0.22,
            heightPercent: 0.15,
          ),
          DetectedFace(
            id: 'F2',
            studentName: 'KABEESH L',
            rollNumber: '922524243064',
            confidence: 0.974,
            topPercent: 0.26,
            leftPercent: 0.58,
            widthPercent: 0.20,
            heightPercent: 0.14,
          ),
          DetectedFace(
            id: 'F3',
            studentName: 'KALAISELVI M',
            rollNumber: '922524243065',
            confidence: 0.991,
            topPercent: 0.48,
            leftPercent: 0.12,
            widthPercent: 0.22,
            heightPercent: 0.15,
          ),
          DetectedFace(
            id: 'F4',
            studentName: 'KAMALI M',
            rollNumber: '922524243066',
            confidence: 0.965,
            topPercent: 0.46,
            leftPercent: 0.44,
            widthPercent: 0.21,
            heightPercent: 0.15,
          ),
          DetectedFace(
            id: 'F5',
            studentName: 'KARTHIK RAJA S',
            rollNumber: '922524243074',
            confidence: 0.982,
            topPercent: 0.49,
            leftPercent: 0.72,
            widthPercent: 0.20,
            heightPercent: 0.14,
          ),
        ],
        absentStudentNames: const ['MAHA SMIRTHI SS (922524243100)', 'MOHAMMED JAVITH FARVEZ (922524243110)'],
        totalStrength: 61,
        sentToHod: true,
        hodApproved: true,
      ),
      ClassSessionPhoto(
        id: 'RAPTOR-SES-002',
        year: '3rd Year',
        section: 'A',
        department: 'AI & DS',
        subject: '23ADT501 · Deep Learning [DL]',
        period: 'Period 1 (09:15 AM)',
        roomName: 'MB III A-201 · Raptor Smart Board',
        advisorName: 'Ms. C. Vishnupriya [CV]',
        capturedAt: '31 Aug 2026, 09:20 AM',
        imageType: 'smart_board',
        detectedFaces: const [
          DetectedFace(
            id: 'F10',
            studentName: 'Aravind S',
            rollNumber: '922524243001',
            confidence: 0.988,
            topPercent: 0.32,
            leftPercent: 0.22,
            widthPercent: 0.20,
            heightPercent: 0.14,
          ),
          DetectedFace(
            id: 'F11',
            studentName: 'Bhavani K',
            rollNumber: '922524243005',
            confidence: 0.975,
            topPercent: 0.35,
            leftPercent: 0.52,
            widthPercent: 0.21,
            heightPercent: 0.15,
          ),
        ],
        absentStudentNames: const ['Dinesh P (922524243015)'],
        totalStrength: 58,
        sentToHod: true,
        hodApproved: false,
      ),
    ];
  }

  void approvePinkSlip(String slipId) {
    if (!isAuthenticated) return;
    if (!canCurrentUserEdit && !isHodAdmin) return;
    final idx = _pinkSlips.indexWhere((s) => s.id == slipId);
    if (idx != -1) {
      final slip = _pinkSlips[idx];
      // If advisor/classRep, ensure the slip belongs to their own year & section
      if (currentRole == UserRole.advisor || currentRole == UserRole.classRep) {
        if (!slip.section.contains(_currentUserProfile.section.replaceAll('Section ', 'Sec'))) {
          if (!slip.section.contains(_currentUserProfile.section)) {
            return; // Block cross-section approval
          }
        }
      }
      _pinkSlips[idx].status = SlipStatus.approved;
      notifyListeners();
    }
  }

  void rejectPinkSlip(String slipId) {
    if (!isAuthenticated) return;
    if (!canCurrentUserEdit && !isHodAdmin) return;
    final idx = _pinkSlips.indexWhere((s) => s.id == slipId);
    if (idx != -1) {
      final slip = _pinkSlips[idx];
      // If advisor/classRep, ensure the slip belongs to their own year & section
      if (currentRole == UserRole.advisor || currentRole == UserRole.classRep) {
        if (!slip.section.contains(_currentUserProfile.section.replaceAll('Section ', 'Sec'))) {
          if (!slip.section.contains(_currentUserProfile.section)) {
            return; // Block cross-section rejection
          }
        }
      }
      _pinkSlips[idx].status = SlipStatus.rejected;
      notifyListeners();
    }
  }

  void approveAllHod() {
    if (!isAuthenticated || !isHodAdmin) return; // Only Primary HOD can approve all
    for (var slip in _pinkSlips) {
      if (slip.status == SlipStatus.hodReview) {
        slip.status = SlipStatus.approved;
      }
    }
    notifyListeners();
  }

  void signOdPermission(String studentId) {
    if (!isAuthenticated || !isHodAdmin) return; // Only Primary HOD can sign OD orders
    final idx = _roster.indexWhere((s) => s.id == studentId || s.rollNumber == studentId);
    if (idx != -1) {
      _roster[idx].isHodSigned = true;
      _roster[idx].hodSignedDate = '31 Aug 2026, 12:40 PM';
      _roster[idx].hodSignedDocumentName = 'HOD_Signed_OD_Permission_Order_${_roster[idx].rollNumber}.pdf';
      _roster[idx].hodRemarks = 'Permission officially granted with full duty attendance credit.';
      _roster[idx].hodSigner = 'Dr. S. Manivannan (Overall HOD / AI&DS)';
      _roster[idx].letterApproved = true;
    }

    // Also update any matching pink slip in the queue
    for (var slip in _pinkSlips) {
      if (slip.rollNumber == studentId || (idx != -1 && slip.rollNumber == _roster[idx].rollNumber)) {
        slip.status = SlipStatus.approved;
      }
    }
    notifyListeners();
  }

  void applyOdRequest({
    required String studentRoll,
    required String reason,
    required String venue,
    required String eventDate,
    required String proofName,
    required String proofSize,
  }) {
    final idx = _roster.indexWhere((s) => s.rollNumber == studentRoll);
    if (idx != -1) {
      final student = _roster[idx];
      student.status = AttendanceStatus.onDuty;
      student.leaveType = LeaveType.onDuty;
      student.isOnDuty = true;
      student.odReason = reason;
      student.odVenue = venue;
      student.odEventDate = eventDate;
      student.proofDocumentName = proofName;
      student.proofDocumentSize = proofSize;
      student.proofUploadedAt = 'Today, 12:40 PM';
      student.letterSubmitted = true;
      student.isHodSigned = false;

      // Add to pink slips queue as OD slip awaiting HOD review
      _pinkSlips.insert(
        0,
        PinkSlip(
          id: 'OD-${DateTime.now().millisecondsSinceEpoch}',
          studentName: student.name,
          rollNumber: student.rollNumber,
          section: '${student.year} - ${student.section}',
          reason: 'On-Duty: $reason',
          raisedBy: _currentUserProfile.name,
          raisedOn: DateTime.now(),
          daysPending: 1,
          status: SlipStatus.hodReview,
          isOd: true,
          attachedProofName: proofName,
          attachedProofSize: proofSize,
          timeline: [
            TimelineStage(
              title: 'OD Request & Proof Attached',
              when: 'Today, 12:40 PM',
              note: 'Attached $proofName ($proofSize)',
              isDone: true,
            ),
            TimelineStage(
              title: 'Class Adviser Verification',
              when: 'Today, 12:42 PM',
              note: 'Recommended by ${_currentUserProfile.name}',
              isDone: true,
            ),
            const TimelineStage(
              title: 'HOD Digital Permission & Signed Document',
              when: 'Awaiting HOD Signature',
              isCurrent: true,
            ),
          ],
        ),
      );
    }
    notifyListeners();
  }

  void toggleStudentAttendance(String studentId, AttendanceStatus newStatus) {
    if (!isAuthenticated) return;
    if (!canCurrentUserEdit && !isHodAdmin) return;
    final idx = _roster.indexWhere((s) => s.id == studentId);
    if (idx != -1) {
      // If advisor/classRep, ensure the student is in their own section
      if (currentRole == UserRole.advisor || currentRole == UserRole.classRep) {
        if (_roster[idx].section != _currentUserProfile.section) {
          return; // Block editing attendance of another section
        }
      }
      _roster[idx].status = newStatus;
      notifyListeners();
    }
  }

  void markAllPresent() {
    if (!isAuthenticated) return;
    if (!canCurrentUserEdit && !isHodAdmin) return;
    for (var student in scopedRoster) {
      student.status = AttendanceStatus.present;
    }
    notifyListeners();
  }

  void addClassSessionPhoto(ClassSessionPhoto session) {
    if (!isAuthenticated) return;
    _classSessionPhotos.insert(0, session);
    notifyListeners();
  }

  void updateClassSessionPhoto(ClassSessionPhoto session) {
    if (!isAuthenticated) return;
    final idx = _classSessionPhotos.indexWhere((s) => s.id == session.id);
    if (idx != -1) {
      _classSessionPhotos[idx] = session;
      notifyListeners();
    }
  }

  void approveClassPhotoReportByHod(String sessionId) {
    if (!isAuthenticated || !isHodAdmin) return; // Only Primary HOD can approve photo audit
    final idx = _classSessionPhotos.indexWhere((s) => s.id == sessionId);
    if (idx != -1) {
      _classSessionPhotos[idx] = _classSessionPhotos[idx].copyWith(hodApproved: true);
      notifyListeners();
    }
  }

  void deleteBiometricRecord(String punchId) {
    if (!isAuthenticated || !canCurrentUserDelete) return; // Only Primary HOD can delete
    _biometricPunches.removeWhere((p) => p.id == punchId);
    notifyListeners();
  }

  void addChatMessage(String text) {
    _chatMessages.add(ChatMessage(
      text: text,
      isUser: true,
      time: 'Just now',
    ));

    String botReply = "I'm checking the timetable and attendance records for ${_currentUserProfile.year} ${_currentUserProfile.section}.";
    String? miniCard;
    List<String> chips = ['Open Timetable', 'Scan Raptor Camera', 'Class Register'];

    final lower = text.toLowerCase();
    if (lower.contains('timetable') || lower.contains('schedule') || lower.contains('period')) {
      botReply = "Today's schedule has 8 periods. Period 2 (10:00 - 10:45 AM) is currently active in Room MB III A-202.";
      miniCard = "Current: P2 Aptitude [CK] · Next: P3 (11:00 AM) Aptitude [CK].";
      chips = ['Open Timetable', 'Scan Raptor Camera'];
    } else if (lower.contains('absent') || lower.contains('uninformed')) {
      botReply = "Found 3 absentees today in Section B: MAHA SMIRTHI SS, MOHAMMED JAVITH FARVEZ, and NARASIMMAN A.";
      miniCard = "3 absentees recorded: 2 uninformed, 1 medical leave.";
      chips = ['Open filtered register', 'Send reminder'];
    } else if (lower.contains('approve') || lower.contains('letter') || lower.contains('slip')) {
      botReply = "There are $awaitingHodCount pink slips currently waiting for HOD review.";
      chips = ['Approve all', 'View pending slips'];
    } else if (lower.contains('status') || lower.contains('overview')) {
      botReply = "Section attendance is currently at ${scopedAttendanceRate.toStringAsFixed(1)}% across $scopedTotalStrength students.";
      miniCard = "Room MB III A-202 · Raptor Smart Board Online";
    }

    _chatMessages.add(ChatMessage(
      text: botReply,
      isUser: false,
      time: 'Just now',
      miniCardText: miniCard,
      actionChips: chips,
    ));

    notifyListeners();
  }
}

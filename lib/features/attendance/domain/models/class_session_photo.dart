class DetectedFace {
  final String id;
  final String studentName;
  final String rollNumber;
  final double confidence; // e.g. 0.982 (98.2%)
  final double topPercent; // 0.0 to 1.0 (relative position on image)
  final double leftPercent;
  final double widthPercent;
  final double heightPercent;
  final bool isVerified;

  const DetectedFace({
    required this.id,
    required this.studentName,
    required this.rollNumber,
    required this.confidence,
    required this.topPercent,
    required this.leftPercent,
    required this.widthPercent,
    required this.heightPercent,
    this.isVerified = true,
  });

  String get confidenceDisplay => '${(confidence * 100).toStringAsFixed(1)}%';
}

class ClassSessionPhoto {
  final String id;
  final String year; // e.g. '2nd Year'
  final String section; // e.g. 'B'
  final String department; // e.g. 'AI & DS'
  final String subject; // e.g. 'AD8601 Deep Learning'
  final String period; // e.g. 'Period 2 (09:45 AM)'
  final String roomName; // e.g. 'Hall 302 · Raptor Smart Board #4'
  final String advisorName; // e.g. 'Mrs. S. Muthulakshmi'
  final String capturedAt; // e.g. '31 Aug 2026, 09:50 AM'
  final String imageType; // 'smart_board' | 'mobile_camera'
  final List<DetectedFace> detectedFaces;
  final List<String> absentStudentNames;
  final int totalStrength;
  final bool sentToHod;
  final bool hodApproved;
  final String? hodNotes;

  const ClassSessionPhoto({
    required this.id,
    required this.year,
    required this.section,
    required this.department,
    required this.subject,
    required this.period,
    required this.roomName,
    required this.advisorName,
    required this.capturedAt,
    required this.imageType,
    required this.detectedFaces,
    required this.absentStudentNames,
    required this.totalStrength,
    this.sentToHod = true,
    this.hodApproved = false,
    this.hodNotes,
  });

  int get presentCount => detectedFaces.length;
  int get absentCount => absentStudentNames.length;
  double get attendancePercentage =>
      totalStrength > 0 ? (presentCount / totalStrength) * 100 : 0.0;

  ClassSessionPhoto copyWith({
    bool? sentToHod,
    bool? hodApproved,
    String? hodNotes,
  }) {
    return ClassSessionPhoto(
      id: id,
      year: year,
      section: section,
      department: department,
      subject: subject,
      period: period,
      roomName: roomName,
      advisorName: advisorName,
      capturedAt: capturedAt,
      imageType: imageType,
      detectedFaces: detectedFaces,
      absentStudentNames: absentStudentNames,
      totalStrength: totalStrength,
      sentToHod: sentToHod ?? this.sentToHod,
      hodApproved: hodApproved ?? this.hodApproved,
      hodNotes: hodNotes ?? this.hodNotes,
    );
  }
}

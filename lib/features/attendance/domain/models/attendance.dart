import 'package:flutter/material.dart';

enum AttendanceStatus { present, absent, late, onDuty }
enum LeaveType { none, informed, uninformed, onDuty }

class StudentRecord {
  final String id;
  final String name;
  final String rollNumber;
  final String year;
  final String section;
  AttendanceStatus status;
  LeaveType leaveType;
  bool letterSubmitted;
  bool letterApproved;
  String? submittedToAdvisorDate;
  String? forwardedToHodDate;
  String? dueDate;
  int leavesTakenYtd;
  String? biometricTime;

  // On Duty (OD) & Signed Proof Document Fields
  bool isOnDuty;
  String? odReason;
  String? odVenue;
  String? odEventDate;
  String? proofDocumentName;
  String? proofDocumentSize;
  String? proofUploadedAt;
  bool isHodSigned;
  String? hodSignedDocumentName;
  String? hodSignedDate;
  String? hodRemarks;
  String? hodSigner;

  StudentRecord({
    required this.id,
    required this.name,
    required this.rollNumber,
    this.year = 'III Year',
    required this.section,
    this.status = AttendanceStatus.present,
    this.leaveType = LeaveType.none,
    this.letterSubmitted = false,
    this.letterApproved = false,
    this.submittedToAdvisorDate,
    this.forwardedToHodDate,
    this.dueDate,
    this.leavesTakenYtd = 0,
    this.biometricTime,
    this.isOnDuty = false,
    this.odReason,
    this.odVenue,
    this.odEventDate,
    this.proofDocumentName,
    this.proofDocumentSize,
    this.proofUploadedAt,
    this.isHodSigned = false,
    this.hodSignedDocumentName,
    this.hodSignedDate,
    this.hodRemarks,
    this.hodSigner,
  });


  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name.substring(0, 2).toUpperCase() : 'ST';
  }
}

class BiometricPunch {
  final String id;
  final String studentName;
  final String rollNumber;
  final String inTime;
  final String? outTime;
  final String description;
  final Color dotColor;
  final bool isManualOverride;
  final bool isAbsent;

  const BiometricPunch({
    required this.id,
    required this.studentName,
    required this.rollNumber,
    required this.inTime,
    this.outTime,
    required this.description,
    required this.dotColor,
    this.isManualOverride = false,
    this.isAbsent = false,
  });
}

class DepartmentSectionStat {
  final String sectionName;
  final String yearLabel;
  final String advisorName;
  final double attendancePct;
  final int totalStudents;
  final int pendingHodCount;

  const DepartmentSectionStat({
    required this.sectionName,
    required this.yearLabel,
    required this.advisorName,
    required this.attendancePct,
    required this.totalStudents,
    required this.pendingHodCount,
  });
}

class SubjectAttendance {
  final String name;
  final String code;
  final int presentCount;
  final int totalCount;

  const SubjectAttendance({
    required this.name,
    required this.code,
    required this.presentCount,
    required this.totalCount,
  });

  double get percentage => totalCount > 0 ? (presentCount / totalCount) * 100 : 0.0;
}

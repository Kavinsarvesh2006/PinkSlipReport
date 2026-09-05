enum SlipStatus { pending, approved, hodReview, rejected }

class TimelineStage {
  final String title;
  final String when;
  final String? note;
  final bool isDone;
  final bool isCurrent;

  const TimelineStage({
    required this.title,
    required this.when,
    this.note,
    this.isDone = false,
    this.isCurrent = false,
  });
}

class PinkSlip {
  final String id;
  final String studentName;
  final String rollNumber;
  final String section;
  final String reason;
  final String raisedBy;
  final DateTime raisedOn;
  final int daysPending;
  SlipStatus status;
  final List<TimelineStage> timeline;
  final bool isOd;
  final String? attachedProofName;
  final String? attachedProofSize;
  final String? hodSignedDocName;
  final String? hodRemarks;
  final String? hodSigner;

  PinkSlip({
    required this.id,
    required this.studentName,
    required this.rollNumber,
    required this.section,
    required this.reason,
    required this.raisedBy,
    required this.raisedOn,
    required this.daysPending,
    required this.status,
    required this.timeline,
    this.isOd = false,
    this.attachedProofName,
    this.attachedProofSize,
    this.hodSignedDocName,
    this.hodRemarks,
    this.hodSigner,
  });

  String get initials {
    final parts = studentName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return studentName.isNotEmpty ? studentName.substring(0, 2).toUpperCase() : 'ST';
  }

  // Pipeline stepper state: [submitted, advisor, hod] (0=todo, 1=current, 2=done)
  List<int> get pipelineState {
    switch (status) {
      case SlipStatus.pending:
        return [2, 1, 0]; // Submitted done, Adviser current, HOD todo
      case SlipStatus.hodReview:
        return [2, 2, 1]; // Submitted done, Adviser done, HOD current
      case SlipStatus.approved:
        return [2, 2, 2]; // All done
      case SlipStatus.rejected:
        return [2, 2, 0];
    }
  }
}

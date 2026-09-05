enum UserRole { advisor, classRep, hod, student }

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String roleTitle;
  final String year;
  final String section;
  final String department;
  final String college;
  final UserRole role;
  final bool canEdit;
  final bool canDelete;
  final bool isHodAdmin;

  const UserProfile({
    required this.id,
    required this.name,
    this.email = '',
    required this.roleTitle,
    this.year = 'III Year',
    required this.section,
    required this.department,
    required this.college,
    required this.role,
    this.canEdit = false,
    this.canDelete = false,
    this.isHodAdmin = false,
  });

  // 1. Primary Overall HOD - Dr. S. Manivannan (Full Authority)
  static const hodAdminProfile = UserProfile(
    id: 'HOD001',
    name: 'Dr. S. Manivannan',
    email: 'manivannan.hod@vsb.ac.in',
    roleTitle: 'Overall HOD (Admin)',
    year: 'All Years',
    section: 'All Sections',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.hod,
    canEdit: true,
    canDelete: true,
    isHodAdmin: true,
  );

  // 2. Year-Specific HOD - Mrs. Kavitha (1st & 2nd Year)
  static const hodKavithaProfile = UserProfile(
    id: 'HOD002',
    name: 'Mrs. Kavitha',
    email: 'kavitha.hod@vsb.ac.in',
    roleTitle: 'HOD (1st & 2nd Year)',
    year: '1st & 2nd Year',
    section: 'All Sections',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.hod,
    canEdit: true,
    canDelete: true,
    isHodAdmin: true,
  );

  // Default HOD profile for backward compatibility
  static const hodProfile = hodAdminProfile;
  static const hodManivannanProfile = hodAdminProfile;

  // 4. Class Adviser - III Year Section A
  static const advisor3AProfile = UserProfile(
    id: 'ADV001',
    name: 'Ms. C. Vishnupriya [CV]',
    email: 'vishnupriya.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'III Year',
    section: 'Section A',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 5. Class Adviser - III Year Section B (Confidential to III-B)
  static const advisorProfile = UserProfile(
    id: 'ADV002',
    name: 'Dr. R. Murugesan [RM]',
    email: 'murugesan.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'III Year',
    section: 'Section B',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );
  static const advisor3BProfile = advisorProfile;

  // 6. Class Adviser - III Year Section C
  static const advisor3CProfile = UserProfile(
    id: 'ADV003',
    name: 'Mrs. B. Bharathi [BB]',
    email: 'bharathi.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'III Year',
    section: 'Section C',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 7. Class Adviser - III Year Section D
  static const advisor3DProfile = UserProfile(
    id: 'ADV004',
    name: 'Mr. V. Velusamy [VV]',
    email: 'velusamy.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'III Year',
    section: 'Section D',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // --- II YEAR CLASS ADVISERS ---
  // 8. Class Adviser - II Year Section A
  static const advisor2AProfile = UserProfile(
    id: 'ADV201',
    name: 'Mr. P. Prakash [PP]',
    email: 'prakash.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'II Year',
    section: 'Section A',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 9. Class Adviser - II Year Section B
  static const advisor2BProfile = UserProfile(
    id: 'ADV202',
    name: 'Mrs. M. Sivagami [MS]',
    email: 'sivagami.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'II Year',
    section: 'Section B',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 10. Class Adviser - II Year Section C
  static const advisor2CProfile = UserProfile(
    id: 'ADV203',
    name: 'Mr. D. Baskar [DB]',
    email: 'baskar.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'II Year',
    section: 'Section C',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 11. Class Adviser - II Year Section D
  static const advisor2DProfile = UserProfile(
    id: 'ADV204',
    name: 'Mrs. K. Deepa [KD]',
    email: 'deepa.advisor@vsb.ac.in',
    roleTitle: 'Class Adviser',
    year: 'II Year',
    section: 'Section D',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.advisor,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 12. Class Representative - III Year Section B (Confidential to III-B)
  static const classRepProfile = UserProfile(
    id: 'REP001',
    name: 'JENITTA BLESSY S',
    email: 'jenitta.rep@vsb.ac.in',
    roleTitle: 'Class Representative',
    year: 'III Year',
    section: 'Section B',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.classRep,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 13. Class Representative - II Year Section A
  static const classRep2AProfile = UserProfile(
    id: 'REP201',
    name: 'ADITYA S',
    email: 'aditya.rep@vsb.ac.in',
    roleTitle: 'Class Representative',
    year: 'II Year',
    section: 'Section A',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.classRep,
    canEdit: true,
    canDelete: false,
    isHodAdmin: false,
  );

  // 14. Student - III Year Section B
  static const studentProfile = UserProfile(
    id: '922524243062',
    name: 'LITHESH HARI R',
    email: 'lithesh.student@vsb.ac.in',
    roleTitle: 'Student',
    year: 'III Year',
    section: 'Section B',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.student,
    canEdit: false,
    canDelete: false,
    isHodAdmin: false,
  );

  // 15. Student - II Year Section A
  static const student2AProfile = UserProfile(
    id: '922525243002',
    name: 'DIVESH K',
    email: 'divesh.student@vsb.ac.in',
    roleTitle: 'Student',
    year: 'II Year',
    section: 'Section A',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.student,
    canEdit: false,
    canDelete: false,
    isHodAdmin: false,
  );
}


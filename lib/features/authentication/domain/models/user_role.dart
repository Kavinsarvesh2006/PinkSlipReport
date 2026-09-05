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

  // 1. Primary HOD - Full Authority (Can View All, Edit & Delete)
  static const hodAdminProfile = UserProfile(
    id: 'HOD001',
    name: 'Dr. R. Balamurugan',
    email: 'balamurugan.hod@vsb.ac.in',
    roleTitle: 'Head of Department (Admin)',
    year: 'All Years',
    section: 'All Sections',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.hod,
    canEdit: true,
    canDelete: true,
    isHodAdmin: true,
  );

  // 2. Secondary HOD - Read-Only Viewer (Can View All, Cannot Edit or Delete)
  static const hodViewerProfile = UserProfile(
    id: 'HOD002',
    name: 'Dr. S. Karthikeyan',
    email: 'karthikeyan.hod@vsb.ac.in',
    roleTitle: 'Associate HOD (Viewer)',
    year: 'All Years',
    section: 'All Sections',
    department: 'AI & DS',
    college: 'V.S.B. Engineering College',
    role: UserRole.hod,
    canEdit: false,
    canDelete: false,
    isHodAdmin: false,
  );

  // Default HOD profile for backward compatibility
  static const hodProfile = hodAdminProfile;

  // 3. Class Adviser - III Year Section B (Confidential to III-B)
  static const advisorProfile = UserProfile(
    id: 'ADV001',
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

  // 4. Class Adviser - III Year Section A (Confidential to III-A)
  static const advisor3AProfile = UserProfile(
    id: 'ADV002',
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

  // 5. Class Representative - III Year Section B (Confidential to III-B)
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

  // 6. Student - III Year Section B
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
}


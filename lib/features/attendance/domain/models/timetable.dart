class TimetablePeriod {
  final int periodNumber;
  final String timeRange;
  final String startTime;
  final String endTime;

  const TimetablePeriod({
    required this.periodNumber,
    required this.timeRange,
    required this.startTime,
    required this.endTime,
  });
}

class TimetableSubject {
  final String code;
  final String name;
  final String shortCode;
  final String facultyName;
  final String facultyInitials;
  final bool isLab;
  final int noOfPeriods;

  const TimetableSubject({
    required this.code,
    required this.name,
    required this.shortCode,
    required this.facultyName,
    required this.facultyInitials,
    this.isLab = false,
    this.noOfPeriods = 4,
  });
}

class TimetableSlot {
  final String day; // Monday, Tuesday, ...
  final int periodNumber; // 1 to 8
  final String timeRange;
  final String subjectCode;
  final String subjectName;
  final String shortCode;
  final String facultyName;
  final String facultyInitials;
  final String roomName;
  final bool isLab;

  const TimetableSlot({
    required this.day,
    required this.periodNumber,
    required this.timeRange,
    required this.subjectCode,
    required this.subjectName,
    required this.shortCode,
    required this.facultyName,
    required this.facultyInitials,
    required this.roomName,
    this.isLab = false,
  });
}

class CollegeTimetableData {
  static const List<TimetablePeriod> standardPeriods = [
    TimetablePeriod(periodNumber: 1, timeRange: '09.15 - 10.00', startTime: '09:15', endTime: '10:00'),
    TimetablePeriod(periodNumber: 2, timeRange: '10.00 - 10.45', startTime: '10:00', endTime: '10:45'),
    TimetablePeriod(periodNumber: 3, timeRange: '11.00 - 11.45', startTime: '11:00', endTime: '11:45'),
    TimetablePeriod(periodNumber: 4, timeRange: '11.45 - 12.30', startTime: '11:45', endTime: '12:30'),
    TimetablePeriod(periodNumber: 5, timeRange: '01.20 - 02.05', startTime: '13:20', endTime: '14:05'),
    TimetablePeriod(periodNumber: 6, timeRange: '02.05 - 02.50', startTime: '14:05', endTime: '14:50'),
    TimetablePeriod(periodNumber: 7, timeRange: '03.05 - 03.50', startTime: '15:05', endTime: '15:50'),
    TimetablePeriod(periodNumber: 8, timeRange: '03.50 - 04.30', startTime: '15:50', endTime: '16:30'),
  ];

  // III Year Section B Subjects & Faculty
  static const Map<String, TimetableSubject> subjectsIII_B = {
    'CSM': TimetableSubject(
      code: '23CSE011',
      name: 'Cloud Service Management',
      shortCode: 'CSM',
      facultyName: 'Dr. K. Manivannan',
      facultyInitials: '[KM]',
      noOfPeriods: 3,
    ),
    'DL': TimetableSubject(
      code: '23ADT501',
      name: 'Deep Learning',
      shortCode: 'DL',
      facultyName: 'Dr. R. Murugesan',
      facultyInitials: '[RM]',
      noOfPeriods: 4,
    ),
    'DIS': TimetableSubject(
      code: '23CBT502',
      name: 'Data and Information Security',
      shortCode: 'DIS',
      facultyName: 'Mrs. M. Sivagami',
      facultyInitials: '[MS]',
      noOfPeriods: 4,
    ),
    'DC': TimetableSubject(
      code: '23CST504',
      name: 'Distributed Computing',
      shortCode: 'DC',
      facultyName: 'Ms. S. Muthulakshmi',
      facultyInitials: '[SM]',
      noOfPeriods: 4,
    ),
    'BDA': TimetableSubject(
      code: '23ADT502',
      name: 'Big Data Analytics',
      shortCode: 'BDA',
      facultyName: 'Mr. D. Baskar',
      facultyInitials: '[DB]',
      noOfPeriods: 3,
    ),
    'BA': TimetableSubject(
      code: '23CSE005',
      name: 'Business Analytics',
      shortCode: 'BA',
      facultyName: 'Mr. M. Ramesh',
      facultyInitials: '[MR]',
      noOfPeriods: 4,
    ),
    'CSM LAB': TimetableSubject(
      code: '23CSE011',
      name: 'Cloud Service Management Lab',
      shortCode: 'CSM LAB',
      facultyName: 'Mr. A. Bharathidhasan',
      facultyInitials: '[AB]',
      isLab: true,
      noOfPeriods: 2,
    ),
    'BDA LAB': TimetableSubject(
      code: '23ADT502',
      name: 'Big Data Analytics Lab',
      shortCode: 'BDA LAB',
      facultyName: 'Mr. D. Baskar',
      facultyInitials: '[DB]',
      isLab: true,
      noOfPeriods: 2,
    ),
    'DL LAB': TimetableSubject(
      code: '23ADT501',
      name: 'Deep Learning Lab',
      shortCode: 'DL LAB',
      facultyName: 'Dr. R. Murugesan',
      facultyInitials: '[RM]',
      isLab: true,
      noOfPeriods: 4,
    ),
    'BA LAB': TimetableSubject(
      code: '23CSE005',
      name: 'Business Analytics Lab',
      shortCode: 'BA LAB',
      facultyName: 'Mr. M. Ramesh',
      facultyInitials: '[MR]',
      isLab: true,
      noOfPeriods: 2,
    ),
    'AP': TimetableSubject(
      code: '-',
      name: 'Aptitude',
      shortCode: 'AP',
      facultyName: 'Mr. C. Kavin Prakash',
      facultyInitials: '[CK]',
      noOfPeriods: 4,
    ),
    'WD': TimetableSubject(
      code: '-',
      name: 'Web Development',
      shortCode: 'WD',
      facultyName: 'Mr. C. Kavin Prakash & Dr. R. Murugesan',
      facultyInitials: '[CK/RM]',
      noOfPeriods: 4,
    ),
    'ADS': TimetableSubject(
      code: '-',
      name: 'Advanced Data Structure and Algorithm',
      shortCode: 'ADS',
      facultyName: 'Dr. R. Murugesan & Mr. A. Bharathidhasan',
      facultyInitials: '[RM/AB]',
      noOfPeriods: 4,
    ),
    'COMM': TimetableSubject(
      code: '-',
      name: 'Communication Training',
      shortCode: 'COMM',
      facultyName: 'Mr. D. Baskar',
      facultyInitials: '[DB]',
      noOfPeriods: 4,
    ),
  };

  // Full Weekly Schedule for III Year - Section 'B' (Class Room: MB III A-202)
  static const List<TimetableSlot> scheduleIII_B = [
    // Monday
    TimetableSlot(day: 'Monday', periodNumber: 1, timeRange: '09.15 - 10.00', subjectCode: '-', subjectName: 'Aptitude', shortCode: 'AP', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Monday', periodNumber: 2, timeRange: '10.00 - 10.45', subjectCode: '-', subjectName: 'Aptitude', shortCode: 'AP', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Monday', periodNumber: 3, timeRange: '11.00 - 11.45', subjectCode: '-', subjectName: 'Aptitude', shortCode: 'AP', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Monday', periodNumber: 4, timeRange: '11.45 - 12.30', subjectCode: '-', subjectName: 'Aptitude', shortCode: 'AP', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Monday', periodNumber: 5, timeRange: '01.20 - 02.05', subjectCode: '23ADT501', subjectName: 'Deep Learning Lab', shortCode: 'DL LAB', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'AI Lab 1', isLab: true),
    TimetableSlot(day: 'Monday', periodNumber: 6, timeRange: '02.05 - 02.50', subjectCode: '23ADT501', subjectName: 'Deep Learning Lab', shortCode: 'DL LAB', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'AI Lab 1', isLab: true),
    TimetableSlot(day: 'Monday', periodNumber: 7, timeRange: '03.05 - 03.50', subjectCode: '23ADT501', subjectName: 'Deep Learning Lab', shortCode: 'DL LAB', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'AI Lab 1', isLab: true),
    TimetableSlot(day: 'Monday', periodNumber: 8, timeRange: '03.50 - 04.30', subjectCode: '23ADT501', subjectName: 'Deep Learning Lab', shortCode: 'DL LAB', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'AI Lab 1', isLab: true),

    // Tuesday
    TimetableSlot(day: 'Tuesday', periodNumber: 1, timeRange: '09.15 - 10.00', subjectCode: '23CSE005', subjectName: 'Business Analytics', shortCode: 'BA', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Tuesday', periodNumber: 2, timeRange: '10.00 - 10.45', subjectCode: '23CBT502', subjectName: 'Data and Information Security', shortCode: 'DIS', facultyName: 'Mrs. M. Sivagami', facultyInitials: '[MS]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Tuesday', periodNumber: 3, timeRange: '11.00 - 11.45', subjectCode: '23CSE011', subjectName: 'Cloud Service Management', shortCode: 'CSM', facultyName: 'Dr. K. Manivannan', facultyInitials: '[KM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Tuesday', periodNumber: 4, timeRange: '11.45 - 12.30', subjectCode: '23ADT501', subjectName: 'Deep Learning', shortCode: 'DL', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Tuesday', periodNumber: 5, timeRange: '01.20 - 02.05', subjectCode: '-', subjectName: 'Web Development', shortCode: 'WD', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Tuesday', periodNumber: 6, timeRange: '02.05 - 02.50', subjectCode: '-', subjectName: 'Web Development', shortCode: 'WD', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Tuesday', periodNumber: 7, timeRange: '03.05 - 03.50', subjectCode: '-', subjectName: 'Web Development', shortCode: 'WD', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Tuesday', periodNumber: 8, timeRange: '03.50 - 04.30', subjectCode: '-', subjectName: 'Web Development', shortCode: 'WD', facultyName: 'Mr. C. Kavin Prakash', facultyInitials: '[CK]', roomName: 'MB III A-202'),

    // Wednesday
    TimetableSlot(day: 'Wednesday', periodNumber: 1, timeRange: '09.15 - 10.00', subjectCode: '23CBT502', subjectName: 'Data and Information Security', shortCode: 'DIS', facultyName: 'Mrs. M. Sivagami', facultyInitials: '[MS]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Wednesday', periodNumber: 2, timeRange: '10.00 - 10.45', subjectCode: '23ADT501', subjectName: 'Deep Learning', shortCode: 'DL', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Wednesday', periodNumber: 3, timeRange: '11.00 - 11.45', subjectCode: '-', subjectName: 'Communication Training', shortCode: 'COMM', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Wednesday', periodNumber: 4, timeRange: '11.45 - 12.30', subjectCode: '-', subjectName: 'Communication Training', shortCode: 'COMM', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Wednesday', periodNumber: 5, timeRange: '01.20 - 02.05', subjectCode: '23CSE011', subjectName: 'Cloud Service Management', shortCode: 'CSM', facultyName: 'Dr. K. Manivannan', facultyInitials: '[KM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Wednesday', periodNumber: 6, timeRange: '02.05 - 02.50', subjectCode: '23CST504', subjectName: 'Distributed Computing', shortCode: 'DC', facultyName: 'Ms. S. Muthulakshmi', facultyInitials: '[SM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Wednesday', periodNumber: 7, timeRange: '03.05 - 03.50', subjectCode: '23CSE005', subjectName: 'Business Analytics Lab', shortCode: 'BA LAB', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'AI Lab 2', isLab: true),
    TimetableSlot(day: 'Wednesday', periodNumber: 8, timeRange: '03.50 - 04.30', subjectCode: '23CSE005', subjectName: 'Business Analytics Lab', shortCode: 'BA LAB', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'AI Lab 2', isLab: true),

    // Thursday
    TimetableSlot(day: 'Thursday', periodNumber: 1, timeRange: '09.15 - 10.00', subjectCode: '23ADT501', subjectName: 'Deep Learning', shortCode: 'DL', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Thursday', periodNumber: 2, timeRange: '10.00 - 10.45', subjectCode: '23CST504', subjectName: 'Distributed Computing', shortCode: 'DC', facultyName: 'Ms. S. Muthulakshmi', facultyInitials: '[SM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Thursday', periodNumber: 3, timeRange: '11.00 - 11.45', subjectCode: '23CSE005', subjectName: 'Business Analytics', shortCode: 'BA', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Thursday', periodNumber: 4, timeRange: '11.45 - 12.30', subjectCode: '23ADT502', subjectName: 'Big Data Analytics', shortCode: 'BDA', facultyName: 'Mr. D. Baskar', facultyInitials: '[DB]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Thursday', periodNumber: 5, timeRange: '01.20 - 02.05', subjectCode: '-', subjectName: 'Advanced Data Structure and Algorithm', shortCode: 'ADS', facultyName: 'Ms. S. Muthulakshmi', facultyInitials: '[SM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Thursday', periodNumber: 6, timeRange: '02.05 - 02.50', subjectCode: '-', subjectName: 'Advanced Data Structure and Algorithm', shortCode: 'ADS', facultyName: 'Ms. S. Muthulakshmi', facultyInitials: '[SM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Thursday', periodNumber: 7, timeRange: '03.05 - 03.50', subjectCode: '-', subjectName: 'Advanced Data Structure and Algorithm', shortCode: 'ADS', facultyName: 'Mr. A. Bharathidhasan', facultyInitials: '[AB]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Thursday', periodNumber: 8, timeRange: '03.50 - 04.30', subjectCode: '-', subjectName: 'Advanced Data Structure and Algorithm', shortCode: 'ADS', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'MB III A-202'),

    // Friday
    TimetableSlot(day: 'Friday', periodNumber: 1, timeRange: '09.15 - 10.00', subjectCode: '-', subjectName: 'Communication Training', shortCode: 'COMM', facultyName: 'Mr. D. Baskar', facultyInitials: '[DB]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Friday', periodNumber: 2, timeRange: '10.00 - 10.45', subjectCode: '-', subjectName: 'Communication Training', shortCode: 'COMM', facultyName: 'Mr. D. Baskar', facultyInitials: '[DB]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Friday', periodNumber: 3, timeRange: '11.00 - 11.45', subjectCode: '23ADT501', subjectName: 'Deep Learning', shortCode: 'DL', facultyName: 'Dr. R. Murugesan', facultyInitials: '[RM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Friday', periodNumber: 4, timeRange: '11.45 - 12.30', subjectCode: '23CST504', subjectName: 'Distributed Computing', shortCode: 'DC', facultyName: 'Ms. S. Muthulakshmi', facultyInitials: '[SM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Friday', periodNumber: 5, timeRange: '01.20 - 02.05', subjectCode: '23ADT502', subjectName: 'Big Data Analytics Lab', shortCode: 'BDA LAB', facultyName: 'Mr. D. Baskar', facultyInitials: '[DB]', roomName: 'AI Lab 1', isLab: true),
    TimetableSlot(day: 'Friday', periodNumber: 6, timeRange: '02.05 - 02.50', subjectCode: '23ADT502', subjectName: 'Big Data Analytics Lab', shortCode: 'BDA LAB', facultyName: 'Mr. D. Baskar', facultyInitials: '[DB]', roomName: 'AI Lab 1', isLab: true),
    TimetableSlot(day: 'Friday', periodNumber: 7, timeRange: '03.05 - 03.50', subjectCode: '23CSE005', subjectName: 'Business Analytics', shortCode: 'BA', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Friday', periodNumber: 8, timeRange: '03.50 - 04.30', subjectCode: '23CBT502', subjectName: 'Data and Information Security', shortCode: 'DIS', facultyName: 'Mrs. M. Sivagami', facultyInitials: '[MS]', roomName: 'MB III A-202'),

    // Saturday
    TimetableSlot(day: 'Saturday', periodNumber: 1, timeRange: '09.15 - 10.00', subjectCode: '23CBT502', subjectName: 'Data and Information Security', shortCode: 'DIS', facultyName: 'Mrs. M. Sivagami', facultyInitials: '[MS]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Saturday', periodNumber: 2, timeRange: '10.00 - 10.45', subjectCode: '23ADT502', subjectName: 'Big Data Analytics', shortCode: 'BDA', facultyName: 'Mr. D. Baskar', facultyInitials: '[DB]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Saturday', periodNumber: 3, timeRange: '11.00 - 11.45', subjectCode: '23CSE011', subjectName: 'Cloud Service Management', shortCode: 'CSM', facultyName: 'Dr. K. Manivannan', facultyInitials: '[KM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Saturday', periodNumber: 4, timeRange: '11.45 - 12.30', subjectCode: '23CST504', subjectName: 'Distributed Computing', shortCode: 'DC', facultyName: 'Ms. S. Muthulakshmi', facultyInitials: '[SM]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Saturday', periodNumber: 5, timeRange: '01.20 - 02.05', subjectCode: '23CSE011', subjectName: 'Cloud Service Management Lab', shortCode: 'CSM LAB', facultyName: 'Mr. A. Bharathidhasan', facultyInitials: '[AB]', roomName: 'Cloud Lab', isLab: true),
    TimetableSlot(day: 'Saturday', periodNumber: 6, timeRange: '02.05 - 02.50', subjectCode: '23CSE011', subjectName: 'Cloud Service Management Lab', shortCode: 'CSM LAB', facultyName: 'Mr. A. Bharathidhasan', facultyInitials: '[AB]', roomName: 'Cloud Lab', isLab: true),
    TimetableSlot(day: 'Saturday', periodNumber: 7, timeRange: '03.05 - 03.50', subjectCode: '23CSE005', subjectName: 'Business Analytics', shortCode: 'BA', facultyName: 'Mr. M. Ramesh', facultyInitials: '[MR]', roomName: 'MB III A-202'),
    TimetableSlot(day: 'Saturday', periodNumber: 8, timeRange: '03.50 - 04.30', subjectCode: '23ADT502', subjectName: 'Big Data Analytics', shortCode: 'BDA', facultyName: 'Mr. D. Baskar', facultyInitials: '[DB]', roomName: 'MB III A-202'),
  ];

  static TimetableSlot getCurrentOrNextSlot(String dayName, {int defaultPeriod = 2}) {
    final daySlots = scheduleIII_B.where((s) => s.day.toLowerCase() == dayName.toLowerCase()).toList();
    if (daySlots.isEmpty) {
      return scheduleIII_B.first;
    }
    if (defaultPeriod >= 1 && defaultPeriod <= daySlots.length) {
      return daySlots[defaultPeriod - 1];
    }
    return daySlots.first;
  }
}

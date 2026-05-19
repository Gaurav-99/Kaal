class UserData {
  final DateTime? dob;
  final int expectedLifespanYears;
  final String gender;
  final double height;
  final double weight;
  final double sleepHours;
  final double stressLevel;
  final String activityLevel;

  UserData({
    this.dob,
    this.expectedLifespanYears = 90,
    this.gender = 'Male',
    this.height = 175.0,
    this.weight = 70.0,
    this.sleepHours = 7.0,
    this.stressLevel = 5.0,
    this.activityLevel = 'Moderate',
  });

  UserData copyWith({
    DateTime? dob,
    int? expectedLifespanYears,
    String? gender,
    double? height,
    double? weight,
    double? sleepHours,
    double? stressLevel,
    String? activityLevel,
  }) {
    return UserData(
      dob: dob ?? this.dob,
      expectedLifespanYears: expectedLifespanYears ?? this.expectedLifespanYears,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      sleepHours: sleepHours ?? this.sleepHours,
      stressLevel: stressLevel ?? this.stressLevel,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }
}

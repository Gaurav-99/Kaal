import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_data.dart';

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier() : super(UserData(dob: DateTime(2000, 1, 1))); // Default dob for guest

  void updateUserData(UserData data) {
    // Basic logic to modify expected lifespan based on health factors.
    // Start with a baseline of 80 years.
    double expectedLifespan = 80.0;
    
    // Gender adjustment (statistically females live slightly longer)
    if (data.gender == 'Female') expectedLifespan += 4;
    
    // Sleep adjustment (7-8 hours is optimal)
    if (data.sleepHours >= 7 && data.sleepHours <= 8.5) {
      expectedLifespan += 2;
    } else if (data.sleepHours < 5) {
      expectedLifespan -= 3;
    }
    
    // Stress adjustment (lower is better)
    if (data.stressLevel > 7) {
      expectedLifespan -= 4;
    } else if (data.stressLevel < 4) {
      expectedLifespan += 2;
    }
    
    // Activity adjustment
    if (data.activityLevel == 'Active' || data.activityLevel == 'Very Active') {
      expectedLifespan += 4;
    } else if (data.activityLevel == 'Sedentary') {
      expectedLifespan -= 3;
    }

    // Ensure it's somewhat realistic
    expectedLifespan = expectedLifespan.clamp(60.0, 100.0);

    state = data.copyWith(expectedLifespanYears: expectedLifespan.round());
  }
}

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserData>((ref) {
  return UserDataNotifier();
});

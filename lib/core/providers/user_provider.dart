import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime? dob;
  final int lifeExpectancyYears;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.dob,
    required this.lifeExpectancyYears,
  });

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
    id: m['id'] as String? ?? '',
    name: m['name'] as String? ?? '',
    email: m['email'] as String? ?? '',
    dob: m['dob'] != null ? DateTime.tryParse(m['dob'] as String) : null,
    lifeExpectancyYears: m['lifeExpectancyYears'] as int? ?? 90,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'dob': dob?.toIso8601String(),
    'lifeExpectancyYears': lifeExpectancyYears,
  };
}

final userProvider = FutureProvider<UserModel>((ref) async {
  // Try SharedPreferences first (local cached profile)
  final prefs = await SharedPreferences.getInstance();
  final json = prefs.getString('user_profile');
  if (json != null) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return UserModel.fromMap(map);
  }

  // Fallback mock data if no profile present. In production, wire Supabase/auth.
  return UserModel(
    id: 'anon',
    name: 'Seeker',
    email: 'you@example.com',
    dob: DateTime.now().subtract(const Duration(days: 365 * 25)),
    lifeExpectancyYears: 90,
  );
});

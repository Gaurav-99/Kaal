import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import 'dart:ui';

class LifeDetailsFormScreen extends StatefulWidget {
  const LifeDetailsFormScreen({super.key});

  @override
  State<LifeDetailsFormScreen> createState() => _LifeDetailsFormScreenState();
}

class _LifeDetailsFormScreenState extends State<LifeDetailsFormScreen> {
  DateTime? _selectedDOB;
  String _selectedGender = 'Male';
  double _sleepHours = 7.0;
  double _stressLevel = 5.0;
  String _activityLevel = 'Moderate';

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  final List<String> _genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];
  final List<String> _activityLevels = [
    'Sedentary',
    'Light',
    'Moderate',
    'Active',
    'Very Active',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: AppColors.background,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDOB) {
      setState(() {
        _selectedDOB = picked;
      });
    }
  }

  void _submitForm() {
    // Here we would typically save these details to Supabase/Riverpod state
    // and calculate the exact life expectancy based on algorithms.

    // Proceed to Dashboard
    context.go('/dashboard');
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Design Your Life',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/auth'),
        ),
      ),
      body: Stack(
        children: [
          // Subtle glow
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withAlpha((0.1 * 255).round()),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To calculate your time,\nwe need to know you.',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your data helps us project a realistic life expectancy model based on global health statistics.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 40),

                  // Date of Birth
                  _buildSectionTitle('Date of Birth'),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.surfaceLight),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDOB == null
                                ? 'Select your birthday'
                                : '${_selectedDOB!.day}/${_selectedDOB!.month}/${_selectedDOB!.year}',
                            style: TextStyle(
                              color: _selectedDOB == null
                                  ? AppColors.textMuted
                                  : AppColors.textPrimary,
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Gender
                  _buildSectionTitle('Biological Sex / Gender'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.surfaceLight),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedGender,
                        isExpanded: true,
                        dropdownColor: AppColors.surfaceLight,
                        items: _genders.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Physical Metrics
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Height (cm)'),
                            _buildTextField(
                              controller: _heightController,
                              hint: 'e.g. 175',
                              isNumber: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Weight (kg)'),
                            _buildTextField(
                              controller: _weightController,
                              hint: 'e.g. 70',
                              isNumber: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sleep
                  _buildSectionTitle(
                    'Average Sleep (Hours: ${_sleepHours.toInt()})',
                  ),
                  Slider(
                    value: _sleepHours,
                    min: 4,
                    max: 12,
                    divisions: 8,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.surfaceLight,
                    onChanged: (value) {
                      setState(() {
                        _sleepHours = value;
                      });
                    },
                  ),

                  // Stress
                  const SizedBox(height: 16),
                  _buildSectionTitle(
                    'Daily Stress Level (1-10: ${_stressLevel.toInt()})',
                  ),
                  Slider(
                    value: _stressLevel,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    activeColor: AppColors.error.withAlpha((0.8 * 255).round()),
                    inactiveColor: AppColors.surfaceLight,
                    onChanged: (value) {
                      setState(() {
                        _stressLevel = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),
                  // Activity Level
                  _buildSectionTitle('Activity Level'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.surfaceLight),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _activityLevel,
                        isExpanded: true,
                        dropdownColor: AppColors.surfaceLight,
                        items: _activityLevels.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _activityLevel = newValue!;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background,
                    ),
                    child: const Text('Calculate My Life Expectancy'),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.surfaceLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.surfaceLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primary.withAlpha((0.5 * 255).round()),
          ),
        ),
      ),
    );
  }
}

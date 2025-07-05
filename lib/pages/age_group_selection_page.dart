import 'package:flutter/material.dart';
import 'home_page.dart';
import '../components/gradient_background.dart';
import '../components/age_group_card.dart';
import '../components/gradient_button.dart';
import '../constants/app_constants.dart';

class AgeGroupSelectionPage extends StatefulWidget {
  final String userId;

  const AgeGroupSelectionPage({super.key, required this.userId});

  @override
  State<AgeGroupSelectionPage> createState() => _AgeGroupSelectionPageState();
}

class _AgeGroupSelectionPageState extends State<AgeGroupSelectionPage> {
  String? _selectedAgeGroup;

  final List<String> _ageGroups = [
    '18-20',
    '21-25',
    '26-30',
    '31-35',
    '36-40',
    '41-45',
    '46-50',
    '51-55',
    '56-60',
    '60+',
  ];

  void _submitAgeGroup() {
    if (_selectedAgeGroup != null) {
      // Navigate directly to HomePage without popup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  HomePage(userId: widget.userId, ageGroup: _selectedAgeGroup!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Please select an age group',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLarge),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Header Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingLarge),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusLarge,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Profile Icon
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome, ${widget.userId}!',
                        style: AppTextStyles.welcomeTitle.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please select your age group to continue',
                        style: AppTextStyles.subtitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Age Groups Selection
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadiusLarge,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.paddingLarge),
                      child: Column(
                        children: [
                          const Text(
                            'Age Groups',
                            style: AppTextStyles.cardTitle,
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 2.5,
                                  ),
                              itemCount: _ageGroups.length,
                              itemBuilder: (context, index) {
                                final ageGroup = _ageGroups[index];
                                final isSelected =
                                    _selectedAgeGroup == ageGroup;
                                return AgeGroupCard(
                                  ageGroup: ageGroup,
                                  isSelected: isSelected,
                                  onTap: () {
                                    setState(() {
                                      _selectedAgeGroup = ageGroup;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Continue Button
                GradientButton(
                  text: 'Continue',
                  onPressed: _submitAgeGroup,
                  borderRadius: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

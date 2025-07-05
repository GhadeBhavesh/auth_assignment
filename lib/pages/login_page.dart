import 'package:flutter/material.dart';
import 'age_group_selection_page.dart';
import '../components/gradient_background.dart';
import '../components/custom_text_form_field.dart';
import '../components/gradient_button.dart';
import '../constants/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  String _errorMessage = '';

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _errorMessage = '';
    });

    if (_formKey.currentState!.validate()) {
      // Simulate successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  AgeGroupSelectionPage(userId: _userIdController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= 768;
    final isDesktop = screenSize.width >= 1024;

    // Responsive padding
    double horizontalPadding =
        isDesktop ? 40 : (isTablet ? 32 : AppSizes.paddingLarge);
    double verticalPadding =
        isDesktop ? 40 : (isTablet ? 32 : AppSizes.paddingLarge);

    // Responsive card width
    double cardWidth = isDesktop ? 400 : (isTablet ? 500 : double.infinity);

    // Responsive logo size
    double logoSize = isDesktop ? 100 : (isTablet ? 140 : 170);

    // Responsive spacing
    double topSpacing = isDesktop ? 80 : (isTablet ? 70 : 60);
    double sectionSpacing = isDesktop ? 32 : (isTablet ? 36 : 40);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 1200 : double.infinity,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: topSpacing),
                      // Logo/Icon Section
                      Container(
                        height: logoSize,
                        width: logoSize,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(logoSize / 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logo.png', // Replace with your logo path
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      // Welcome Text
                      Text(
                        'Welcome Back!',
                        style: AppTextStyles.welcomeTitle.copyWith(
                          fontSize: isDesktop ? 36 : (isTablet ? 34 : 32),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue',
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: isDesktop ? 18 : (isTablet ? 17 : 16),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: sectionSpacing),
                      // Login Form Card
                      Container(
                        width: cardWidth,
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
                          padding: EdgeInsets.all(
                            isDesktop
                                ? 32
                                : (isTablet ? 28 : AppSizes.paddingLarge),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // User ID Field
                                CustomTextFormField(
                                  controller: _userIdController,
                                  labelText: 'User ID / Email',
                                  prefixIcon: Icons.email_outlined,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your User ID or Email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: isDesktop ? 24 : 20),
                                // Password Field
                                CustomTextFormField(
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: _isObscure,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters long';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: isDesktop ? 28 : 24),
                                // Error Message
                                if (_errorMessage.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.borderRadiusSmall,
                                      ),
                                      border: Border.all(
                                        color: Colors.red.shade200,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red.shade600,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _errorMessage,
                                            style: TextStyle(
                                              color: Colors.red.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                // Login Button
                                GradientButton(
                                  text: 'Login',
                                  onPressed: _login,
                                ),
                                SizedBox(height: isDesktop ? 24 : 20),
                                // Forgot Password
                                TextButton(
                                  onPressed: () {
                                    // Add forgot password functionality
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: isDesktop ? 16 : 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: isDesktop ? 16 : 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add sign up functionality
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: isDesktop ? 16 : 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

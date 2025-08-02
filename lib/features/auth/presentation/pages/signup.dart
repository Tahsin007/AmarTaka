import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/common/app_text_field.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/core/theme/app_text_styles.dart';
import 'package:amar_taka/features/auth/presentation/widgets/social_login_btn.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _handleSignUp() {
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms & policy'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Handle sign up logic
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sign up logic goes here')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: AppPallete.backgroundColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Title
                  const Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Name Field
                  AppTextField(
                    label: 'Name',
                    placeholder: 'ex: jon smith',
                    controller: _nameController,
                    validator: _validateName,
                  ),

                  const SizedBox(height: 20),

                  // Email Field
                  AppTextField(
                    label: 'Email',
                    placeholder: 'ex: jon.smith@email.com',
                    controller: _emailController,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  // Password Field
                  AppTextField(
                    label: 'Password',
                    placeholder: '••••••••••',
                    isPassword: true,
                    controller: _passwordController,
                    validator: _validatePassword,
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password Field
                  AppTextField(
                    label: 'Confirm password',
                    placeholder: '••••••••••',
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: _validateConfirmPassword,
                  ),

                  const SizedBox(height: 24),

                  // Terms & Policy Checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _isTermsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _isTermsAccepted = value ?? false;
                            });
                          },
                          activeColor: AppPallete.primaryColor,
                          side: BorderSide(color: Colors.grey[400]!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          children: [
                            const Text(
                              'I understood the ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Handle terms & policy tap
                                print('Terms & policy tapped');
                              },
                              child: const Text(
                                'terms & policy.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Sign Up Button Placeholder
                  AppButton(
                    btnText: "SIGN UP",
                    onBtnPressed: () => _handleSignUp(),
                  ),

                  const SizedBox(height: 24),

                  // Or sign up with
                  Center(
                    child: Text(
                      'or sign up with',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Social Login Buttons
                  const SocialLoginButtons(),
                  const SizedBox(height: 20),
                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account? ',
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppPallete.darkGray,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push("/signin");
                        },
                        child: Text(
                          'SIGN IN',
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppPallete.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

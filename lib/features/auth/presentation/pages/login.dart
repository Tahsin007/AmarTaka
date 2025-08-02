import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/common/app_text_field.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/features/auth/presentation/pages/signup.dart';
import 'package:amar_taka/features/auth/presentation/widgets/social_login_btn.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Import your custom widgets
// import 'custom_input_field.dart';
// import 'social_login_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      // Handle sign in logic
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sign in logic goes here')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: Image.asset("assets/images/main-logo.png"),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 60),
              
                  // Title
                  const Text(
                    'Sign in your account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
              
                  const SizedBox(height: 40),
              
                  // Email Field
                  AppTextField(
                    label: 'Email',
                    placeholder: 'ex: jon.smith@email.com',
                    controller: _emailController,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
              
                  const SizedBox(height: 24),
              
                  // Password Field
                  AppTextField(
                    label: 'Password',
                    placeholder: '••••••••••',
                    isPassword: true,
                    controller: _passwordController,
                    validator: _validatePassword,
                  ),
              
                  const SizedBox(height: 40),
              
                  // Sign In Button Placeholder
                  AppButton(
                    btnText: "SIGN IN",
                    onBtnPressed: () => _handleSignIn(),
                  ),
              
                  const SizedBox(height: 32),
              
                  // Or sign in with
                  Center(
                    child: Text(
                      'or sign in with',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ),
              
                  const SizedBox(height: 24),
              
                  // Social Login Buttons
                  const SocialLoginButtons(),     
                  const SizedBox(height: 16,),         
                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to sign up screen
                          context.push("/signup");
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: AppPallete.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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

// Note: You'll need to import the SignUpScreen in your actual implementation

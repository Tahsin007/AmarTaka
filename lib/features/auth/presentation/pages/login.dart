import 'package:amar_taka/core/common/app_primary_button.dart';
import 'package:amar_taka/core/common/app_text_field.dart';
import 'package:amar_taka/core/theme/app_pallete.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_event.dart';
import 'package:amar_taka/features/auth/presentation/bloc/auth_state.dart';
import 'package:amar_taka/features/auth/presentation/pages/signup.dart';
import 'package:amar_taka/features/auth/presentation/widgets/social_login_btn.dart';
import 'package:amar_taka/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or User Name is required';
    }
    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    //   return 'Please enter a valid email';
    // }
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
      context.read<AuthBloc>().add(
        LoginEvent(
          userName: _userNameController.text,
          password: _passwordController.text,
        ),
      );
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
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    context.go('/home');
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
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
                      const Text(
                        'Sign in your account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 40),
                      AppTextField(
                        label: 'User Name',
                        placeholder: 'jon.smith',
                        controller: _userNameController,
                        validator: _validateUserName,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        label: 'Password',
                        placeholder: '••••••••••',
                        isPassword: true,
                        controller: _passwordController,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 40),
                      if (state is AuthLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        AppButton(
                          btnText: "SIGN IN",
                          onBtnPressed: () => _handleSignIn(),
                        ),
                      const SizedBox(height: 32),
                      Center(
                        child: Text(
                          'or sign in with',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SocialLoginButtons(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Note: You'll need to import the SignUpScreen in your actual implementation

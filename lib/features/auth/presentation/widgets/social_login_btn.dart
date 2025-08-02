import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SocialButton(
          icon: Icons.g_mobiledata,
          onTap: () {
            // Google sign in logic
            print('Google sign in tapped');
          },
        ),
        _SocialButton(
          icon: Icons.facebook,
          color: Colors.blue,
          onTap: () {
            // Facebook sign in logic
            print('Facebook sign in tapped');
          },
        ),
        _SocialButton(
          icon: Icons.alternate_email,
          color: Colors.lightBlue,
          onTap: () {
            // Twitter sign in logic
            print('Twitter sign in tapped');
          },
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const _SocialButton({
    Key? key,
    required this.icon,
    this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Icon(
          icon,
          size: 24,
          color: color ?? Colors.grey[600],
        ),
      ),
    );
  }
}
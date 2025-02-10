import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:food_app/pages/root.dart';
import 'package:food_app/theme/color.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LoginSignup extends StatelessWidget {
  static const routeName = '/auth';

  const LoginSignup({super.key});

  Duration get loginTime => const Duration(milliseconds: 1000);

  Future<String?> _loginUser(LoginData data) async {
    // Replace with actual login API call
    await Future.delayed(loginTime);
    return null; // null means success
  }

  Future<String?> _signupUser(SignupData data) async {
    // Replace with actual signup API call
    await Future.delayed(loginTime);
    return null; // null means success
  }

  Future<String?> _recoverPassword(String name) async {
    // Replace with actual password recovery
    await Future.delayed(loginTime);
    return null; // null means success
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      // Visual customization
      logo: 'assets/images/logo.png',
      logoTag: 'tastyDelightLogo',
      titleTag: 'tastyDelightTitle',
      messages: LoginMessages(
        userHint: 'Email',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm Password',
        loginButton: 'LOG IN',
        signupButton: 'SIGN UP',
        forgotPasswordButton: 'Forgot Password?',
        recoverPasswordButton: 'RECOVER',
        recoverPasswordIntro: 'Don\'t worry! Enter your email to recover your password.',
        recoverPasswordDescription: 'We will send you an email with a link to reset your password.',
        recoverCodePasswordDescription: 'Enter the code sent to your email to reset your password.',
      ),

      // Functional customization
      loginAfterSignUp: false, // Show login screen after signup
      hideForgotPasswordButton: false, // Show "Forgot Password?" button

      // Theme customization
      theme: LoginTheme(
        primaryColor: primary, // Primary color
        accentColor: Colors.white, // Accent color
        errorColor: Colors.red, // Error color
        titleStyle: TextStyle(
          color: Colors.deepOrange,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        bodyStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
        textFieldStyle: TextStyle(
          color: Colors.black87,
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // Authentication logic
      onLogin: (loginData) {
        // Set user data in provider
        Provider.of<UserProvider>(context, listen: false).setUser(
          loginData.name, // No need for null-coalescing operator
          'User', // Default last name
        );
        return _loginUser(loginData);
      },
      onSignup: (signupData) {
        // Ensure non-null values are passed
        final firstName = signupData.name ?? 'User'; // Use a default value if null
        final lastName = signupData.additionalSignupData?['lastName'] ?? '';

        // Set user data in provider
        Provider.of<UserProvider>(context, listen: false).setUser(
          firstName,
          lastName,
        );
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        // Navigate to RootApp after successful login/signup
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RootApp()),
        );
      },
      onRecoverPassword: _recoverPassword,

      // Additional signup fields
      additionalSignupFields: [
        UserFormField(
          keyName: 'lastName',
          displayName: 'Last Name',
          userType: LoginUserType.name,
        ),
      ],

      // Footer text
      footer: 'By continuing, you agree to our Terms and Conditions.',
    );
  }
}
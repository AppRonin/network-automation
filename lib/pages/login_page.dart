import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_automation/services/auth_service.dart';
import 'package:network_automation/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  Future<void> handleLogin() async {
    setState(() => loading = true);

    final success = await AuthService.login(
      username: userController.text,
      password: passwordController.text,
    );

    setState(() => loading = false);

    if (success) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 320,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color with opacity
              offset: Offset(0, 4), // X, Y offset
              blurRadius: 6, // Blur radius
              spreadRadius: 0, // Spread radius
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 24),
            Text(
              "Login",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24),
            CustomInput(
              label: "Usuario",
              placeholder: "Digite seu usuário",
              isPassword: false,
              controller: userController,
            ),
            SizedBox(height: 16),
            CustomInput(
              label: "Password",
              placeholder: "*********",
              isPassword: true,
              controller: passwordController,
            ),
            SizedBox(height: 24),

            // Login Button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: loading ? null : handleLogin,
                child: Container(
                  width: double.infinity,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Entrar",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

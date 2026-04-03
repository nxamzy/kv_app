import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kv/routes/platform_routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showError("Iltimos, barcha maydonlarni to'ldiring!");
      return;
    }

    if (password.length < 6) {
      _showError("Parol kamida 6 ta belgidan iborat bo'lishi kerak!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. FIREBASEDA ACCOUNT YARATISH
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // 2. MUHIM: Foydalanuvchi ismini Firebase Auth profiliga ham saqlaymiz
      // Bu isming null chiqib qolishini 100% oldini oladi
      await userCredential.user!.updateDisplayName(name);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': name,
            'email': email,
            'uid': userCredential.user!.uid,
            'createdAt': FieldValue.serverTimestamp(),
          });

      if (mounted) {
        context.go(PlatformRoutes.welcomePage.route);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showError("Siz oldin ro'yxatdan o'tgansiz! Kirishga o'ting.");
      } else {
        _showError("Xatolik: ${e.message}");
      }
    } catch (e) {
      _showError("Baza bilan bog'lanishda xato: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 200),
                _buildInputLabel("Ismingiz"),
                // ISM INPUT
                _buildTextField(
                  _nameController,
                  "Misol: Axmadjon",
                  Icons.person_outline,
                ),
                const SizedBox(height: 20),
                _buildInputLabel("Email manzilingiz"),
                // EMAIL INPUT
                _buildTextField(
                  _emailController,
                  "exampil@gmail.com",
                  Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                _buildInputLabel("Yangi parolingiz"),
                // PAROL INPUT
                _buildTextField(
                  _passwordController,
                  "••••••••",
                  Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 40),

                // SIGN UP TUGMASI
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Tizimga kirish",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Akkauntingiz bormi? Kirish",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Yordamchi dizayn widgetlari
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}

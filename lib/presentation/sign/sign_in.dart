import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kv/routes/platform_routes.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // KIRISH FUNKSIYASI
  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email va parolni kiriting!")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Firebase orqali kirish
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Muvaffaqiyatli bo'lsa, Home Page'ga o'tish
      if (mounted) {
        context.push(PlatformRoutes.welcomePage.route);
      }
    } on FirebaseAuthException catch (e) {
      // Xatoliklarni foydalanuvchiga tushunarli qilib ko'rsatish
      String message = "Xatolik yuz berdi";
      if (e.code == 'user-not-found')
        message = "Bunday foydalanuvchi topilmadi.";
      if (e.code == 'wrong-password') message = "Parol noto'g'ri.";

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 200),

                // EMAIL INPUT
                _buildInputLabel("Email manzilingiz"),
                _buildTextField(
                  _emailController,
                  "example@mail.com",
                  Icons.alternate_email,
                ),
                const SizedBox(height: 25),

                // PAROL INPUT
                _buildInputLabel("Parolingiz"),
                _buildTextField(
                  _passwordController,
                  "••••••••",
                  Icons.lock_open_rounded,
                  isPassword: true,
                ),

                // PAROLNI UNUTDINGIZMI?
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Parolni unutdingizmi?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // KIRISH TUGMASI
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Tizimga kirish",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    // Chap tarafdagi chiziq
                    Expanded(
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),
                    // O'rtadagi matn
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "yoki",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),

                    // O'ng tarafdagi chiziq
                    Expanded(
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),
                  ],
                ),
                // KIRISH TUGMASI
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () => _isLoading ? null : _signIn,

                    style: OutlinedButton.styleFrom(
                      // CHEGARA RANGI QORA QILINDI
                      side: const BorderSide(color: Colors.black, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google logotipi (agar assetsda bo'lsa Image.asset ishlating)
                        // const Icon(
                        //   Icons.g_mobiledata,
                        //   size: 40,
                        //   color: Colors.blue,
                        // ),
                        const SizedBox(width: 10),
                        _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Google orqali kirish",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    // Bu tugma bosilganda telefon raqam kiritish sahifasiga o'tadi
                    onPressed: _isLoading
                        ? null
                        : () => context.push(
                            PlatformRoutes.phonePage.route,
                          ), // Bu yerda o'z routingizni yozing

                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone_android_rounded,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "SMS orqali kirish",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // RO'YXATDAN O'TMAGANMI?
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Akkauntingiz yo'qmi?",
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    context.push(PlatformRoutes.signup.route);
                  },
                  child: const Text(
                    "Ro'yxatdan o'tish",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
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
    String hint,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.black54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 15,
          ),
        ),
      ),
    );
  }
}

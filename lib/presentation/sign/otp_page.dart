import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kv/routes/platform_routes.dart';

class OtpPage extends StatefulWidget {
  final String verId;
  final String phone;

  const OtpPage({super.key, required this.verId, required this.phone});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    if (_otpController.text.length < 6) return;

    setState(() => _isLoading = true);

    try {
      // 1. Credential yaratish
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verId,
        smsCode: _otpController.text.trim(),
      );

      // 2. Firebase-ga kirish
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // 3. Yangi foydalanuvchi bo'lsa profil to'ldirishga, bo'lmasa Home-ga
      if (mounted) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          // Bu yerda yangi foydalanuvchi uchun alohida route bo'lsa o'shanga
          context.go(PlatformRoutes.welcomePage.route);
        } else {
          context.go(PlatformRoutes.welcomePage.route);
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kod noto'g'ri kiritildi!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              "Kodni kiriting",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.phone} raqamiga yuborilgan 6 xonali kodni kiriting.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Kod kiritish uchun oddiy TextField (yoki Pinput ishlatsa bo'ladi)
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
              ),
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Tasdiqlash",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

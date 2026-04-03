import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kv/routes/platform_routes.dart';

class WelcomePage extends StatelessWidget {
  final bool isReturning;
  const WelcomePage({super.key, this.isReturning = false});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String name = user?.displayName ?? "Jamshid";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Text(
              isReturning
                  ? "Welcome back! $name, \n Sizni yana korganimizdan xursandmiz!"
                  : "Welcome $name!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            SizedBox(height: 50),

            _buildActionButton(
              icon: Icons.group_add,
              text: "Yangi guruh yaratish",
              color: Colors.black,
              onTap: () {
                context.push(PlatformRoutes.addGroupPage.route, extra: "Uy");
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              icon: Icons.airplanemode_active,
              text: "Sayoxat guruhi yaratish",
              color: Colors.black,
              onTap: () {
                context.push(
                  PlatformRoutes.addGroupPage.route,
                  extra: "Sayohat",
                );
              },
            ),
            const Spacer(),
            // Skip Setup tugmasi
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () => context.push(PlatformRoutes.mainPage.route),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Asosiy sahifaga o'tish",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Tugmalar uchun yordamchi vidjet
  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

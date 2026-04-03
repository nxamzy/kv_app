import 'package:go_router/go_router.dart';

import 'package:my_kv/presentation/add/addGroup.dart';
import 'package:my_kv/presentation/pages/friends_pages/widgets/add_friends_screen.dart';
import 'package:my_kv/presentation/pages/friends_pages/widgets/add_friends_widget.dart';
import 'package:my_kv/presentation/pages/home_page.dart';
import 'package:my_kv/presentation/pages/main_pages/main_page.dart';
import 'package:my_kv/presentation/pages/profile_pages/account_settings_page.dart';
import 'package:my_kv/presentation/pages/profile_pages/widgets_profile_page.dart/profile_header.dart';
import 'package:my_kv/presentation/sign/otp_page.dart';
import 'package:my_kv/presentation/sign/phone_input_page.dart';
import 'package:my_kv/presentation/sign/sign_in.dart';
import 'package:my_kv/presentation/sign/sign_up.dart';
import 'package:my_kv/presentation/sign/welcome_page.dart';
import 'package:my_kv/routes/platform_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [
      GoRoute(path: '/', builder: (context, state) => const SignInPage()),
      GoRoute(
        path: PlatformRoutes.mainPage.route,
        builder: (context, state) => const MainPage(),
      ),

      GoRoute(
        path: PlatformRoutes.signup.route,
        builder: (context, state) => const SignUpPage(),
      ),

      GoRoute(
        path: PlatformRoutes.welcomePage.route,
        builder: (context, state) => const WelcomePage(),
      ),

      GoRoute(
        path: '/add_friend/:id',
        builder: (context, state) {
          final String friendId = state.pathParameters['id']!;
          return AddFriendScreen(friendId: friendId);
        },
      ),
      GoRoute(
        path: PlatformRoutes.qrPage.route,
        builder: (context, state) => const QrInvitePage(),
      ),
      GoRoute(
        path: PlatformRoutes.homepage.route,
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: PlatformRoutes.headerProfilePage.route,
        builder: (context, state) => const ProfileHeader(),
      ),
      GoRoute(
        path: PlatformRoutes.otpPage.route,
        builder: (context, state) {
          final verId = state.uri.queryParameters['verId'] ?? "";
          final phone = state.uri.queryParameters['phone'] ?? "Noma'lum";
          return OtpPage(verId: verId, phone: phone);
        },
      ),
      GoRoute(
        path: PlatformRoutes.phonePage.route,
        builder: (context, state) => PhoneInputPage(),
      ),

      GoRoute(
        path: PlatformRoutes.accauntSettingsPage.route,
        builder: (context, state) => AccountSettings(),
      ),
      GoRoute(
        path: PlatformRoutes.addGroupPage.route,
        builder: (context, state) {
          final type = state.extra as String? ?? "Uy";
          return CreateGroupPage(initialType: type);
        },
      ),
    ],
  );
}

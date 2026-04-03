class RouteInfo {
  final String name;
  final String route;

  const RouteInfo({required this.name, required this.route});
}

class PlatformRoutes {
  static const signin = RouteInfo(name: 'signin', route: '/');
  static const headerProfilePage = RouteInfo(
    name: 'headerProfile',
    route: '/headerProfile',
  );
  static const signup = RouteInfo(name: 'sign', route: '/sign');
  static const homepage = RouteInfo(name: 'home', route: '/home');
  static const detailPage = RouteInfo(name: 'detail', route: '/detail');
  static const dashboardPage = RouteInfo(
    name: 'dashboard',
    route: '/dashboard',
  );
  static const mainPage = RouteInfo(name: 'main', route: '/main');
  static const accauntSettingsPage = RouteInfo(
    name: 'accauntSettings',
    route: '/accauntSettings',
  );
  static const settingsPage = RouteInfo(name: 'settings', route: '/settings');
  static const addGroupPage = RouteInfo(name: 'addGroup', route: '/addGroup');
  static const welcomePage = RouteInfo(
    name: 'welcomePage',
    route: '/welcomePage',
  );
  static const phonePage = RouteInfo(name: 'phone', route: '/phone');
  static const otpPage = RouteInfo(name: 'otp', route: '/otp');
  static const qrPage = RouteInfo(name: 'qr', route: '/qr');
}

import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  bool isSwitch = false;

  Future<bool> getBiometric() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isSwitch') ?? false;
  }

  Future saveBiometric(bool isSwitch) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isSwitch', this.isSwitch);
  }

  Future removeBiometric() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('isSwitch');
  }

  final List<MenuEntities> menu = [
    const MenuEntities(
      imageMenu: 'assets/profile/account.png',
      title: 'My Account',
      description: 'Make changes to your account',
    ),
    const MenuEntities(
      imageMenu: 'assets/profile/Lock.png',
      title: 'Face ID / Touch ID',
      description: 'Manage your device security',
    ),
    const MenuEntities(
      imageMenu: 'assets/profile/fingerprint.png',
      title: 'Biometric Fingerprint',
      description: 'Activated ur fingerprint',
    ),
    const MenuEntities(
      imageMenu: 'assets/profile/Shield.png',
      title: 'Two-Factor Authentication',
      description: 'Further secure your account',
    ),
    const MenuEntities(
      imageMenu: 'assets/profile/history.png',
      title: 'History Test',
      description: 'Check your test history',
    ),
    const MenuEntities(
      imageMenu: 'assets/profile/Logout.png',
      title: 'Log out',
      description: 'Log out of your account',
    ),
  ];

  final List<MenuEntities> moreMenu = [
    const MenuEntities(
      imageMenu: 'assets/profile/Help.png',
      title: 'Help & Support',
      description: 'Get help with your account',
    ),
    const MenuEntities(
      imageMenu: 'assets/profile/About-app.png',
      title: 'About App',
      description: 'Learn more about the app',
    ),
  ];
}

class MenuEntities {
  final String imageMenu;
  final String title;
  final String description;
  const MenuEntities({
    required this.imageMenu,
    required this.title,
    required this.description,
  });
}

class ProfileController {
  static final List<MenuEntities> menu = [
    
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
        imageMenu: 'assets/profile/Shield.png',
        title: 'Two-Factor Authentication',
        description: 'Further secure your account',
      ),
    
    
      const MenuEntities(
        imageMenu: 'assets/profile/Logout.png',
        title: 'Log out',
        description: 'Log out of your account',
      ),
    
  ];

  static final List<MenuEntities> moreMenu = [
    
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

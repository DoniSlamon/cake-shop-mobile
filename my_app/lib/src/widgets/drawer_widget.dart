import 'package:flutter/material.dart';
import 'package:my_app/src/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    void logout() {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Custom Drawer Header
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.cake,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Sweet Dreams\nBakery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Hello, ${userProvider.user?.displayName ?? "Guest"}!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Menu Items
            _buildDrawerItem(
              context,
              icon: Icons.home,
              title: 'Home',
              subtitle: 'Back to main page',
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
            ),
            
            _buildDrawerItem(
              context,
              icon: Icons.cake,
              title: 'Browse Cakes',
              subtitle: 'See all our delicious cakes',
              onTap: () {
                Navigator.pushNamed(context, '/cake_list');
              },
            ),
            
            _buildDrawerItem(
              context,
              icon: Icons.add_circle,
              title: 'Custom Order',
              subtitle: 'Create your dream cake',
              onTap: () {
                Navigator.pushNamed(context, '/create_cake');
              },
            ),

            const Divider(height: 32),

            _buildDrawerItem(
              context,
              icon: Icons.info,
              title: 'About Us',
              subtitle: 'Learn more about our bakery',
              onTap: () {
                _showAboutDialog(context);
              },
            ),
            
            _buildDrawerItem(
              context,
              icon: Icons.contact_support,
              title: 'Contact',
              subtitle: 'Get in touch with us',
              onTap: () {
                _showContactDialog(context);
              },
            ),

            const Divider(height: 32),

            _buildDrawerItem(
              context,
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              isDestructive: true,
              onTap: () {
                _showLogoutDialog(context, userProvider, logout);
              },
            ),

            const SizedBox(height: 20),
            
            // Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '🍰 Made with love since 2024\n© Sweet Dreams Bakery',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive 
              ? Colors.red.withOpacity(0.1)
              : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isDestructive 
              ? Colors.red
              : Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : null,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            Icons.cake,
            color: Theme.of(context).colorScheme.primary,
            size: 48,
          ),
          title: const Text('About Sweet Dreams Bakery'),
          content: const Text(
            'Sweet Dreams Bakery telah melayani komunitas dengan kue-kue berkualitas tinggi sejak 2024. '
            'Kami bangga menggunakan bahan-bahan terbaik dan resep tradisional untuk menciptakan '
            'momen-momen manis yang tak terlupakan.\n\n'
            'Visi kami adalah menjadi toko kue terpercaya yang menghadirkan kebahagiaan melalui '
            'setiap gigitan kue yang lezat.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            Icons.contact_support,
            color: Theme.of(context).colorScheme.primary,
            size: 48,
          ),
          title: const Text('Contact Us'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, size: 16),
                  SizedBox(width: 8),
                  Expanded(child: Text('Jl. Manis No. 123, Jakarta')),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 16),
                  SizedBox(width: 8),
                  Text('+62 21 1234 5678'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email, size: 16),
                  SizedBox(width: 8),
                  Text('hello@sweetdreams.co.id'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.schedule, size: 16),
                  SizedBox(width: 8),
                  Expanded(child: Text('Daily 8:00 AM - 9:00 PM')),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, UserProvider userProvider, VoidCallback logout) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
            size: 48,
          ),
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                userProvider.logout();
                logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
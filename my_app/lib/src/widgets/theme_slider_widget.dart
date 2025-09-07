import 'package:flutter/material.dart';
import 'package:my_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:my_app/theme/theme_provider.dart';

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ThemeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeData == darkTheme;

    return AppBar(
      title: Text(title),
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blue,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Light Mode') {
              themeProvider.themeData = lightTheme;
            } else if (value == 'Dark Mode') {
              themeProvider.themeData = darkTheme;
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Light Mode', 'Dark Mode'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

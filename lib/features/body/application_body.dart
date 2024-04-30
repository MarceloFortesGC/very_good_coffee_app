import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:very_good_coffee_app/features/favorites/favorites_page.dart';
import 'package:very_good_coffee_app/features/home/home_page.dart';

class ApplicationBody extends StatefulWidget {
  const ApplicationBody({super.key});

  @override
  State<ApplicationBody> createState() => _ApplicationBodyState();
}

class _ApplicationBodyState extends State<ApplicationBody> {
  final _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: const [
        HomePage(),
        FavoritesPage(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: const Color(0xFFA26334),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite),
          title: ("Favorites"),
          activeColorPrimary: const Color(0xFFA26334),
          inactiveColorPrimary: Colors.grey,
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      confineInSafeArea: true,
      navBarStyle: NavBarStyle.style1,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/favorites/favorites_page.dart';
import 'package:very_good_coffee_app/features/home/home_page.dart';
import 'package:very_good_coffee_app/features/providers/connection_provider.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

class ApplicationBody extends StatefulWidget {
  const ApplicationBody({super.key});

  @override
  State<ApplicationBody> createState() => _ApplicationBodyState();
}

class _ApplicationBodyState extends State<ApplicationBody> {
  final _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ImagesProvider, ConnectionProvider>(
      builder: (context, value, connection, child) {
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
              activeColorPrimary: CustomColors.secondaryColor,
              activeColorSecondary: Colors.white,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.favorite),
              title: ("Liked"),
              activeColorPrimary: CustomColors.secondaryColor,
              activeColorSecondary: Colors.white,
              inactiveColorPrimary: Colors.grey,
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          confineInSafeArea: true,
          navBarStyle: NavBarStyle.style1,
        );
      },
    );
  }
}

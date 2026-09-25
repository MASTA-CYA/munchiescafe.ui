import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/common/helpers/color_helper.dart';
import 'package:munchies_cafe/common/navigator/page_navigator.dart';
import 'package:munchies_cafe/common/navigator/transition_direction_enum.dart';
import 'package:munchies_cafe/home-component/home_page.dart';
import 'package:munchies_cafe/menu-component/menu_page.dart';
import 'package:munchies_cafe/user-component/user_profile_page.dart';

class NavigationDestinationsWidget<T> extends StatelessWidget {
  const NavigationDestinationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._buildDestinations(context),
        _buildUserProfile(context),
        _buildReportBug(context),
      ],
    );
  }

  List<Widget> _buildDestinations(BuildContext context) {
    List<Widget> destinations = [
      ListTile(
        tileColor: T.equals(HomePage)
            ? ColorHelper.lighten(
                Theme.of(context).colorScheme.primary,
                60,
              )
            : null,
        leading: ImageIcon(
          const ResizeImage(
            AssetImage('assets/images/home.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          color:
              T.equals(HomePage) ? Theme.of(context).colorScheme.primary : null,
        ),
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleLarge?.merge(
                TextStyle(
                  fontWeight: FontWeight.bold,
                  color: T.equals(HomePage)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
        ),
        onTap: () => _navigateTo<HomePage>(
          context,
          const HomePage(),
        ),
      ),
      ListTile(
        tileColor: T.equals(MenuPage)
            ? ColorHelper.lighten(
                Theme.of(context).colorScheme.primary,
                60,
              )
            : null,
        leading: ImageIcon(
          const ResizeImage(
            AssetImage('assets/images/menu.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          color:
              T.equals(MenuPage) ? Theme.of(context).colorScheme.primary : null,
        ),
        title: Text(
          'Menu',
          style: Theme.of(context).textTheme.titleLarge?.merge(
                TextStyle(
                  fontWeight: FontWeight.bold,
                  color: T.equals(MenuPage)
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
        ),
        onTap: () => _navigateTo<MenuPage>(
          context,
          const MenuPage(),
        ),
      ),
    ];

    return destinations;
  }

  Widget _buildUserProfile(BuildContext context) {
    return ListTile(
      tileColor: T.equals(UserProfilePage)
          ? ColorHelper.lighten(
              Theme.of(context).colorScheme.primary,
              60,
            )
          : null,
      leading: Icon(
        CupertinoIcons.profile_circled,
        color: T.equals(UserProfilePage)
            ? Theme.of(context).colorScheme.primary
            : null,
      ),
      title: Text(
        'Profile',
        style: Theme.of(context).textTheme.titleLarge?.merge(
              TextStyle(
                fontWeight: FontWeight.bold,
                color: T.equals(UserProfilePage)
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
      ),
      onTap: () => _navigateTo<UserProfilePage>(
        context,
        const UserProfilePage(),
      ),
    );
  }

  Widget _buildReportBug(BuildContext context) {
    return ListTile(
      leading: const ImageIcon(
        ResizeImage(
          AssetImage('assets/images/bug.png'),
          width: 70,
          height: 70,
          allowUpscaling: false,
        ),
        // size: 20,
      ),
      title: Text(
        'Report Bug',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
      ),
      onTap: () {},
    );
  }

  void _navigateTo<T>(
    BuildContext context,
    Widget widget, {
    TransitionDirection direction = TransitionDirection.ltr,
  }) async {
    PageNavigator.navigateTo<T>(
      context,
      widget,
      direction: direction,
      shouldPop: true,
    );
  }
}

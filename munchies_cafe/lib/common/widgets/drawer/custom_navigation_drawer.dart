import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/widgets/drawer/drawer_header.dart';
import 'package:munchies_cafe/common/widgets/drawer/navigation_destinations.dart';

class CustomNavigationDrawer<T> extends StatefulWidget {
  const CustomNavigationDrawer({super.key});

  @override
  State<CustomNavigationDrawer<T>> createState() =>
      _CustomNavigationDrawerState<T>();
}

class _CustomNavigationDrawerState<T> extends State<CustomNavigationDrawer<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLongList = MediaQuery.of(context).size.height >= 685 ? true : false;

    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildDrawerHeader(),
                  _buildNavigationDestinations(),
                  isLongList ? _buildSignOutTile() : const SizedBox.shrink(),
                ],
              ),
            ),
            isLongList ? const SizedBox.shrink() : _buildSignOutTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return const DrawerHeaderWidget();
  }

  Widget _buildNavigationDestinations() {
    return NavigationDestinationsWidget<T>();
  }

  Widget _buildSignOutTile() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ListTile(
        leading: const Icon(
          Icons.exit_to_app,
        ),
        title: Text(
          'Sign Out',
          style: Theme.of(context).textTheme.titleLarge?.merge(
                const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        onTap: () {},
      ),
    );
  }
}

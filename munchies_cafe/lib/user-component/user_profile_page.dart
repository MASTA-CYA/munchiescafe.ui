import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/functions.dart';
import 'package:munchies_cafe/common/widgets/appbar.dart';
import 'package:munchies_cafe/common/widgets/drawer/custom_navigation_drawer.dart';
import 'package:munchies_cafe/user-component/widgets/profile_actions.dart';
import 'package:munchies_cafe/user-component/widgets/profile_header.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfilePage> {
  final String _title = 'Profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<UserProfilePage>(title: _title),
      drawer: const CustomNavigationDrawer<UserProfilePage>(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Functions.horizontalScreenMargin(context),
          vertical: 10,
        ),
        child: _buildUserProfile(),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        _buildProfileHeader(),
        const Spacer(),
        _buildProfileActions(),
        const Spacer(),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return const ProfileHeaderWidget();
  }

  Widget _buildProfileActions() {
    return const ProfileActionsWidget();
  }
}

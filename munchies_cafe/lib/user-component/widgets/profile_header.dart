import 'package:flutter/material.dart';
import 'package:munchies_cafe/user-component/widgets/profile_image.dart';
import 'package:munchies_cafe/user-component/widgets/profile_statistics.dart';
import 'package:munchies_cafe/user-component/widgets/profile_username.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        const SizedBox(height: 10),
        _buildUsername(),
        const SizedBox(height: 10),
        _buildStatistics(),
      ],
    );
  }

  Widget _buildImage() {
    return ProfileImageWidget(
      onClicked: () {},
    );
  }

  Widget _buildUsername() {
    return const ProfileUsernameWidget();
  }

  Widget _buildStatistics() {
    return const ProfileStatisticsWidget();
  }
}

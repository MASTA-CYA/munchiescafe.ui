import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';

class ProfileActionsWidget extends StatelessWidget {
  const ProfileActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAddressAction(context),
        _buildDivider(),
        _buildMessages(context),
        _buildDivider(),
        _buildSettingsAction(context),
      ],
    );
  }

  Widget _buildAddressAction(BuildContext context) {
    return ListTile(
      leading: Icon(
        CupertinoIcons.map_pin_ellipse,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        'Address',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () {},
    );
  }

  Widget _buildMessages(BuildContext context) {
    return ListTile(
      leading: Badge(
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: Text(
          '3',
          style: Theme.of(context).textTheme.labelSmall?.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: FontFamily.PRIMARY,
                ),
              ),
        ),
        child: ImageIcon(
          const ResizeImage(
            AssetImage('assets/images/message.png'),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      title: Text(
        'Messages',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () {},
    );
  }

  Widget _buildSettingsAction(BuildContext context) {
    return ListTile(
      leading: ImageIcon(
        const ResizeImage(
          AssetImage('assets/images/settings.png'),
          width: 70,
          height: 70,
          allowUpscaling: false,
        ),
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        'Settings',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () {},
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}

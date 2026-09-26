import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Column(
                children: [
                  _buildAccountImage(context),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildAccountUsername(context),
                  _buildAccountEmail(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountImage(BuildContext context) {
    return const CircleAvatar(
      radius: 40,
      backgroundImage: ResizeImage(
        AssetImage('assets/images/angela.jpg'),
        width: 160,
        height: 160,
      ),
    );
  }

  Widget _buildAccountUsername(BuildContext context) {
    return Text(
      'Angela Grasser',
      style: Theme.of(context).textTheme.titleLarge?.merge(
            const TextStyle(
              fontFamily: FontFamily.primary,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }

  Widget _buildAccountEmail(BuildContext context) {
    return Text(
      'Sweets Connoisseur',
      style: Theme.of(context).textTheme.titleMedium?.merge(
            TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}

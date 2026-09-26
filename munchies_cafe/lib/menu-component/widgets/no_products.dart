import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';

class NoProductsWidget extends StatelessWidget {
  final String category;

  const NoProductsWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 250,
          child: const Image(
            image: ResizeImage(
              AssetImage('assets/images/no-products.png'),
              width: 300,
              height: 300,
              allowUpscaling: false,
            ),
            color: null,
          ),
        ),
        Text(
          'NO ${category.toUpperCase()} FOUND',
          style: Theme.of(context).textTheme.titleLarge?.merge(
                const TextStyle(fontFamily: FontFamily.primary),
              ),
        ),
      ],
    );
  }
}

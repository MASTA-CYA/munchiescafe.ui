import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:flutter/material.dart';
import 'package:munchies_cafe/home-component/models/best_seller_model.dart';
import 'package:munchies_cafe/home-component/widgets/best_seller.dart';

class BestSellersCarouselWidget extends StatelessWidget {
  final List<BestSeller> products;
  final void Function(BestSeller seller) onOrderNowPressed;

  const BestSellersCarouselWidget({
    super.key,
    required this.products,
    required this.onOrderNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return slider.CarouselSlider(
      options: slider.CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 6),
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        clipBehavior: Clip.none,
      ),
      items: products
          .map(
            (product) => BestSellerWidget(
              product: product,
              onOrderNowPressed: () => onOrderNowPressed(product),
            ),
          )
          .toList(),
    );
  }
}

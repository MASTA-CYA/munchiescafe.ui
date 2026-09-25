import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:flutter/material.dart';
import 'package:munchies_cafe/home-component/models/best_seller_model.dart';
import 'package:munchies_cafe/home-component/widgets/best_seller.dart';

class BestSellersCarouselWidget extends StatefulWidget {
  final List<BestSeller> products;
  final void Function(BestSeller seller) onOrderNowPressed;

  const BestSellersCarouselWidget({
    super.key,
    required this.products,
    required this.onOrderNowPressed,
  });

  @override
  State<StatefulWidget> createState() => _BestSellersCarouselWidget();
}

class _BestSellersCarouselWidget extends State<BestSellersCarouselWidget> {
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();

    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return slider.CarouselSlider(
      carouselController: _carouselController,
      options: slider.CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 6),
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        clipBehavior: Clip.none,
      ),
      items: widget.products
          .map(
            (product) => BestSellerWidget(
              product: product,
              onOrderNowPressed: () => widget.onOrderNowPressed(product),
            ),
          )
          .toList(),
    );
  }
}
  
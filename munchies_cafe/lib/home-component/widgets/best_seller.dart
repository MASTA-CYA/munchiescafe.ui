import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/home-component/models/best_seller_model.dart';

class BestSellerWidget extends StatelessWidget {
  final BestSeller product;
  final void Function() onOrderNowPressed;

  const BestSellerWidget({
    super.key,
    required this.product,
    required this.onOrderNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 40,
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleMedium?.merge(
                    TextStyle(
                      fontFamily: FontFamily.primary,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(product.image),
                width: 560,
                height: 181,
                allowUpscaling: false,
              ),
              fit: BoxFit.fill,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
        Container(
          color: Colors.transparent.withValues(alpha: 0.45),
        ),
        _buildQuantity(context),
        _buildPrice(context),
        _buildOrderNow(context),
      ],
    );
  }

  Widget _buildQuantity(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(6, 4, 6, 0),
        child: Text(
          '${product.quantity}\t'
          '${product.quantity > 1 ? 'pcs' : 'pc'}',
          style: Theme.of(context).textTheme.bodyMedium?.merge(
                const TextStyle(
                  color: Colors.blue,
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(6, 4, 6, 0),
        child: Text(
          NumberFormat.simpleCurrency(
            locale: "en_ZA",
            decimalDigits: 2,
          ).format(product.price),
          style: Theme.of(context).textTheme.bodyMedium?.merge(
                const TextStyle(
                  color: Colors.green,
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildOrderNow(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.fromLTRB(6, 4, 6, 0),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Order Now',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.merge(const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
          onTap: () => onOrderNowPressed(),
        ),
      ),
    );
  }
}

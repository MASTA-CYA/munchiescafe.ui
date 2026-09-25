import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/menu-component/models/product_model.dart';
import 'package:munchies_cafe/menu-component/widgets/product_variation_chip.dart';
import 'package:munchies_cafe/menu-component/widgets/read_more_text.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  final Function(Product product) onAddToFavoritesPressed;
  final Function(Product product) onAddToCartPressed;
  const ProductWidget({
    super.key,
    required this.product,
    required this.onAddToFavoritesPressed,
    required this.onAddToCartPressed,
  });

  @override
  State<StatefulWidget> createState() => _ProductWidget();
}

class _ProductWidget extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Theme.of(context).cardTheme.margin,
      child: Column(
        children: [
          _buildProductImage(),
          _buildProductDetails(),
          _buildQuantityPriceDetails(),
          _buildVariations(),
          _buildButtonBar(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 190,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ResizeImage(
            AssetImage(widget.product.image),
            width: 704,
            height: 380,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.product.name,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge?.merge(
                    TextStyle(
                      fontFamily: FontFamily.PRIMARY,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: ReadMoreTextWidget(
              text: widget.product.description,
              style: Theme.of(context).textTheme.bodyMedium!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      height: 1.0,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityPriceDetails() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'af');

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.product.quantity,
            style: Theme.of(context).textTheme.bodyMedium!.merge(
                  const TextStyle(
                    color: Colors.blue,
                  ),
                ),
          ),
          Text(
            formatCurrency.format(widget.product.price),
            style: Theme.of(context).textTheme.bodyMedium!.merge(
                  const TextStyle(
                    color: Colors.green,
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariations() {
    if (widget.product.variations.isNull) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Wrap(
          children: widget.product.variations!
              .map(
                (variation) => ProductVariationChipWidget(
                  variations: variation,
                  startSelected: widget.product.variations!.last.equals(
                    variation,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => widget.onAddToFavoritesPressed(widget.product),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Icon(
                Icons.favorite_border,
                color: Colors.red,
                // size: 26,
              ),
              const SizedBox(width: 8),
              Container(
                // margin: const EdgeInsets.only(top: 4.5),
                child: Text(
                  "ADD TO FAVORITES",
                  style: Theme.of(context).textTheme.bodyMedium?.merge(
                        TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => widget.onAddToCartPressed(widget.product),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ImageIcon(
                const ResizeImage(
                  AssetImage('assets/images/cart.png'),
                  width: 70,
                  height: 70,
                  allowUpscaling: false,
                ),
                color: Theme.of(context).iconTheme.color,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                "ADD TO CART",
                style: Theme.of(context).textTheme.bodyMedium?.merge(
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

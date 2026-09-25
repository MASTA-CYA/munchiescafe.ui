import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/menu-component/models/product_model.dart';
import 'package:munchies_cafe/menu-component/widgets/product_variation_chip.dart';
import 'package:munchies_cafe/menu-component/widgets/read_more_text.dart';

class CartProductWidget extends StatefulWidget {
  final Product product;
  final Function(Product product) onRemoveFromCartPressed;
  final Function(Product product, double subtotal) onSubtotalChanged;

  const CartProductWidget({
    super.key,
    required this.product,
    required this.onRemoveFromCartPressed,
    required this.onSubtotalChanged,
  });

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  late int _quantity;

  @override
  void initState() {
    super.initState();

    _quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Theme.of(context).cardTheme.margin,
      child: Column(
        children: [
          buildProductImage(),
          buildProductDetails(),
          const SizedBox(height: 6),
          _buildVariations(),
          buildQuantitySelector(),
          buildProductTotals(),
        ],
      ),
    );
  }

  Widget buildProductImage() {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 190,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(widget.product.image),
                width: 704,
                height: 380,
                allowUpscaling: false,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.red,
              size: 28,
            ),
            onPressed: () => widget.onRemoveFromCartPressed(widget.product),
          ),
        ),
      ],
    );
  }

  Widget buildProductDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
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
          const SizedBox(
            height: 10,
          ),
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

  Widget buildQuantitySelector() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _quantity > 1 ? () => onQuantityDecreased() : null,
          ),
          Text(
            _quantity.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.merge(
                  TextStyle(
                      fontFamily: FontFamily.PRIMARY,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => onQuantityIncreased(),
          ),
        ],
      ),
    );
  }

  Widget buildProductTotals() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Price:',
                style: Theme.of(context).textTheme.bodyMedium?.merge(
                      const TextStyle(),
                    ),
              ),
              const SizedBox(width: 10),
              Text(
                NumberFormat.simpleCurrency(locale: 'en_za').format(widget.product.price),
                style: Theme.of(context).textTheme.bodyMedium?.merge(
                      const TextStyle(),
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Subtotal:',
                style: Theme.of(context).textTheme.bodyMedium?.merge(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
              const SizedBox(width: 10),
              Text(
                NumberFormat.simpleCurrency(locale: 'en_za').format(calcSubtotal()),
                style: Theme.of(context).textTheme.bodyMedium?.merge(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double calcSubtotal() {
    double subtotal = widget.product.price * _quantity;
    return subtotal;
  }

  void onQuantityDecreased() {
    _quantity = _quantity - 1;
    widget.onSubtotalChanged(widget.product, calcSubtotal());
    setState(() {});
  }

  onQuantityIncreased() {
    _quantity = _quantity + 1;
    widget.onSubtotalChanged(widget.product, calcSubtotal());
    setState(() {});
  }
}

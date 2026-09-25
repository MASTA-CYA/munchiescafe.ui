import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munchies_cafe/cart-component/widgets/cart_button.dart';
import 'package:munchies_cafe/cart-component/widgets/cart_product.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/helpers/color_helper.dart';
import 'package:munchies_cafe/common/themes/themes_common.dart';
import 'package:munchies_cafe/common/widgets/appbar.dart';
import 'package:munchies_cafe/menu-component/models/product_model.dart';
import 'package:munchies_cafe/menu-component/models/product_variation_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  final String _title = 'Cart';

  late List<Product> products;

  late ScrollController _scrollController;
  final ValueNotifier _canScrollToTop = ValueNotifier(false);

  final ValueNotifier _total = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() => _onCartPageScroll());

    products = [
      Product(
        id: 6,
        image: 'assets/images/milkshakes.jpg',
        category: 'Beverages',
        name: 'Classic Milkshake',
        description: 'Get ready to be delighted by our incredible milkshake '
            'selection specially crafted for our beloved Milkshakes lovers.',
        quantity: '1L',
        price: 33.00,
        variations: [
          ProductVariation(
            name: 'Chocolate',
            color: ThemesCommon.primaryColor,
          ),
          ProductVariation(
            name: 'Vanilla',
            color: ColorHelper.fromHex('#F3E5AB'),
          ),
          ProductVariation(
            name: 'Strawberry',
            color: Colors.pink[400]!,
          ),
          ProductVariation(
            name: 'Lime',
            color: Colors.lime,
          ),
        ],
      ),
      Product(
        id: 4,
        image: 'assets/images/carrot-cake.jpg',
        category: 'Cakes',
        name: 'Colossal Carrot Cake',
        description: 'Our Colossal Carrot Cake features two layers of moist, '
            'spicy carrot-laden cake with crushed pineapple, walnuts and coconut, '
            'all filled and covered with our delectable cream cheese icing. '
            'A mixture of sweet coconut and walnuts covers the top of the cake a white chocolate drizzle finishes it. '
            'Toasted almonds skirt the sides.',
        quantity: '1pc',
        price: 47.00,
      ),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<CartPage>(title: _title),
      // drawer: const CustomNavigationDrawer<CartPage>(),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: _buildCartScaffold(),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _canScrollToTop,
        builder: (context, canScroll, child) {
          return canScroll
              ? Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: FloatingActionButton(
                    child: const Icon(Icons.arrow_upward),
                    onPressed: () => _scrollToTop(),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }

  Widget _buildCartScaffold() {
    return Column(
      children: [
        buildCartProducts(),
        buildCartTotal(),
        buildBottomButtonBar(),
      ],
    );
  }

  Widget buildCartProducts() {
    return Expanded(
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return CartProductWidget(
                  product: products.elementAt(index),
                  onRemoveFromCartPressed: (product) {},
                  onSubtotalChanged: (product, subtotal) {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartTotal() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageIcon(
              ResizeImage(
                AssetImage('assets/images/banknotes.png'),
                width: 70,
                height: 70,
                allowUpscaling: false,
              ),
              size: 25,
              color: Colors.green,
            ),
            const SizedBox(width: 8),
            ValueListenableBuilder(
              valueListenable: _total,
              builder: (context, total, child) => Container(
                margin: const EdgeInsets.only(top: 4.5),
                child: Text(
                  NumberFormat.simpleCurrency(locale: 'en_za').format(
                    33.00 + 47.00,
                  ),
                  style: const TextStyle(
                    fontFamily: FontFamily.PRIMARY,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomButtonBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          CartButtonWidget(
            icon: const Icon(
              Icons.delete_sweep,
              size: 24.5,
            ),
            text: 'Clear Cart',
            color: Colors.red,
            isPrimary: false,
            onClicked: () async => {},
          ),
          CartButtonWidget(
            icon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: const ImageIcon(
                ResizeImage(
                  AssetImage('assets/images/wallet.png'),
                  width: 70,
                  height: 70,
                  allowUpscaling: false,
                ),
                size: 19,
              ),
            ),
            text: 'Checkout',
            isPrimary: false,
            onClicked: () async => {},
          ),
        ],
      ),
    );
  }

  void _onCartPageScroll() {
    _canScrollToTop.value = _scrollController.position.extentBefore > 450;
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
    );
  }

  void _onProductSubtotalChanged(Product product, double subtotal) {
    // CartProduct cp = lsProducts.firstWhere((p) => p.product == product);
    // int index = lsProducts.indexOf(cp);
    // cp.subtotal = subtotal;
    // lsProducts[index] = cp;

    _calcCartTotal();
  }

  void _calcCartTotal() {
    double total = 0;
    // for (CartProduct cp in lsProducts) {
    //   total += cp.subtotal;
    // }

    _total.value = total;
  }
}

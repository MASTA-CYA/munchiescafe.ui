import 'package:flutter/material.dart';
import 'package:munchies_cafe/cart-component/cart_page.dart';
import 'package:munchies_cafe/common/navigator/page_navigator.dart';
import 'package:munchies_cafe/common/navigator/transition_direction_enum.dart';
import 'package:munchies_cafe/common/widgets/appbar.dart';
import 'package:munchies_cafe/common/widgets/drawer/custom_navigation_drawer.dart';
import 'package:munchies_cafe/common/widgets/page_background.dart';
import 'package:munchies_cafe/common/widgets/page_section.dart';
import 'package:munchies_cafe/home-component/enums/order_type_enum.dart';
import 'package:munchies_cafe/home-component/enums/payment_type_enum.dart';
import 'package:munchies_cafe/home-component/enums/transaction_type_enum.dart';
import 'package:munchies_cafe/home-component/models/best_seller_model.dart';
import 'package:munchies_cafe/home-component/models/order_summary_model.dart';
import 'package:munchies_cafe/home-component/models/wallet_transaction_model.dart';
import 'package:munchies_cafe/home-component/widgets/best_sellers_carousel.dart';
import 'package:munchies_cafe/home-component/widgets/order_summary.dart';
import 'package:munchies_cafe/home-component/widgets/wallet_transaction.dart';
import 'package:munchies_cafe/menu-component/menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final String _title = 'Munchies Café';

  late List<OrderSummary> _orders;
  late List<WalletTransaction> _transactions;

  @override
  void initState() {
    super.initState();

    _orders = [
      OrderSummary(
        id: '598',
        items: '2 x 5 pcs Red Velvet Cookies',
        amount: 240.00,
        type: OrderType.delivery,
        method: PaymentMethod.card,
      ),
      OrderSummary(
        id: '954',
        items: '3 x 750ml Vanilla Ganache Milkshake',
        amount: 168.00,
        type: OrderType.collection,
        method: PaymentMethod.voucher,
      ),
      OrderSummary(
        id: '598',
        items: '1 x 4 pcs Biscottie Cream Puffs',
        amount: 75.00,
        type: OrderType.delivery,
        method: PaymentMethod.cash,
      ),
    ];

    _transactions = const [
      WalletTransaction(
        reference: '53542',
        date: '31/03/2024',
        time: '15:06',
        description: 'Voucher Top Up',
        amount: 545,
        type: TransactionType.credit,
        method: PaymentMethod.voucher,
      ),
      WalletTransaction(
        reference: '53542',
        date: '31/03/2024',
        time: '15:06',
        description: 'Order Payment',
        amount: 168.00,
        type: TransactionType.debit,
        method: PaymentMethod.card,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<HomePage>(title: _title),
      drawer: const CustomNavigationDrawer<HomePage>(),
      body: PageBackgroundWidget(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _buildHomeScaffold(),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeScaffold() {
    return Column(
      children: [
        _buildBestSellersCarousel(),
        _buildRecentOrders(),
        _buildWalletTransactions(),
      ],
    );
  }

  Widget _buildBestSellersCarousel() {
    return Column(
      children: [
        PageSectionWidget(
          title: 'Best Sellers',
          startExpanded: true,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 0, 8),
            child: BestSellersCarouselWidget(
              onOrderNowPressed: (product) => _navigateTo<MenuPage>(
                const MenuPage(),
              ),
              products: const [
                BestSeller(
                  id: 0,
                  image: 'assets/images/chocolate-mousse-cake.jpg',
                  name: 'Chocolate Mousse Cake',
                  quantity: 1,
                  price: 230.00,
                ),
                BestSeller(
                  id: 1,
                  image: 'assets/images/red-velvet-cookies.jpg',
                  name: 'Red Velvet Cookies',
                  quantity: 5,
                  price: 120.00,
                ),
                BestSeller(
                  id: 2,
                  image: 'assets/images/blueberry-smoothie.jpg',
                  name: 'Blueberry Smoothie',
                  quantity: 1,
                  price: 80.00,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentOrders() {
    return Column(
      children: [
        PageSectionWidget(
          title: 'Recent Orders',
          startExpanded: true,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _orders.length,
            itemBuilder: (context, index) => OrderSummaryWidget(
              order: _orders.elementAt(index),
              onOrderSummaryPressed: () => _navigateTo<CartPage>(
                const CartPage(),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildWalletTransactions() {
    return Column(
      children: [
        PageSectionWidget(
          title: 'Wallet Transactions',
          startExpanded: true,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _transactions.length,
            itemBuilder: (context, index) => WalletTransactionWidget(
              transaction: _transactions.elementAt(index),
            ),
          ),
        )
      ],
    );
  }

  void _navigateTo<T>(
    Widget widget, {
    TransitionDirection direction = TransitionDirection.ltr,
  }) async {
    PageNavigator.navigateTo<T>(
      context,
      widget,
      direction: direction,
      useScheduler: false,
      shouldPop: false,
    );
  }
}

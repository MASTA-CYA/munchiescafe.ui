import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munchies_cafe/cart-component/cart_page.dart';
import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/common/helpers/color_helper.dart';
import 'package:munchies_cafe/common/helpers/enums/snackbar_type_enum.dart';
import 'package:munchies_cafe/common/helpers/snackbar_helper.dart';
import 'package:munchies_cafe/common/navigator/page_navigator.dart';
import 'package:munchies_cafe/common/navigator/transition_direction_enum.dart';
import 'package:munchies_cafe/common/notifications/enums/notification_type_enum.dart';
import 'package:munchies_cafe/common/notifications/notification_scaffold.dart';
import 'package:munchies_cafe/common/theme/app_theme.dart';
import 'package:munchies_cafe/common/widgets/appbar.dart';
import 'package:munchies_cafe/common/widgets/drawer/custom_navigation_drawer.dart';
import 'package:munchies_cafe/common/widgets/page_background.dart';
import 'package:munchies_cafe/common/widgets/search_icon.dart';
import 'package:munchies_cafe/menu-component/models/menu_category_filter_model.dart';
import 'package:munchies_cafe/menu-component/models/product_model.dart';
import 'package:munchies_cafe/menu-component/models/product_variation_model.dart';
import 'package:munchies_cafe/menu-component/widgets/menu_category.dart';
import 'package:munchies_cafe/menu-component/widgets/no_products.dart';
import 'package:munchies_cafe/menu-component/widgets/product.dart';
import 'package:munchies_cafe/message-component/models/message_severity_enum.dart';
import 'package:munchies_cafe/message-component/models/notification_model.dart';
import 'package:munchies_cafe/message-component/services/message_service.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  final String _title = 'Menu';

  late List<MenuCategoryFilter> _lsCategories;
  late String _selectedCategory;

  final ValueNotifier<bool> _isCategoryScrolling = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isSearchOpen = ValueNotifier<bool>(false);

  late List<Product> _products;

  @override
  void initState() {
    super.initState();

    _lsCategories = [
      MenuCategoryFilter(text: 'Cakes', isSelected: true),
      MenuCategoryFilter(text: 'Cookies'),
      MenuCategoryFilter(text: 'Muffins'),
      MenuCategoryFilter(text: 'Beverages'),
    ];
    _selectedCategory = _lsCategories
        .firstWhere(
          (category) => category.isSelected!,
          orElse: () => _lsCategories.first,
        )
        .text;

    _products = [
      Product(
        id: 0,
        image: 'assets/images/chocolate-mousse-cake.jpg',
        category: 'Cakes',
        name: 'Chocolate Mousse Cake',
        description:
            'This unbelievably indulgent, rich chocolate cake features moist, '
            'dense cake layers separated by exquisite chocolate mousse made from scratch. '
            'Finished with a blanket of chocolate buttercream and swathed in chocolate ganache.',
        quantity: '1pc',
        price: 34.00,
      ),
      Product(
        id: 2,
        image: 'assets/images/blueberry-smoothie.jpg',
        category: 'Beverages',
        name: 'Blueberry Smoothie',
        description:
            'This healthy blueberry smoothie tastes like blueberry pie! Made with banana, '
            'yogurt, and a pinch of cinnamon, it\'s filling and delicious!',
        quantity: '750ml',
        price: 80.00,
      ),
      Product(
        id: 3,
        image: 'assets/images/red-velvet-cake.jpg',
        category: 'Cakes',
        name: 'Red Velvet Cake',
        description:
            'Three moist layers of stunning Red Velvet filled and topped with silky cream cheese '
            'icing and finished with melt-in-your-mouth white and dark chocolate shavings and white chocolate drizzle; '
            'this cake is sure to be your new favourite.',
        quantity: '1pc',
        price: 50.00,
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
      Product(
        id: 5,
        image: 'assets/images/macaroon-cookies.jpg',
        category: 'Cookies',
        name: 'Macaron Cookies',
        description: 'Super delicious and fresh macarons. '
            'its hard to go wrong! Made with finely ground almond flour and only the fluffiest of egg whites, '
            'these macarons are like something out of Paris itself!',
        quantity: '3pcs',
        price: 96.00,
        variations: [
          ProductVariation(
            name: 'Vanilla',
            color: ColorHelper.fromHex('#F3E5AB'),
          ),
          ProductVariation(
            name: 'Oreo',
            color: ColorHelper.fromHex('#6C6463'),
          ),
          ProductVariation(
            name: 'Raspberry',
            color: ColorHelper.fromHex('#E30B5C'),
          ),
        ],
      ),
      Product(
        id: 1,
        image: 'assets/images/red-velvet-cookies.jpg',
        category: 'Cookies',
        name: 'Red Velvet Cookies',
        description:
            'A perfect recreation of our most-requested Cupcake flavour in a Cookie form. '
            'Featuring White Chocolate Chips and a rich, '
            'slightly tart Vanilla-Cocoa dough and dipped in white chocolate with red velvet crumbs.',
        quantity: '5pcs',
        price: 120.00,
      ),
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
            color: AppColors.primary,
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<MenuPage>(
        title: _title,
        actions: GestureDetector(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 6, 0),
              child: Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          onTap: () {},
        ),
      ),
      drawer: const CustomNavigationDrawer<MenuPage>(),
      body: NotificationScaffoldWidget(
        child: PageBackgroundWidget(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _buildMenuScaffold(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuScaffold() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: _buildMenuCategories()),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _buildCategoryDisplay(),
        ),
      ],
    );
  }

  Widget _buildMenuCategories() {
    final double maxHeight = MediaQuery.of(context).size.height * 0.06;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: NotificationListener<ScrollStartNotification>(
        child: NotificationListener<ScrollEndNotification>(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _lsCategories.length,
            itemBuilder: (context, index) {
              return MenuCategoryWidget(
                category: _lsCategories.elementAt(index),
                onCategorySelected: (category) => _onCategorySelected(category),
              );
            },
          ),
          onNotification: (notification) =>
              _onCategoryScroll(notification),
        ),
        onNotification: (notification) => _onCategoryScroll(notification),
      ),
    );
  }

  Widget _buildSearchIcon() {
    final double maxHeight = MediaQuery.of(context).size.height * 0.06;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: ValueListenableBuilder(
        valueListenable: _isCategoryScrolling,
        builder: (context, isScrolling, child) => AnimatedSwitcher(
          transitionBuilder: (child, animation) => SlideTransition(
            position: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
              reverseCurve: Curves.bounceInOut,
            ).drive(
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ),
            ),
            child: child,
          ),
          duration: const Duration(milliseconds: 8000),
          child: isScrolling && !_isSearchOpen.value
              ? SizedBox.shrink(key: UniqueKey())
              : SearchIconWidget(
                  key: UniqueKey(),
                  isSearchOpen: _isSearchOpen.value,
                  isSearchSelected: (isSelected) =>
                      _isSearchSelected(isSelected),
                ),
        ),
      ),
    );
  }

  Widget _buildCategoryDisplay() {
    List<Product> products = _products
        .where((product) => product.category.equals(_selectedCategory))
        .toList();

    if (products.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductWidget(
          product: products.elementAt(index),
          onAddToFavoritesPressed: (product) => _addToFavoritesAsync(product),
          onAddToCartPressed: (product) => _addToCartAsync(product),
        ),
      );
    } else {
      return NoProductsWidget(category: _selectedCategory);
    }
  }

  void _onCategorySelected(String category) {
    List<MenuCategoryFilter> categories = [];
    for (MenuCategoryFilter filter in _lsCategories) {
      filter.isSelected = (filter.text == category);
      categories.add(filter);
    }
    _lsCategories = categories;
    _selectedCategory = category;
    setState(() {});
  }

  bool _onCategoryScroll(ScrollNotification notification) {
    const bool isNotificationHandled = true;

    if (notification is ScrollStartNotification) {
      _isCategoryScrolling.value = true;
    } else if (notification is ScrollEndNotification) {
      _isCategoryScrolling.value = false;
    }

    return isNotificationHandled;
  }

  void _isSearchSelected(bool isSelected) {
    _isSearchOpen.value = isSelected;
  }

  void _addToFavoritesAsync(Product product) async {
    Provider.of<MessageService>(
      context,
      listen: false,
    ).sendNotificationAsync(
      AppNotification(
        title: 'Add To Favorites',
        message: '${product.name} added to favorites',
        notificationText: 'Successfully added to favorites',
        severity: MessageSeverity.information,
        type: NotificationType.message,
      ),
    );
  }

  void _addToCartAsync(Product product) {
    SnackbarHelper.showMessage(
      context,
      SnackbarType.information,
      'Added to cart',
      action: SnackBarAction(
        label: 'VIEW',
        onPressed: () => _navigateTo<CartPage>(const CartPage()),
      ),
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

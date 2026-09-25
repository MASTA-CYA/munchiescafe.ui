import 'package:flutter/material.dart';
import 'package:munchies_cafe/authentication-component/authentication_page.dart';
import 'package:munchies_cafe/cart-component/cart_page.dart';
import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/common/navigator/named_page_route_model.dart';
import 'package:munchies_cafe/common/navigator/page_route.dart';
import 'package:munchies_cafe/common/navigator/transition_direction_enum.dart';
import 'package:munchies_cafe/common/navigator/unknown_route.dart';
import 'package:munchies_cafe/home-component/home_page.dart';
import 'package:munchies_cafe/menu-component/menu_page.dart';
// ignore: unused_import
import 'package:munchies_cafe/message-component/messages_page.dart';
import 'package:munchies_cafe/user-component/user_profile_page.dart';

class PageRouteHelper {
  static String getInitialRouteName() {
    return _getPageRoutes().first.name;
  }

  static Widget getInitialRouteWidget() {
    return _getPageRoutes().first.widget;
  }

  static String getInitialRoutePath() {
    return _getPageRoutes().first.path;
  }

  static List<NamedPageRoute> _getPageRoutes() {
    return [
      const NamedPageRoute(
        name: 'AuthenticationPage',
        widget: AuthenticationPage(),
      ),
      const NamedPageRoute(
        name: 'HomePage',
        widget: HomePage(),
      ),
      const NamedPageRoute(
        name: 'MenuPage',
        widget: MenuPage(),
      ),
      const NamedPageRoute(
        name: 'CartPage',
        widget: CartPage(),
      ),
      const NamedPageRoute(
        name: 'UserProfilePage',
        widget: UserProfilePage(),
      ),
    ];
  }

  static Map<String, Widget Function(BuildContext)> getNamedPageRoutes() {
    Map<String, Widget Function(BuildContext)> routes = {};
    List<NamedPageRoute> pages = _getPageRoutes();

    for (NamedPageRoute page in pages) {
      routes.addAll({page.path: (context) => page.widget});
    }

    return routes;
  }

  static Route<dynamic>? onGenerateRoute(
    BuildContext context,
    RouteSettings settings,
  ) {
    if (settings.name?.equals('/') ?? false) {
      return AnimatedMaterialPageRoute(
        widget: getInitialRouteWidget(),
        transitionColor: Theme.of(context).scaffoldBackgroundColor,
        settings: RouteSettings(name: getInitialRoutePath()),
      );
    } else if (!settings.name.isNull) {
      NamedPageRoute page = _getPageRoutes().firstWhere(
          (route) => route.path.equals(settings.name ?? ''),
          orElse: () => _getPageRoutes().first);
      return AnimatedMaterialPageRoute(
        widget: page.widget,
        transitionColor: Theme.of(context).scaffoldBackgroundColor,
        settings: RouteSettings(name: page.path),
      );
    } else {
      return null;
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes(
    BuildContext context,
    String initialRoute,
  ) {
    List<Route<dynamic>> routes = [];
    List<NamedPageRoute> pageRoutes = _getPageRoutes();
    NamedPageRoute restorableRoute = pageRoutes.first;

    routes.add(
      AnimatedMaterialPageRoute(
        widget: restorableRoute.widget,
        transitionColor: Theme.of(context).scaffoldBackgroundColor,
        settings: RouteSettings(name: restorableRoute.path),
      ),
    );
    return routes;
  }

  static Route<dynamic>? onUnknownRoute(
      BuildContext context, RouteSettings settings) {
    return AnimatedMaterialPageRoute(
      widget: const UnknownRouteWidget(),
      transitionColor: Theme.of(context).scaffoldBackgroundColor,
      settings: settings,
    );
  }

  static Route<void> generateRestorableRoute(
    BuildContext context,
    Map<Object?, Object?> params,
  ) {
    Widget widget = _getPageRoutes()
        .firstWhere(
          (route) => route.name.equals(params['name'] as String),
          orElse: () => _getPageRoutes().first,
        )
        .widget;
    return AnimatedMaterialPageRoute(
      widget: widget,
      transitionColor: Theme.of(context).scaffoldBackgroundColor,
      direction: TransitionDirection.fromName(params['direction'] as String),
      settings: RouteSettings(name: '/${params['name']}'),
    );
  }
}

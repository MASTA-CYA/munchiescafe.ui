import 'package:munchies_cafe/common/logger/enums/severity_enum.dart';
import 'package:munchies_cafe/common/logger/enums/tag_enum.dart';
import 'package:munchies_cafe/common/logger/logger.dart';
import 'package:munchies_cafe/common/logger/models/log_event_model.dart';
import 'package:flutter/material.dart';

class LoggingPageRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      await _logNavigation(
        route.settings.name,
        previousRoute?.settings.name,
        RouterAction.push,
      );
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) async {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      await _logNavigation(
        newRoute.settings.name,
        oldRoute?.settings.name,
        RouterAction.replace,
      );
    }
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) async {
    super.didPop(route!, previousRoute);
    if (route is PageRoute && previousRoute is PageRoute) {
      await _logNavigation(
        route.settings.name,
        previousRoute.settings.name,
        RouterAction.pop,
      );
    }
  }

  Future<void> _logNavigation(
    String? newRoute,
    String? oldRoute,
    RouterAction action,
  ) async {
    await Logger.logAsync(
      LogEvent<LoggingPageRouteObserver>(
        severity: Severity.information,
        tag: Tag.observer,
        line: _buildLogLine(newRoute, oldRoute, action),
      ),
    );
  }

  static String _buildLogLine(
    String? newRoute,
    String? oldRoute,
    RouterAction action,
  ) {
    return switch (action) {
      RouterAction.push => 'Navigated from $oldRoute to $newRoute',
      RouterAction.pop => 'Navigated from $newRoute to $oldRoute',
      RouterAction.replace => 'Replaced route $oldRoute with $newRoute',
    };
  }
}

enum RouterAction {
  push,
  replace,
  pop,
}

import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/common/logger/enums/severity_enum.dart';
import 'package:munchies_cafe/common/logger/enums/tag_enum.dart';
import 'package:munchies_cafe/common/logger/logger.dart';
import 'package:munchies_cafe/common/logger/models/log_event_model.dart';
import 'package:munchies_cafe/common/navigator/page_route.dart';
import 'package:munchies_cafe/common/navigator/page_route_helper.dart';
import 'package:munchies_cafe/common/navigator/transition_direction_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PageNavigator {
  static void navigateTo<T>(
    BuildContext context,
    Widget widget, {
    bool shouldPop = false,
    bool useScheduler = true,
    TransitionDirection direction = TransitionDirection.ltr,
    bool shouldRestore = false,
  }) async {
    if (!context.mounted) return;

    // Short circuit navigation if page is the same as current
    String? currentPage = ModalRoute.of(context)!.settings.name;
    if (currentPage?.equals('/'
            '${widget.runtimeType.toString()}') ??
        false) {
      await _logNavigation<T>();
      return;
    }

    if (useScheduler) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) async => await _doNavigation(
          context,
          widget,
          shouldPop,
          direction,
          T,
          shouldRestore,
        ),
      );
    } else {
      await _doNavigation(
        context,
        widget,
        shouldPop,
        direction,
        T,
        shouldRestore,
      );
    }
  }

  static void navigateBack<T>(
    BuildContext context, {
    bool useScheduler = true,
  }) async {
    if (!context.mounted) return;

    if (useScheduler) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).maybePop(context);
          }
        },
      );
    } else {
      if (Navigator.canPop(context)) {
        Navigator.of(context).maybePop(context);
      }
    }
  }

  static Future<void> _doNavigation(
    BuildContext context,
    Widget widget,
    bool shouldPop,
    TransitionDirection direction,
    Type type,
    bool shouldRestore,
  ) async {
    if (shouldPop && Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    if (type.toString().containsIgnoreCase('page') || shouldRestore) {
      Navigator.of(context).restorablePush(
        _restorableRouteBuilder,
        arguments: {
          'name': type.toString(),
          'direction': direction.name,
        },
      );
    } else {
      Navigator.of(context).push(
        AnimatedMaterialPageRoute(
          widget: widget,
          transitionColor: Theme.of(context).scaffoldBackgroundColor,
          direction: direction,
          settings: RouteSettings(name: '/$type'),
        ),
      );
    }
  }

  @pragma('vm:entry-point')
  static Route<void> _restorableRouteBuilder(
    BuildContext context,
    Object? arguments,
  ) {
    Map<Object?, Object?> params = arguments! as Map<Object?, Object?>;
    return PageRouteHelper.generateRestorableRoute(context, params);
  }

  static Future<void> _logNavigation<T>() async {
    await Logger.logAsync(
      LogEvent<PageNavigator>(
        severity: Severity.information,
        tag: Tag.application,
        line: 'Navigation short-circuited for page: $T',
      ),
    );
  }
}

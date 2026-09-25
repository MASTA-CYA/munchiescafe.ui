import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/helpers/hepatic_helper.dart';
import 'package:munchies_cafe/common/navigator/page_navigator.dart';
import 'package:munchies_cafe/common/navigator/transition_direction_enum.dart';
import 'package:munchies_cafe/common/notifications/enums/notification_type_enum.dart';
import 'package:munchies_cafe/common/widgets/scrolling_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/scheduler.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:munchies_cafe/message-component/models/message_severity_enum.dart';
import 'package:munchies_cafe/message-component/models/notification_model.dart';
import 'package:munchies_cafe/message-component/services/message_service.dart';
import 'package:provider/provider.dart';

class AppBarWidget<T> extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  State<StatefulWidget> createState() => _AppBarWidget<T>();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidget<T> extends State<AppBarWidget<T>>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  static const double iconSpacing = 16;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(),
      leading: _buildBackButton(),
      title: _buildTitle(),
      elevation: 4,
      actions: [
        widget.actions ?? const SizedBox.shrink(),
        const SizedBox(width: 10),
        _buildPanicButton(),
      ],
    );
  }

  Widget? _buildBackButton() {
    return ModalRoute.of(context)!.impliesAppBarDismissal &&
            !T.toString().contains('Page')
        ? BackButton(
            onPressed: () => PageNavigator.navigateBack<T>(context),
          )
        : null;
  }

  Widget _buildTitle() {
    TextStyle? style = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.merge(Theme.of(context).appBarTheme.titleTextStyle);

    bool isSmallDevice =
        MediaQuery.of(context).size.width < DeviceSize.SMALL_DEVICE_WIDTH;
    bool isLargeText = widget.title.length > 16;
    if (isSmallDevice || isLargeText) {
      return SizedBox(
        height: kToolbarHeight,
        child: Center(
          child: ScrollingTextWidget(
            text: widget.title,
            textStyle: style,
          ),
        ),
      );
    } else {
      return Text(
        widget.title,
        style: style,
      );
    }
  }

  Widget _buildPanicButton() {
    return PopupMenuButton(
      elevation: 1,
      offset: const Offset(0, 56),
      tooltip: 'Panic button options',
      child: GestureDetector(
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 6),
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        onLongPress: () => _onPanicLongPressed(),
      ),
      itemBuilder: (context) => _buildMenuOptions(context),
      onSelected: (mode) => {},
    );
  }

  List<PopupMenuEntry> _buildMenuOptions(BuildContext context) {
    return <PopupMenuEntry<String>>[
      // PopupMenuItem<String>(
      //   value: 'Crime',
      //   child: Row(
      //     children: [
      //       Icon(
      //         Icons.local_police,
      //         color: Theme.of(context).iconTheme.color,
      //       ),
      //       const SizedBox(width: 10),
      //       const Text("Report a crime"),
      //     ],
      //   ),
      // ),
    ];
  }

  void _onPanicLongPressed() async {
    await Provider.of<MessageService>(
      context,
      listen: false,
    ).sendNotificationAsync(
      AppNotification(
        title: 'Silent Distress Alert',
        message: 'Silent distress alert has been triggered by the user. '
            'Location will be broadcasted to relevant emergency services.',
        notificationText: 'Silent Distress Triggered',
        severity: MessageSeverity.critical,
        type: NotificationType.message,
      ),
      saveAsMessage: true,
    );
    HepaticHelper.strongVibration();
  }

  void _navigateTo<W>(
    Widget widget, {
    TransitionDirection? direction,
  }) {
    PageNavigator.navigateTo<W>(
      context,
      widget,
      // shouldPop: true,
      useScheduler: false,
      direction: direction ?? TransitionDirection.ltr,
    );
  }
}

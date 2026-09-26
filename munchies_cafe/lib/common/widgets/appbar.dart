import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/navigator/page_navigator.dart';
import 'package:munchies_cafe/common/widgets/scrolling_text.dart';

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

class _AppBarWidget<T> extends State<AppBarWidget<T>> {
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
        MediaQuery.of(context).size.width < DeviceSize.smallDeviceWidth;
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
}

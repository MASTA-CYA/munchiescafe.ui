import 'package:munchies_cafe/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/themes/themes_common.dart';
import 'package:munchies_cafe/menu-component/models/menu_category_filter_model.dart';

class MenuCategoryWidget extends StatefulWidget {
  final MenuCategoryFilter category;
  final Function(String category) onCategorySelected;

  const MenuCategoryWidget({
    super.key,
    required this.category,
    required this.onCategorySelected,
  });

  @override
  State<StatefulWidget> createState() => _CatalogueCategoryWidget();
}

class _CatalogueCategoryWidget extends State<MenuCategoryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = ColorTween(
      begin: ThemesCommon.primaryColor,
      end: ThemesCommon.primaryColor,
    ).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _alignAnimation();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _alignAnimation();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                widget.category.text,
                style: Theme.of(context).textTheme.bodyLarge?.merge(
                      TextStyle(
                        fontFamily: FontFamily.PRIMARY,
                        color: _animation.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
            ),
            widget.category.isSelected!
                ? Container(
                    height: 4,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        backgroundBlendMode: BlendMode.modulate,
                        gradient: LinearGradient(
                          stops: const [
                            0,
                            0.25,
                            0.50,
                            0.75,
                            1,
                          ],
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.onPrimary,
                            Theme.of(context).colorScheme.onPrimary,
                            Theme.of(context).colorScheme.onPrimary,
                            Theme.of(context).colorScheme.primary,
                          ],
                        )),
                  )
                : Container(
                    height: 4,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: _animation.value,
                    ),
                  ),
          ],
        ),
        onTap: () => onCategorySelected(widget.category.text),
      ),
    );
  }

  void onCategorySelected(String category) async {
    widget.onCategorySelected(category);
    _animationController.status == AnimationStatus.completed
        ? await _animationController.reverse()
        : await _animationController.forward();
    setState(() {});
  }

  void _alignAnimation() {
    _animationController.reset();
    if (widget.category.isSelected!) {
      _animation = ColorTween(
        begin: Theme.of(context).colorScheme.primary,
        end: Theme.of(context).primaryColor,
      ).animate(_animationController);
    } else {
      _animation = ColorTween(
              begin: Theme.of(context).colorScheme.primary,
              end: Theme.of(context).primaryColor)
          .animate(_animationController);
    }
  }
}

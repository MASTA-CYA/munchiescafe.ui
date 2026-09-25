import 'package:munchies_cafe/common/helpers/color_helper.dart';
import 'package:munchies_cafe/common/helpers/enums/bottom_sheet_modal_size_enum.dart';
import 'package:munchies_cafe/common/widgets/bottom_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/widgets/no_filter_options.dart';

class BottomSheetModalHelper {
  static Future showModal(
    BuildContext context, {
    AnimationController? transitionController,
    Widget? child,
    BottomSheetModalSize size = BottomSheetModalSize.half,
  }) async {
    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / size.height,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        side: BorderSide(
          width: 3.8,
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorHelper.fromHex('#505050')
              : Colors.black,
        ),
      ),
      transitionAnimationController: transitionController,
      builder: (context) => BottomSheetModalWidget(
        child: child ?? const NoFilterOptionsWidget(),
      ),
    );
  }
}

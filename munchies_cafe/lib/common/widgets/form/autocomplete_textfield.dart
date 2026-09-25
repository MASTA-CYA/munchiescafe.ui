import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/models/autocomplete_comparable.dart';

class AutoCompleteTextFieldWidget<T extends AutocompleteComparable>
    extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final List<T> comparables;
  final TextInputAction? inputAction;
  final void Function(T)? onChanged;
  final String? Function(String?)? validator;

  const AutoCompleteTextFieldWidget({
    super.key,
    this.controller,
    required this.label,
    required this.comparables,
    this.inputAction = TextInputAction.done,
    this.onChanged,
    this.validator,
  });

  @override
  State<StatefulWidget> createState() => _AutoCompleteTextFieldWidget();
}

class _AutoCompleteTextFieldWidget<T extends AutocompleteComparable>
    extends State<AutoCompleteTextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<AutocompleteComparable>(
      optionsBuilder: (textEditingValue) =>
          _findAutoCompleteMatch(textEditingValue),
      displayStringForOption: (option) => option.name,
      onSelected: widget.onChanged,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextField(
        controller: textEditingController,
        focusNode: focusNode,
        onEditingComplete: onFieldSubmitted,
        autocorrect: true,
        textInputAction: widget.inputAction,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyLarge?.merge(
                const TextStyle(
                  fontFamily: FontFamily.PRIMARY,
                ),
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }

  Iterable<AutocompleteComparable> _findAutoCompleteMatch(
      TextEditingValue value) {
    if (value.text.isEmpty) {
      return const Iterable<AutocompleteComparable>.empty();
    }
    final Iterable<AutocompleteComparable> nameMatches = widget.comparables
        .where((comparable) => comparable.name.contains(value.text));
    if (nameMatches.isNotEmpty) return nameMatches;
    final Iterable<AutocompleteComparable> descriptionMatches = widget
        .comparables
        .where((comparable) => comparable.description.contains(value.text));
    return descriptionMatches.isNotEmpty
        ? nameMatches
        : const Iterable<AutocompleteComparable>.empty();
  }
}

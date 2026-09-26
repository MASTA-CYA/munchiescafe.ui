import 'package:flutter/material.dart';

class AuthenticateTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final int maxLines;
  final String? Function(String?) validator;
  final String label;
  final String text;
  final String initialValue;
  final TextInputAction? inputAction;
  final void Function(String)? onChanged;
  final bool isNumberInput;
  final bool allowDecimal;
  final bool isReadOnly;
  final bool isSecret;
  final EdgeInsetsGeometry? contentPadding;

  const AuthenticateTextFieldWidget({
    super.key,
    this.controller,
    this.maxLines = 1,
    required this.validator,
    required this.label,
    required this.text,
    this.initialValue = '',
    this.inputAction = TextInputAction.done,
    required this.onChanged,
    this.isNumberInput = false,
    this.allowDecimal = false,
    this.isReadOnly = false,
    this.isSecret = false,
    this.contentPadding,
  });

  @override
  State<StatefulWidget> createState() => _AuthenticateTextFieldWidgetState();
}

class _AuthenticateTextFieldWidgetState
    extends State<AuthenticateTextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: widget.inputAction,
      readOnly: widget.isReadOnly,
      obscureText: widget.isSecret,
      autocorrect: true,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.merge(const TextStyle(color: Colors.white)),
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
        ),
        fillColor: Colors.transparent.withValues(alpha: 0),
        filled: false,
      ),

      // Handles Form Validation
      validator: widget.validator,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
    );
  }
}

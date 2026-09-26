import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:munchies_cafe/authentication-component/widgets/authenticate_button.dart';
import 'package:munchies_cafe/authentication-component/widgets/authenticate_textfield.dart';

class LoginWidget extends StatefulWidget {
  final void Function() onSignInPressed;

  const LoginWidget({
    super.key,
    required this.onSignInPressed,
  });

  @override
  State<StatefulWidget> createState() => _LoginWidget();
}

class _LoginWidget extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: _buildUsernameTextField(),
              ),
              const SizedBox(height: 16),
              Flexible(
                flex: 1,
                child: _buildPasswordTextField(),
              ),
              const Spacer(),

              Flexible(
                flex: 1,
                child: _buildSignButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return AuthenticateTextFieldWidget(
      label: 'Username',
      text: '',
      validator: (value) => null,
      onChanged: (value) {},
    );
  }

  Widget _buildPasswordTextField() {
    return AuthenticateTextFieldWidget(
      isSecret: true,
      label: 'Password',
      text: '',
      validator: (value) => null,
      onChanged: (value) {},
    );
  }

  Widget _buildSignButton() {
    return AuthenticateButtonWidget(
      text: 'Sign In',
      onClicked: widget.onSignInPressed,
    );
  }
}

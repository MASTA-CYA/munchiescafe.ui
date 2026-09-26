import 'package:flutter/material.dart';
import 'package:munchies_cafe/authentication-component/widgets/login.dart';
import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/navigator/page_navigator.dart';
import 'package:munchies_cafe/common/navigator/transition_direction_enum.dart';
import 'package:munchies_cafe/home-component/home_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<StatefulWidget> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: const Image(
                        image: ResizeImage(
                          AssetImage('assets/images/launcher.png'),
                          width: 200,
                          height: 200,
                          allowUpscaling: false,
                        ),
                        color: null,
                        fit: BoxFit.scaleDown,
                        height: 120,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Munchies Café',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.merge(
                                      TextStyle(
                                        fontFamily: FontFamily.primary,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Treats for your sweet tooth',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.merge(
                                      const TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: ResizeImage(
                                AssetImage(
                                    'assets/images/authenticate-background.jpg'),
                                width: 720,
                                height: 656,
                                allowUpscaling: true,
                              ),
                              fit: BoxFit.fill,
                              opacity: 1),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent.withValues(alpha: 0.3),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildNotch(),
                              Expanded(
                                flex: 7,
                                child: LoginWidget(
                                  onSignInPressed: () => _navigateTo<HomePage>(
                                    const HomePage(),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: _buildSocialMediaBar(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildNotch() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 24),
        width: 50,
        height: 6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget _buildSocialMediaBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        'facebook',
        'google',
        'twitter',
      ]
          .map(
            (element) => Material(
              elevation: 4,
              shape: const CircleBorder(),
              color: Theme.of(context).colorScheme.primary,
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ResizeImage(
                      AssetImage('assets/images/$element.png'),
                      width: 80,
                      height: 80,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _navigateTo<T>(
    Widget widget, {
    TransitionDirection direction = TransitionDirection.ltr,
  }) async {
    PageNavigator.navigateTo<T>(
      context,
      widget,
      direction: direction,
      useScheduler: false,
      shouldPop: true,
    );
  }
}

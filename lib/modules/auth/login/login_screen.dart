import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';
import 'widgets/login_form_card_widget.dart';
import 'widgets/login_header_widget.dart';
import 'widgets/login_redirect_prompt_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = AppRoutes.login;
  static void navigateToMe() => navigateTo(name);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // -------------------------- Controller & State -------------------------- //
  late final LoginController _controller = LoginController(AuthCubit.i);

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_refresh);
    _controller.init();
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  // -------------------------- Build -------------------------- //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.paddingScreen,
          vertical: Dimensions.paddingSizeExtraOverLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --------------------------[ Header ]-------------------------- //
            _buildHeader(),
            const SizedBox(height: Dimensions.paddingSizeOverLarge),
            // --------------------------[ Redirect Prompt ]-------------------------- //
            _buildRedirectPrompt(),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            // --------------------------[ Login Form Card ]-------------------------- //
            _buildFormCard(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Header ]-------------------------- //
  Widget _buildHeader() => const LoginHeaderWidget();

  // --------------------------[ Redirect Prompt ]-------------------------- //
  Widget _buildRedirectPrompt() {
    return LoginRedirectPromptWidget(
      onActionTap: _controller.onTapSignUp,
    );
  }

  // --------------------------[ Login Form Card ]-------------------------- //
  Widget _buildFormCard() {
    return LoginFormCardWidget(
      controller: _controller,
    );
  }
}

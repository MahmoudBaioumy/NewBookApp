import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flustra_template/modules/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'register_controller.dart';
import 'widgets/register_form_card_widget.dart';
import 'widgets/register_header_widget.dart';
import 'widgets/register_redirect_prompt_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String name = AppRoutes.register;
  static void navigateToMe() => navigateTo(name);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // -------------------------- Controller & State -------------------------- //
  late final RegisterController _controller = RegisterController(AuthCubit.i);

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
            // --------------------------[ Register Form Card ]-------------------------- //
            _buildFormCard(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Header ]-------------------------- //
  Widget _buildHeader() => const RegisterHeaderWidget();

  // --------------------------[ Redirect Prompt ]-------------------------- //
  Widget _buildRedirectPrompt() {
    return RegisterRedirectPromptWidget(
      onActionTap: _controller.onTapLogin,
    );
  }

  // --------------------------[ Register Form Card ]-------------------------- //
  Widget _buildFormCard() {
    return RegisterFormCardWidget(
      controller: _controller,
    );
  }
}

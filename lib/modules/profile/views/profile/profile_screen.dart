import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/config/app_settings/app_settings_cubit.dart';
import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/base_cubit/base_cubit.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/custom_error_widget.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

import '../../cubit/profile_cubit.dart';
import 'profile_controller.dart';
import 'widgets/profile_edit_button_widget.dart';
import 'widgets/profile_header_widget.dart';
import 'widgets/profile_info_card_widget.dart';
import 'widgets/profile_shimmer_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String name = AppRoutes.profileScreen;
  static void navigateToMe() => navigateTo(name);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --------------------------[ Controller & State ]-------------------------- //
  late final ProfileController _controller = ProfileController(ProfileCubit.i);

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

  // --------------------------[ Build ]-------------------------- //
  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlockBuilderWidget<AppSettingsCubit, AppSettingsCubitTypes>(
      types: const [AppSettingsCubitTypes.theme],
      showOnlyBodyInAllCases: true,
      body: (_) => Scaffold(
        body: _buildBody(),
      ),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: ColoredBox(
          color: AppColors.surface,
          child: _buildScrollableContent(),
        ),
      ),
    );
  }

  // --------------------------[ Scrollable Content ]-------------------------- //
  Widget _buildScrollableContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --------------------------[ Curved Header & Avatar ]-------------------------- //
          _buildHeader(),
          const SizedBox(height: Dimensions.paddingScreen),
          // --------------------------[ Profile Info & Settings Card ]-------------------------- //
          _buildInfoCardSection(),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          // --------------------------[ Edit Profile Button ]-------------------------- //
          _buildEditProfileButtonSection(),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        ],
      ),
    );
  }

  // --------------------------[ Curved Header & Avatar ]-------------------------- //
  Widget _buildHeader() {
    return ProfileHeaderWidget(
      imageUrl: _controller.userImage,
      onLogoutTap: _controller.onTapLogout,
    );
  }

  // --------------------------[ Profile Info & Settings Card ]-------------------------- //
  Widget _buildInfoCardSection() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
      ),
      child: BlockBuilderWidget2<ProfileCubit, dynamic>(
        types: [_controller.profileState],
        body: (_, state) => _buildProfileCardByState(state),
      ),
    );
  }

  // --------------------------[ Profile Card By State ]-------------------------- //
  Widget _buildProfileCardByState(StateType state) {
    if (state == StateType.loading && _controller.hasNoProfileData) {
      return const ProfileShimmerWidget();
    }
    if (state.isError() && _controller.hasNoProfileData) {
      return CustomErrorWidget(
        message: _controller.errorMessage,
        onRetry: _controller.onRetry,
      );
    }
    return ProfileInfoCardWidget(
      controller: _controller,
    );
  }

  // --------------------------[ Edit Profile Button ]-------------------------- //
  Widget _buildEditProfileButtonSection() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingScreen,
      ),
      child: BlockBuilderWidget2<ProfileCubit, dynamic>(
        types: [_controller.updateProfileState],
        body: (_, state) => ProfileEditButtonWidget(
          isLoading: state == StateType.loading,
          onEditProfileTap: _controller.onTapEditProfile,
        ),
      ),
    );
  }
}

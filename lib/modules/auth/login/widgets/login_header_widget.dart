import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/image_asset_widget.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // --------------------------[ Ketaby Logo ]-------------------------- //
        _buildLogo(),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        // --------------------------[ Title ]-------------------------- //
        _buildTitle(),
      ],
    );
  }

  // --------------------------[ Logo ]-------------------------- //
  Widget _buildLogo() {
    return ImageAssetWidget(
      assetPath: AppAssetsImages.logo.ketabyLogo,
      width: Dimensions.logoBoxSize,
      height: Dimensions.logoBoxSize,
      fit: BoxFit.contain,
    );
  }

  // --------------------------[ Title ]-------------------------- //
  Widget _buildTitle() {
    return Text(
      AppStrings.joinUs.tx(),
      textAlign: TextAlign.center,
      style: AppTextStyle.displayLarge.copyWith(color: AppColors.primary),
    );
  }
}

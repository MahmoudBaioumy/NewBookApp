import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';

class ProfileEditButtonWidget extends StatelessWidget {
  // ========================== Constructor ========================== //
  const ProfileEditButtonWidget({
    super.key,
    required this.isLoading,
    required this.onEditProfileTap,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  final bool isLoading;
  final VoidCallback onEditProfileTap;

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerHelper.buildBasicShimmer(
        height: Dimensions.buttonHeightDefault,
        radios: Dimensions.radiusPill,
      );
    }

    return ElevatedButton(
      onPressed: onEditProfileTap,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(
          double.infinity,
          Dimensions.buttonHeightDefault,
        ),
      ),
      child: Text(AppStrings.editProfile.tx()),
    );
  }
}

import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flustra_template/core/helper/widgets/shimmer_helper.dart';
import 'package:flutter/material.dart';

class ProfileShimmerWidget extends StatelessWidget {
  const ProfileShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(Dimensions.paddingScreen),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Dimensions.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          Dimensions.profileFieldShimmerCount,
          (index) => Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: index == Dimensions.profileFieldShimmerCount - 1
                  ? 0
                  : Dimensions.paddingScreen,
            ),
            child: ShimmerHelper.buildBasicShimmer(
              height: Dimensions.profileFieldShimmerHeight,
              radios: Dimensions.radiusDefault,
            ),
          ),
        ),
      ),
    );
  }
}

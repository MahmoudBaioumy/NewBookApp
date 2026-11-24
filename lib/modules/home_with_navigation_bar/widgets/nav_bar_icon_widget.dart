import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
import 'package:flutter/material.dart';

class NavBarIconWidget extends StatelessWidget {
  // ========================== 🔒 Private variables 🔒 ========================== //
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String Function() label;
  final int badgeCount;

  // ========================== Constructor ========================== //
  const NavBarIconWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.label,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: Dimensions.paddingSizeTiny),
            // --------------------------[ Icon ]-------------------------- //
            _buildIcon(),
            if (isSelected) ...[
              const SizedBox(height: Dimensions.paddingSizeMini),
              // --------------------------[ Active Label ]-------------------------- //
              _buildLabel(),
            ],
          ],
        ),
      ),
    );
  }

  // --------------------------[ _buildIcon ]-------------------------- //
  Widget _buildIcon() {
    final iconWidget = Icon(
      icon,
      color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
      size: Dimensions.iconSizeLarge,
    );

    if (badgeCount <= 0) return iconWidget;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        PositionedDirectional(
          top: -Dimensions.paddingSizeTiny,
          end: -Dimensions.paddingSizeExtraSmall,
          child: _buildBadge(),
        ),
      ],
    );
  }

  // --------------------------[ _buildBadge ]-------------------------- //
  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimensions.paddingSizeTiny,
        vertical: Dimensions.paddingSizeMini,
      ),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraSmall),
      ),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          '$badgeCount',
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // --------------------------[ _buildLabel ]-------------------------- //
  Widget _buildLabel() => Text(
    label(),
    style: AppTextStyle.bodySmall.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

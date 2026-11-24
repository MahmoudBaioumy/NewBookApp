import 'dart:ui';

class Dimensions {
  static double? width;

  static void calcWidth() {
    FlutterView view = PlatformDispatcher.instance.views.first;

    double physicalWidth = view.physicalSize.width;
    double devicePixelRatio = view.devicePixelRatio;

    // Physical pixels → logical width used by Flutter
    width = physicalWidth / devicePixelRatio;
  }

  static double fontSizeExtraSmall = (width ?? 100) >= 1300 ? 12 : 10;
  static double fontSizeSmall = (width ?? 100) >= 1300 ? 14 : 12;

  static double fontSizeDefault = (width ?? 100) >= 1300 ? 16 : 14;

  static double fontSizeLarge = (width ?? 100) >= 1300 ? 18 : 16;
  static double fontSizeExtraLarge = (width ?? 100) >= 1300 ? 20 : 18;
  static double fontSizeOverLarge = (width ?? 100) >= 1300 ? 26 : 24;

  static const double paddingSizeMini = 2.0;
  static const double paddingSizeTiny = 4.0;
  static const double paddingSizeExtraSmall = 6.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeH = 12.0;
  static const double paddingSizeDefault = 14.0;
  static const double paddingScreen = 16.0;
  static const double paddingSizeLarge = 18.0;
  static const double paddingSizeExtraLarge = 24.0;
  static const double paddingSizeOverLarge = 28.0;
  static const double paddingSizeExtraOverLarge = 40.0;
  static const double borderWidthThin = 1.0;
  static const double borderWidthDefault = 1.5;
  static const double logoBoxSize = 110.0;
  static const double buttonHeightDefault = 48.0;

  static const double avatarSizeDefault = 48.0;
  static const double iconSizeSmall = 18.0;
  static const double iconSizeDefault = 24.0;
  static const double iconSizeLarge = 28.0;

  static const double bannerTopHeight = 140.0;
  static const double bannerTopViewportFraction = 0.86;
  static const double bannerPromoHeight = 135.0;
  static const double indicatorActiveWidth = 22.0;
  static const double indicatorInactiveSize = 8.0;

  static const double bookCardWidth = 115.0;
  static const double bookCardImageHeight = 160.0;
  static const double bookHorizontalListHeight = 265.0;
  static const double bookListCardImageWidth = 105.0;
  static const double bookListCardImageHeight = 145.0;
  static const int bookListShimmerItemCount = 5;
  static const double bookListTitleShimmerHeight = 20.0;
  static const double bookListSubtitleShimmerHeight = 16.0;
  static const double bookListSubtitleShimmerWidth = 100.0;
  static const double bookListPriceShimmerHeight = 16.0;
  static const double bookListPriceShimmerWidth = 80.0;
  static const double emptyStateIconContainerSize = 80.0;
  static const double emptyStateIconSize = 40.0;
  static const double categoryCardSize = 105.0;

  static const double cartQuantityBoxHeight = 36.0;
  static const double cartQuantityButtonWidth = 34.0;
  static const double cartQuantityMinTextWidth = 28.0;
  static const double cartQuantityBoxShimmerWidth = 105.0;
  static const double cartCheckoutBarHeight = 68.0;
  static const double cartCheckoutButtonHeight = 44.0;
  static const double cartCheckoutButtonHorizontalPadding = 24.0;
  static const double cartCheckoutButtonShimmerWidth = 115.0;
  static const double cartTotalPriceShimmerWidth = 140.0;
  static const double cartTotalPriceShimmerHeight = 20.0;
  static const int checkoutUserFieldShimmerCount = 4;
  static const int checkoutOrderItemShimmerCount = 2;
  static const double checkoutOrderItemShimmerHeight = 56.0;
  static const double checkoutSectionTitleShimmerWidth = 140.0;
  static const double checkoutSectionTitleShimmerHeight = 20.0;

  static const double bookDetailsCoverHeight = 410.0;
  static const double bookDetailsButtonHeight = 54.0;
  static const double bookDetailsOverlayOpacity = 0.35;
  static const double bookDetailsTitleShimmerHeight = 28.0;
  static const double bookDetailsTitleShimmerWidth = 220.0;
  static const double bookDetailsSubtitleShimmerHeight = 18.0;
  static const double bookDetailsSubtitleShimmerWidth = 110.0;
  static const double bookDetailsPriceShimmerWidth = 80.0;
  static const double bookDetailsDescShimmerHeight = 140.0;

  static const double profileHeaderCurveHeight = 165.0;
  static const double profileHeaderCurveDepth = 45.0;
  static const double profileHeaderTotalHeight = 235.0;
  static const double profileAvatarSize = 140.0;
  static const double profileAvatarBorderWidth = 4.0;
  static const double profileFieldShimmerHeight = 52.0;
  static const int profileFieldShimmerCount = 5;
  static const double selectorContainerPadding = 3.0;
  static const double selectorTabHorizontalPadding = 10.0;
  static const double selectorTabVerticalPadding = 6.0;
  static const double selectorTabRadius = 16.0;
  static const double selectorContainerRadius = 20.0;
  static const double selectorIconSize = 16.0;

  static const double shadowBlurDefault = 8.0;
  static const double shadowOffsetDefault = 4.0;

  static const double radiusExtraSmall = 6.0;
  static const double radiusSmall = 10.0;
  static const double radiusMedium = 14.0;
  static const double radiusDefault = 14.0;
  static const double radiusLarge = 18.0;
  static const double radiusExtraLarge = 24.0;
  static const double radiusPill = 999.0;

  static const double webMaxWidth = 1170;
  static const int messageInputLength = 250;
  static const double pickMapIconSize = 100.0;
  static const double maxLimitOfFileSentINConversation = 25;
  static const double maxLimitOfTotalFileSent = 5;
  static const double maxSizeOfASingleFile = 10;
  static const double maxImageSend = 10;
  static const double limitOfPickedVideoSizeInMB = 50;
}

part of '../user_profile.dart';

class _UsersProfileCards extends GetView<UserProfileController> {
  const _UsersProfileCards();

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          childAnimationBuilder: (ch) => SlideAnimation(
            verticalOffset: 0.1.sh,
            child: FadeInAnimation(child: ch),
          ),
          children: [
            // Your Orders
            GestureDetector(
              onTap: controller.yourOrdersOnTapHandler,
              child: ContainerCard(
                shadowStyle: ShadowStyle.style1,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    SvgHelper.userProfileCard(
                      type: UserProfileCards.orders,
                    ),
                    const Spacer(),
                    _cardsText(text: 'Your Orders')
                  ],
                ),
              ),
            ),
            // Fav Restaurant
            GestureDetector(
              onTap: controller.favRestOnTapHandler,
              child: ContainerCard(
                shadowStyle: ShadowStyle.style1,
                padding: const EdgeInsets.only(top: 12),
                boxConstraints: BoxConstraints(minWidth: 1.sw),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgHelper.userProfileCard(
                      type: UserProfileCards.favRestaurant,
                    ),
                    Positioned.fill(
                      top: 12,
                      right: 20,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 150.r,
                          child: _cardsText(
                            text: 'Favorite Restaurants',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Feedbacks
            ContainerCard(
              shadowStyle: ShadowStyle.style1,
              padding: const EdgeInsets.only(top: 12),
              boxConstraints: BoxConstraints(minWidth: 1.sw),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgHelper.userProfileCard(
                    type: UserProfileCards.feedbacks,
                  ),
                  Positioned.fill(
                    left: 34,
                    bottom: 30,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: 150.r,
                        child: _cardsText(
                          text: 'Feedbacks',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardsText({required String text, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: Get.theme.customColor()?.text06,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        fontSize: 24.r,
      ),
    );
  }
}

part of '../feedback.dart';

class _FeedbackRatings extends GetView<FeedbackController> {
  const _FeedbackRatings();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () {
            if (controller.isKeyboardOpen.value) {
              return const SizedBox.shrink();
            }
            var ratings = controller.rating.value;
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                foregroundDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(1.0 - (ratings / 5.0)),
                  backgroundBlendMode: BlendMode.saturation,
                ),
                height: 0.2.sh,
                child: SvgHelper.ratingsFace(
                  key: ValueKey(ratings),
                  faceType: RatingFaces.values[ratings.round() - 1],
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: RatingBar(
            minRating: 1,
            maxRating: 5,
            initialRating: 3,
            itemCount: 5,
            itemSize: 42,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_rounded,
                color: Get.theme.primaryColor,
              ),
              half: Icon(
                Icons.star_half_rounded,
                color: Get.theme.primaryColor,
              ),
              empty: Icon(
                Icons.star_border_rounded,
                color: Get.theme.primaryColor,
              ),
            ),
            onRatingUpdate: (rating) {
              controller.rating.value = rating;
            },
            direction: Axis.horizontal,
            glow: false,
          ),
        )
      ],
    );
  }
}

part of '../new_user.dart';

class _NewUserNextButton extends GetView<NewUserController> {
  const _NewUserNextButton();

  bool get isDisabled {
    return controller.currentPage.value == 2 &&
        !controller.isEmailVerified.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: isDisabled ? null : controller.onTapHandler,
        child: AnimatedContainer(
          duration: controller.animDuration,
          foregroundDecoration: controller.isLoading.value
              ? BoxDecoration(
                  color: Colors.grey.withOpacity(1),
                  backgroundBlendMode: BlendMode.saturation,
                )
              : null,
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: isDisabled
                ? Colors.grey
                : controller.buttonStyle!.buttonGradient.colors.last,
            shadows: [
              BoxShadow(
                color: controller.buttonStyle!.buttonShadowColor,
                blurRadius: 7,
                offset: const Offset(2, 4),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 36,
            vertical: 4,
          ),
          alignment: Alignment.center,
          height: 50,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (ch, ani) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(ani),
                child: ch,
              );
            },
            child: controller.isLoading.value
                ? const Center(
                    key: ValueKey(0),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    controller.buttonText,
                    key: const ValueKey(1),
                    style: TextStyle(
                      color: controller.buttonStyle!.buttonTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      );
    });
  }
}

part of '../feedback.dart';

class _FeedbackInput extends GetView<FeedbackController> {
  const _FeedbackInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.black.withOpacity(0.06),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Share your thoughts',
                style: controller.fontStyles?.header2,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Get.theme.cardColor,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                margin: const EdgeInsets.only(top: 12),
                constraints: const BoxConstraints(maxWidth: 350, minHeight: 60),
                child: TextFormField(
                  controller: controller.inputController,
                  style: TextStyle(
                    color: Get.theme.customColor()?.text04,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 2,
                  enableSuggestions: false,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Say Something...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Get.theme.customColor()?.text04?.withOpacity(0.6),
                    ),
                    counter: const Offstage(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

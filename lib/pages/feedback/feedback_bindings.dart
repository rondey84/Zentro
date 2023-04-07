import 'package:get/get.dart';
import 'package:zentro/pages/feedback/feedback_controller.dart';

class FeedbackBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
  }
}

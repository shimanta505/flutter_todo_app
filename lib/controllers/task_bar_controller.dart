import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskBarController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString endTime = "9:30 PM".obs;
  RxString startTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  RxInt selectedRemind = 5.obs;
  List<int> remindList = [5, 10, 15, 20, 25].obs;
  RxString selectedRepeat = "none".obs;
  List<String> repeatList = ["none", "daily", "weekly", "monthly"].obs;
  RxInt selectedColor = 0.obs;
}

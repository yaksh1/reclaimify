import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //* slide show dimensions
  // 803/220 = 3.65
  static double slideShowWholeContainer = screenHeight / 2.50;
  static double slideShowContainer = screenHeight / 3.65;
  static double slideShowTextContainer = screenHeight / 5.74;

  // heights and width and radius
  static double height10 = screenHeight / 80.3;
  static double width10 = screenWidth / 39.28;
  static double radius10 = screenHeight / 80.3;

}

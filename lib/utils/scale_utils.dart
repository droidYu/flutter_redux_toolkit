class ScaleUtils {
  static int dw = 375;
  static int dh = 812;

  static double scaleByDeviceWidth(double oriWidth, double width) =>
      oriWidth * width / dw;

  static double scaleByDeviceHeight(double oriHeight, double height) =>
      oriHeight * height / dh;
}

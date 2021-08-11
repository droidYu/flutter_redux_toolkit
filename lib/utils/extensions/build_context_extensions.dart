import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/utils/scale_utils.dart';

extension BuildContextScaleByDimention on BuildContext {
  double scaleByDeviceWidth(double oriWidth) {
    var size = MediaQuery.of(this).size;
    return ScaleUtils.scaleByDeviceWidth(oriWidth, size.width);
  }

  double scaleByDeviceHeight(double oriHeight) {
    var size = MediaQuery.of(this).size;
    return ScaleUtils.scaleByDeviceHeight(oriHeight, size.height);
  }
}

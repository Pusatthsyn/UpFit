import 'package:flutter/widgets.dart';

enum DeviceType {
  mobile,
  tablet,
}

DeviceType getDeviceType(BuildContext context) {
  final double deviceWidth = MediaQuery.of(context).size.shortestSide;

  if (deviceWidth > 600) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mobile;
  }
}

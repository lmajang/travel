import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermission{
  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  static Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
  /// 动态申请定位权限
  static void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
      // getPositionPermission = true;
      // _startLocation();
    } else {
      print("定位权限申请不通过");
    }
  }
}



import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel/common/Config.dart';

class mapScreen extends StatefulWidget {
  const mapScreen({super.key});

  @override
  State<mapScreen> createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen>{
  String _latitude = ""; //纬度
  String _longitude = ""; //经度
  String country = ""; // 国家
  String province = ""; // 省份
  String city = ""; // 市
  String district = ""; // 区
  String street = ""; // 街道
  String adCode = ""; // 邮编
  String address = ""; // 详细地址
  String cityCode = ""; //区号
  // 实例化
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  // 监听定位
  late StreamSubscription<Map<String, Object>> _locationListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 动态申请定位权限
    requestPermission();

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyShow(true, true);

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      print(result);

      setState(() {
        _latitude = result["latitude"].toString();
        _longitude = result["longitude"].toString();
        country = result['country'].toString();
        province = result['province'].toString();
        city = result['city'].toString();
        district = result['district'].toString();
        street = result['street'].toString();
        adCode = result['adCode'].toString();
        address = result['address'].toString();
        cityCode = result['cityCode'].toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    ///移除定位监听
    if (null != _locationListener) {
      _locationListener.cancel();
    }

    ///销毁定位
    if (null != _locationPlugin) {
      _locationPlugin.destroy();
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
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

  ///设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = false;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.ZH;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  ///开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();

    }
  }

  ///停止定位
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }



  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(30.22753386223114, 120.04012871067401),//39.909187 116.397451 30.22753386223114, 120.04012871067401
    zoom: 10.0,
  );
  List<Widget> _approvalNumberWidget = [];
  late Size screenSize= MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    ///使用默认属性创建一个地图
    final AMapWidget map = AMapWidget(
      privacyStatement: mapConfig.amapPrivacyStatement,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: onMapCreated,
    );
    return Scaffold(
        body: SafeArea(
            child: Stack(
                children:[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: map,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 20, right: 20),
                      child: Column(
                          children:[
                            Column(
                                children:[
                                  Text("经度:$_longitude"),
                                  Text("纬度:$_latitude"),
                                  Text('国家：$country'),
                                  Text('省份：$province'),
                                  Text('城市：$city'),
                                  Text('区：$district'),
                                  Text('城市编码：$cityCode'),
                                  Text('街道：$street'),
                                  Text('邮编：$adCode'),
                                  Text('详细地址：$address'),
                                  SizedBox(height: 20),
                                ]
                            ),
                            ElevatedButton(
                              child: const Text('开始定位'),
                              onPressed: () {
                                _startLocation();
                              },
                            ),
                            ElevatedButton(
                              child: const Text('停止定位'),
                              onPressed: () {
                                _stopLocation();
                              },
                            ),
                          ]
                      )
                  )
                ]
            )
        )
    );
  }
  late AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      getApprovalNumber();
    });
  }
  void getApprovalNumber() async {
    //普通地图审图号
    String? mapContentApprovalNumber =
    await _mapController.getMapContentApprovalNumber();
    //卫星地图审图号
    String? satelliteImageApprovalNumber =
    await _mapController.getSatelliteImageApprovalNumber();
    setState(() {
      if (null != mapContentApprovalNumber) {
        _approvalNumberWidget.add(Text(mapContentApprovalNumber));
      }
      if (null != satelliteImageApprovalNumber) {
        _approvalNumberWidget.add(Text(satelliteImageApprovalNumber));
      }
    });
    print('地图审图号（普通地图）: $mapContentApprovalNumber');
    print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
  }

  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
    await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }
}


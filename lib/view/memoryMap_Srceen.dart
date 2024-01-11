import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import  'package:travel/common/Config.dart';
import '../aMap_tool/getLocationPermission.dart';
import '../aMap_tool/initMapOption.dart';

class MemoryMapSrceen extends StatefulWidget {
  List<LatLng> LatLngPions;

  MemoryMapSrceen({Key? key,required List<LatLng> this.LatLngPions}): super(key: key);
  
  @override
  State<MemoryMapSrceen> createState() => _MemoryMapSrceenState();
}

class _MemoryMapSrceenState extends State<MemoryMapSrceen> {
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
    LocationPermission.requestPermission();

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      MapOption.requestAccuracyAuthorization(_locationPlugin);
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
    if (null != _locationListener) {
      _locationListener.cancel();
    }

    ///销毁定位
    if (null != _locationPlugin) {
      _locationPlugin.destroy();
    }
  }


  List<Widget> _approvalNumberWidget = [];
  List<Marker> _markers = [];

  ///添加一个marker
  void _UserMarker(LatLng UserPosition) {
    final _markerPosition = UserPosition;
    final Marker marker = Marker(
      position: _markerPosition,
      //使用默认hue的方式设置Marker的图标
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );
    //调用setState触发AMapWidget的更新，从而完成marker的添加
    setState(() {
      //将新的marker添加到map里
      _markers.add(marker);
    });
  }

  void _UserMarkerList({required List<LatLng> LatLngPions}){
    for(int i=0;i<LatLngPions.length;i++){
      _UserMarker(LatLngPions[i]);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    _UserMarkerList(LatLngPions: widget.LatLngPions);
    Size scrSize = MediaQuery.of(context).size;

    CameraPosition _kInitialPosition = CameraPosition(
        target: LatLng(30.22753386223114, 120.04012871067401),//39.909187 116.397451 30.22753386223114, 120.04012871067401
        zoom: 25.0,
        //俯仰角0°~45°（垂直与地图时为0）
        tilt: 30,
        //偏航角 0~360° (正北方为0)
        bearing: 0
    );

    // final Marker de_marker = Marker(
    //   position: destination,
    //   //使用默认hue的方式设置Marker的图标
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    // );
    // if(_markers.isEmpty)
    //   _markers.add(de_marker);

    ///使用默认属性创建一个地图
    final AMapWidget map = AMapWidget(
      privacyStatement: mapConfig.amapPrivacyStatement,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: onMapCreated,
      markers: Set<Marker>.of(_markers),
    );

    return Scaffold(
        body: SafeArea(
          child: Stack(
            children:[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: map,
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
}

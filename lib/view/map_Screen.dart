
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel/common/Config.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;


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
  late LatLng userPosition;
  //目的地
  bool getPositionPermission = false;
  final LatLng destination = LatLng(39.90816,116.434446);
  LatLng center = LatLng(39.90816,116.434446);
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

        double do_latitude = double.parse(_latitude);
        double do_longitude = double.parse(_longitude);
        String str_latitude = do_latitude.toStringAsFixed(6);
        String str_longitude = do_longitude.toStringAsFixed(6);
        userPosition = LatLng(double.parse(str_latitude), double.parse(str_longitude));
        print(str_longitude);
        _UserMarker(userPosition);
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

  /// 动态申请定位权限
  void requestPermission() async {
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
  List<Marker> _markers = [];

  ///添加一个marker
  void _UserMarker(LatLng UserPosition) {
    final _markerPosition = UserPosition;
    print(_markerPosition);
    final Marker marker = Marker(
      position: _markerPosition,
      //使用默认hue的方式设置Marker的图标
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );
    //调用setState触发AMapWidget的更新，从而完成marker的添加
    setState(() {
      if(_markers.length>1){
        _markers.removeLast();
      }
      //将新的marker添加到map里
      _markers.add(marker);

    });
  }

  //添加路径
  final Map<String, Polyline> _polylines = <String, Polyline>{};

  List<LatLng> LatLng_points =[];

  Future<void> _structure_line(LatLng origin, LatLng destination) async {

    LatLng_points = await _getAMapPointData(origin,destination);
    LatLng_points.insert(0, origin);
    LatLng_points.add(destination);
    final Polyline polyline = Polyline(
        width: 15,
        customTexture: 
              BitmapDescriptor.fromIconPath('assets/images/wenli.png'),
        color: Colors.greenAccent,
        joinType: JoinType.round,
        points: LatLng_points,
        );
    setState(() {
      _polylines[polyline.id] = polyline;
    });
  }



  List<Widget> _approvalNumberWidget = [];
  late Size screenSize= MediaQuery.of(context).size;


  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;

    CameraPosition _kInitialPosition = CameraPosition(
        target: center,//39.909187 116.397451 30.22753386223114, 120.04012871067401
        zoom: 25.0,
        //俯仰角0°~45°（垂直与地图时为0）
        tilt: 30,
        //偏航角 0~360° (正北方为0)
        bearing: 0
    );

    final Marker de_marker = Marker(
      position: destination,
      //使用默认hue的方式设置Marker的图标
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );
    if(_markers.isEmpty)
        _markers.add(de_marker);

    ///使用默认属性创建一个地图
    final AMapWidget map = AMapWidget(
      privacyStatement: mapConfig.amapPrivacyStatement,
      initialCameraPosition: _kInitialPosition,
      onMapCreated: onMapCreated,
      markers: Set<Marker>.of(_markers),
      polylines: Set<Polyline>.of(_polylines.values),
    );

    return MaterialApp(
      //
      navigatorObservers: [FlutterSmartDialog.observer],
        //
      builder: FlutterSmartDialog.init(),
      home:Scaffold(
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
                                  // Column(
                                  //     children:[
                                  //       Text("经度:$_longitude"),
                                  //       Text("纬度:$_latitude"),
                                  //       SizedBox(height: 20),
                                  //     ]
                                  // ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: scrSize.height-140, left: scrSize.width-110),
                                  child:ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(), // 圆形按钮
                                      backgroundColor:Colors.grey,
                                      minimumSize: Size(20,40),
                                    ),
                                    child: Center(
                                        child: Icon(
                                            Icons.directions_walk,
                                            color: Colors.white, // 图标的颜色
                                          ),
                                    ),
                                    onPressed: () {
                                      if(!getPositionPermission)
                                        showGetPositionDialog();
                                      if(!getPositionPermission) return;
                                      _structure_line(userPosition, destination);//userPosition
                                      setState(() {
                                        center = userPosition;
                                        _mapController.moveCamera(CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            //中心点
                                              target: center,
                                              //缩放级别
                                              zoom: 18,
                                              //俯仰角0°~45°（垂直与地图时为0）
                                              tilt: 30,
                                              //偏航角 0~360° (正北方为0)
                                              bearing: 0),
                                            )
                                          );
      ;                                  }
                                      );
                                    },
                                  ),
                          ),
                            // ElevatedButton(
                            //   child: const Text('停止定位'),
                            //   onPressed: () {
                            //     _stopLocation();
                            //   },
                            // ),
                          ]
                      )
                  )
                ]
            )
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

  Future<List<LatLng>> _getAMapPointData(LatLng origin,LatLng destination) async {
    String url ='https://restapi.amap.com/v3/direction/walking?origin=${origin.longitude},${origin.latitude}&destination=${destination.longitude},${destination.latitude}&key=${mapConfig.lineKey}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      List<LatLng> points = <LatLng>[];
      List<String> str_points = <String>[];
      List<String> point_coord = <String>[];

      for(int i =0;i<map['route']['paths'][0]['steps'].length;i++){
        str_points = map['route']['paths'][0]['steps'][i]['polyline'].split(';');
        for(int j=0;j<str_points.length;j++){
          point_coord = str_points[j].split(',');
          points.add(LatLng(double.parse(point_coord[1]),double.parse(point_coord[0])));
        }
      }
      return points;
    }
    else{
      print('Error: ${response.statusCode}');
      throw Exception('${response.statusCode}');
    }
  }

  void showGetPositionDialog(){
    SmartDialog.show(
      backDismiss: false,
      clickMaskDismiss: false,
      builder: (_) {
        return Container(
          height: 300,
          width: 300,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                // title
                Text(
                  '提示',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                // content
                Text('现在将获取你的定位，请确定是否同意'),

                // button (only method of close the dialog)
                ElevatedButton(
                  onPressed: () {
                    getPositionPermission =true;
                    _startLocation();
                    SmartDialog.dismiss();
                  },
                  child: Text('同意'),
                ),
                ElevatedButton(
                  onPressed: () => SmartDialog.dismiss(),
                  child: Text('取消'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}


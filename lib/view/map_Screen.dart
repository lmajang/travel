
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
import 'package:travel/view/test.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

import '../aMap_tool/DistanceCalculator.dart';
import '../aMap_tool/getLocationPermission.dart';
import '../aMap_tool/initMapOption.dart';
import '../widgets/crop_result_view.dart';


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
  late double UserandDestdistance = 10000000000000000;
  bool isCheck = false;
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

        double do_latitude = double.parse(_latitude);
        double do_longitude = double.parse(_longitude);
        String str_latitude = do_latitude.toStringAsFixed(6);
        String str_longitude = do_longitude.toStringAsFixed(6);
        userPosition = LatLng(double.parse(str_latitude), double.parse(str_longitude));
        _UserMarker(userPosition);
        UserandDestdistance =  DistanceCalculator.calculateDistance(userPosition.latitude,userPosition.longitude,destination.latitude,destination.longitude);
        print(UserandDestdistance);
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
                  Positioned(
                    top: scrSize.height - 150,
                    left: scrSize.width - 70,
                    child: ElevatedButton(
                      onPressed: () {
                        if(isCheck){
                          SmartDialog.showToast('你已经打过卡了');
                          return;
                        }
                        if(UserandDestdistance>20){
                          SmartDialog.showToast('打卡失败，请到目标点附近打卡');
                          return;
                        }
                        else {
                          SmartDialog.showToast('打卡成功');
                          showUpPicDialog();
                          isCheck = true;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), // 圆形按钮
                        backgroundColor:Colors.grey,
                        minimumSize: Size(20,40),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle_outlined,
                          color: Colors.white, // 图标的颜色
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: scrSize.height- 100,
                    left: scrSize.width - 70,
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
                        _structure_line(userPosition, destination);
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
                        }
                        );
                      },
                    ),
                  ),
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
                    MapOption.startLocation(_locationPlugin,onceLocation: false);
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

  void showUpPicDialog(){
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
                Text('是否需要分享图片'),

                // button (only method of close the dialog)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return WeChatCameraPicker();
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(position: offsetAnimation, child: child);
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                    SmartDialog.dismiss();
                  },
                  child: Text('是'),
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


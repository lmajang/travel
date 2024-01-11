import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_z_location/flutter_z_location.dart';
import 'package:get/get.dart' hide Response,FormData;
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:travel/const.dart';

import 'package:bottom_sheet/bottom_sheet.dart';

import '../common/Config.dart';
import 'Home_Screen.dart';
import 'map_Screen.dart';

class VistiScreen extends StatefulWidget {
  List ImagesList;

  dynamic showAvatatList;

  dynamic VisionScreenDataList;

  dynamic UploadDateList;

  dynamic Adress;

  dynamic issupport;

  List showLabelList;

  VistiScreen({
    super.key,
    required List<dynamic> this.ImagesList ,
    required dynamic this.showAvatatList,
    required dynamic this.VisionScreenDataList,
    required dynamic this.UploadDateList,
    required dynamic this.Adress,
    required dynamic this.issupport,
    required List<dynamic> this.showLabelList,
  });

  @override
  State<VistiScreen> createState() => _VistiScreenState();
}

class _VistiScreenState extends State<VistiScreen> {
  Dio dio =Dio();
  late bool isButtonPressed ;
  late String supports;
  late String short_desrcribe;
  bool isLongPressed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.issupport.issupport[0] == 'y') isButtonPressed =true;
    else isButtonPressed =false;
    if(widget.VisionScreenDataList['description'].length<8)
      short_desrcribe = widget.VisionScreenDataList['description'];
    else {
      short_desrcribe = widget.VisionScreenDataList['description'].substring(0,7)+'...';
    }
    supports = widget.VisionScreenDataList['support'].toString();
  }

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    // height: scrSize.height,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //     image: NetworkImage('https://t7.baidu.com/it/u=1956604245,3662848045&fm=193&f=GIF'),
                    //   //image: AssetImage("assets/images/test.jpg"),
                    //   fit: BoxFit.cover,
                    // )),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: const Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                  ),
                                ),
                              ),
                              SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: scrSize.height,
                  width: scrSize.width,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.ImagesList.length,
                    itemBuilder: (BuildContext context,
                        int index) =>
                        Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            width: scrSize.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                  NetworkImage(appConfig.ImageIpconfig +
                                      widget.ImagesList[index]['image']),
                                  fit: BoxFit.cover,
                                )),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: const [
                                    //Icon(
                                    //Icons.map,
                                    //),
                                  ],
                                ),
                                const Spacer(),
                                // Row(
                                //   children: [
                                //     Text(
                                //       CityList[index],
                                //       style: const TextStyle(
                                //           color: Colors.white,
                                //           fontWeight:
                                //           FontWeight.w500),
                                //     )
                                //   ],
                                // )
                              ],
                            )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: scrSize.height-45, left: 33),
                      child:GestureDetector(
                        onLongPress: () {
                          setState(() {
                            isLongPressed = true;
                          });
                        },
                        onLongPressEnd: (details) {
                          setState(() {
                            isLongPressed = false;
                          });
                        },
                          child:ElevatedButton(
                            onPressed: () {
                              showFlexibleBottomSheet<void>(
                                minHeight: 0,
                                initHeight: 0.5,
                                maxHeight: 0.5,
                                  isCollapsible:false,
                                context: context,
                                builder: (BuildContext context, ScrollController scrollController, double bottomSheetOffset) {
                                          return _buildBottomSheet(
                                              context,
                                              scrollController,
                                              bottomSheetOffset,
                                              scrSize:scrSize,
                                              description: widget.VisionScreenDataList['description'],
                                              supports: supports,
                                              sceneryname: widget.VisionScreenDataList['sceneryname'],
                                              uploadtime: widget.UploadDateList['datejudge'],
                                              adress:widget.Adress,
                                              showLabelList: widget.showLabelList,

                                          );
                                }
                                  );
                                },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent, // 设置为透明色
                                onPrimary: Colors.black,
                                side: BorderSide.none,
                                shadowColor: Colors.transparent,
                                enableFeedback:false,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // 设置为直角
                              ),
                            ),

                            child: Text(short_desrcribe,
                                style: TextStyle(
                                  color: isLongPressed ? Colors.white70 : Colors.black,
                                  decoration: isLongPressed ? TextDecoration.underline : TextDecoration.none,
                                  fontSize: 15.0, )
                            ),
                          ),
                      ),
                ),
                Positioned(
                    top: scrSize.height-200,
                    left: scrSize.width-75,
                    child: GestureDetector(
                      onTap: () async {
                        {
                          // 切换按钮状态
                          isButtonPressed = !isButtonPressed;
                          if(isButtonPressed){

                            Response response = await dio.post(
                              appConfig.ipconfig+'/support',
                              data: await createSupportFormData(
                                  userid:widget.VisionScreenDataList['userid'],
                                  sceneryid: widget.VisionScreenDataList['sceneryid'],
                                  support: 'yes'),
                            );
                            print(response.data);
                            supports = response.data;
                          }else{
                            Response response = await dio.post(
                              appConfig.ipconfig+'/support',
                              data: await createSupportFormData(
                                  userid:widget.VisionScreenDataList['userid'],
                                  sceneryid: widget.VisionScreenDataList['sceneryid'],
                                  support: 'no'
                              ),
                            );
                            supports = response.data;
                          }
                        }
                        setState((){
                          isButtonPressed = isButtonPressed;
                          supports = supports;
                        }
                        );
                      },
                      child: Icon(
                        isButtonPressed ? TDIcons.heart_filled:TDIcons.heart,
                        color: isButtonPressed ?Colors.redAccent:Colors.black,
                        size: 50,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 15, // Shadow position
                          )
                        ],

                        // child: Icon(
                        //   Icons.favorite,
                        //   color: isButtonPressed ? Colors.redAccent:Colors.white70,
                        //   ),
                      ),
                    )
                ),

                // 头像和用户名
                Positioned(
                  left: 10.0, // 距离左边的距离
                  bottom: 30.0, // 距离底部的距离
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0, // 头像半径
                        backgroundImage: NetworkImage(appConfig.ImageIpconfig +widget.showAvatatList['avatar']), // 头像图片
                      ),
                      SizedBox(width: 10.0), // 间隔
                      Text(
                        widget.showAvatatList['name'],
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
    {   required Size scrSize,
        required String description,
        required String supports,
        required String sceneryname,
        required String uploadtime,
        required String adress,
        required List showLabelList,
    }
    ){

  return Material(
    child: Container(
        height: scrSize.height*0.5,
        child: ListView(
          controller: scrollController,
          shrinkWrap: false,
          children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF4F5F9),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
            child: Padding(
              padding:
              const EdgeInsets.only(left: 17, right: 17, top: 29),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sceneryname,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            TDIcons.heart_filled,
                              color: Colors.redAccent,
                              shadows: [
                                BoxShadow(
                                color: Colors.black,
                                blurRadius: 15, // Shadow position
                                  )
                                ],
                            ),

                          Text(supports)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Row(
                          children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                            Text(
                              adress,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            )
                        ]
                      ),
                      Row(
                        children:  [
                          Icon(
                            Icons.share_arrival_time,
                            color: Colors.grey,
                          ),
                          Text(
                            uploadtime,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 60.0,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: showLabelList.length,
                      itemBuilder: (BuildContext context, int index) => Container(
                          padding: const EdgeInsets.all(10),
                          //margin: const EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(10),
                          //     boxShadow: const [
                          //       BoxShadow(
                          //         color: Colors.grey,
                          //         blurRadius: 4,
                          //         offset: Offset(
                          //           4,
                          //           8,
                          //         ), // Shadow position
                          //       ),
                          //     ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TDTag(
                                showLabelList[index].label,
                                backgroundColor:Colors.white,
                                size: TDTagSize.extraLarge,
                              ),

                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                            description,
                          style: TextStyle(
                            color: Color(0xff868889),
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => mapScreen()));
                            },
                          child:Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          offset: Offset(
                                            4,
                                            8,
                                          ), // Shadow position
                                        ),
                                      ]),
                                  child: const Icon(Icons.map),
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                color: Colors.redAccent,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    offset: Offset(
                                      4,
                                      8,
                                    ), // Shadow position
                                  ),
                                ]),
                            child: const Center(
                                child: Text(
                                  "Book Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ))),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )
        ]
      ),
    ),
  );
}

Future<FormData> createSupportFormData({
  required String userid,
  required String sceneryid,
  required String support
} ) async {
  return FormData.fromMap({
    'support':support,
    'userid':userid ,
    'sceneryid': sceneryid,
  });
}

Future<Text> fetchDataAndBuildText() async {
  LatLng coordinate = LatLng(30.22753386223114, 120.04012871067401);//39.909187 116.397451 30.22753386223114, 120.04012871067401
  final res1 = await FlutterZLocation.geocodeCoordinate(
      coordinate.latitude, coordinate.longitude, pathHead: 'assets/');
  final ipText = Text(
    res1.province+res1.city+res1.district,
    style: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 15),
  );
  return ipText;
}



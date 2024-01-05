import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_z_location/flutter_z_location.dart';
import 'package:get/get.dart';
import 'package:travel/const.dart';

import 'package:bottom_sheet/bottom_sheet.dart';

import 'Home_Screen.dart';
import 'map_Screen.dart';

class VistiScreen extends StatefulWidget {
  const VistiScreen({super.key});

  @override
  State<VistiScreen> createState() => _VistiScreenState();
}

class _VistiScreenState extends State<VistiScreen> {
  int time =10;
  bool isButtonPressed =false;

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    bool isLongPressed = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: scrSize.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/test.jpg"),
                      fit: BoxFit.cover,
                    )),
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
                                  Get.offAll(HomeScreen());
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: const Icon(
                                      Icons.arrow_back_ios_new_outlined),
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // 切换按钮状态
                                  isButtonPressed = !isButtonPressed;
                                });
                              },
                              child:Container(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.favorite,
                                  color: isButtonPressed ? Colors.redAccent:Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: scrSize.height-45, left: 0),
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
                                maxHeight: 0.6,
                                context: context,
                                builder: _buildBottomSheet
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

                            child: Text('username',
                                style: TextStyle(
                                  color: isLongPressed ? Colors.blue : Colors.black,
                                  decoration: isLongPressed ? TextDecoration.underline : TextDecoration.none,
                                  fontSize: 18.0, )
                            ),
                          ),
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
    ){
  int time =10;

  return Material(
    child: Container(
      child: ListView(
          controller: scrollController,
          shrinkWrap: true,
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
                        "Welcome back !",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                          Text(time.toString())
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
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
                            FutureBuilder<Text>(
                              future: fetchDataAndBuildText(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  // 异步操作完成后，插入 Text widget 到 Widget 树
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data ?? Container(),
                                      // 显示 Text widget
                                      // 其他的 Widgets 可以继续添加
                                    ],
                                  );
                                } else {
                                  // 异步操作还未完成，可以显示加载指示器等
                                  return CircularProgressIndicator();
                                }
                              }
                            ),
                        ]
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.share_arrival_time,
                            color: Colors.grey,
                          ),
                          Text(
                            'time',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 60.0,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: SuggestList.length,
                      itemBuilder: (BuildContext context, int index) => Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                    SuggestList[index],
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ))
                            ],
                          )),
                    ),
                  ),
                  Row(
                    children: const [
                      Flexible(
                        child: Text(
                          "Lahore is the second most populous city in Pakistan after Karachi and 26th most populous city in the world, with a population of over 13 million. It is situated in north-east of the country close to the International border with India. It is the capital of the province of Punjab where it is the largest city.",
                          style: TextStyle(
                            color: Color(0xff868889),
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 150.0,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: ImagesList.length,
                      itemBuilder: (BuildContext context,
                          int index) =>
                          Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image:
                                    AssetImage(ImagesList[index]),
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
                                  Row(
                                    children: [
                                      Text(
                                        CityList[index],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              )),
                    ),
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

Future<Text> fetchDataAndBuildText() async {
  LatLng coordinate = LatLng(30.22753386223114, 120.04012871067401);//39.909187 116.397451 30.22753386223114, 120.04012871067401
  final res1 = await FlutterZLocation.geocodeCoordinate(
      coordinate.latitude, coordinate.longitude, pathHead: 'assets/');
  final ipText = Text(
    res1.province,
    style: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 15),
  );
  return ipText;
}



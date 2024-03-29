import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_z_location/flutter_z_location.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../common/Config.dart';


import '../const.dart';
import '../view/Visit_Screen.dart';


class CardStyle {
  static Widget BuildCardStyle({
    required List<List<dynamic>> ImagesList,
    required List<dynamic> showAvatatList,
    required List<dynamic> VisionScreenDataList,
    required List<dynamic> UploadDateList,
    required List<dynamic> issupport,
    required List<List<dynamic>> showLabelList,
    required int itemCount,


  }) {
    String latitude ;
    String longitude ;
    double lati;
    double long;

    return ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: ((context, index) {
          latitude = VisionScreenDataList[index]['latitude'];
          longitude = VisionScreenDataList[index]['longitude'];
          lati = double.parse(latitude);
          long = double.parse(longitude);
          // latitude = lati.toStringAsFixed(6);
          // longitude = lati.toStringAsFixed(6);
          // lati = double.parse(latitude);
          // long = double.parse(longitude);
          // print( lati);

          return FutureBuilder(
              future: FlutterZLocation.geocodeCoordinate(
                  lati,long, pathHead: 'assets/'),
              builder: (context,snapshot){
                if(snapshot.hasError) return Text("Error");
                if(snapshot.hasData){
                  String adress = snapshot.data!.province+snapshot.data!.city+snapshot.data!.district;
                  return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => VistiScreen(
                              ImagesList: ImagesList[index],
                              showAvatatList: showAvatatList[index],
                              VisionScreenDataList: VisionScreenDataList[index],
                              UploadDateList: UploadDateList[index],
                              Adress:adress,
                              issupport: issupport[index],
                              showLabelList: showLabelList[index],
                            )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(0),
                        height: 600,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          image: DecorationImage(
                            image: NetworkImage(appConfig.ImageIpconfig +
                                ImagesList[index][0]['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2, left: 0, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(0),
                                    margin: const EdgeInsets.all(0),
                                    height: 45,
                                    width: 170,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GFAvatar(
                                          backgroundImage: NetworkImage(
                                              appConfig.ImageIpconfig +
                                                  showAvatatList[index]['avatar']),
                                          size: 35,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          showAvatatList[index]['name'],
                                          style: const TextStyle(
                                              fontFamily: 'YatraOne',
                                              color: Colors.white,
                                              fontSize: 17,
                                              height: 1.5,
                                              fontWeight: FontWeight.w100
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                const GFIconButton(
                                  icon: Icon(
                                    TDIcons.ellipsis,
                                    color: Colors.white,
                                    shadows: [BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 18, // Shadow position
                                    )
                                    ],
                                  ),
                                  onPressed: null,
                                  type: GFButtonType.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                              height: 45,
                              width: 170,
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GFIconButton(
                                    icon: Icon(
                                      TDIcons.heart,
                                      color: Colors.black,
                                      shadows: [BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 15, // Shadow position
                                      )
                                      ],
                                    ),
                                    onPressed: null,
                                    type: GFButtonType.transparent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GFIconButton(
                                    icon: Icon(
                                      TDIcons.chat,
                                      color: Colors.black,
                                      shadows: [BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 15, // Shadow position
                                      )
                                      ],
                                    ),
                                    onPressed: null,
                                    type: GFButtonType.transparent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GFIconButton(
                                    icon: Icon(
                                      TDIcons.share,
                                      color: Colors.black,
                                      shadows: [BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 15, // Shadow position
                                      )
                                      ],
                                    ),
                                    onPressed: null,
                                    type: GFButtonType.transparent,
                                  ),
                                ],
                              )
                          ),
                          const GFIconButton(
                            icon: Icon(
                              TDIcons.books,
                              color: Colors.black,
                              shadows: [BoxShadow(
                                color: Colors.black,
                                blurRadius: 15, // Shadow position
                              )
                              ],
                            ),
                            onPressed: null,
                            type: GFButtonType.transparent,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 15, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            VisionScreenDataList[index]['support'].toString()+'赞',
                            style: TextStyle(
                                fontFamily: 'YatraOne',
                                color: Colors.black,
                                fontSize: 19,
                                height: 1.5,
                                fontWeight: FontWeight.w100
                            ),
                          ),
                          // GFIconButton(
                          //   icon:  Icon(
                          //     TDIcons.location,
                          //     color: Colors.black,
                          //     shadows: [BoxShadow(
                          //       color: Colors.black,
                          //       blurRadius: 15, // Shadow position
                          //     )],
                          //   ),
                          //   onPressed: null,
                          //   type: GFButtonType.transparent,
                          // ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                      EdgeInsets.only(left: 15, right: 5),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'I see the crystal raindrops fall, And see the',
                            style: TextStyle(
                              //fontFamily: 'Finesse',
                                color: Colors.black,
                                fontSize: 19,
                                height: 1.5,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                          // Text(
                          //   'beauty of it all.Is when the sun comes #sunset',
                          //   style: TextStyle(
                          //     //fontFamily: 'Finesse',
                          //       color: Colors.black,
                          //       fontSize: 19,
                          //       height: 1.5,
                          //       fontWeight: FontWeight.w300
                          //   ),
                          // ),
                          // GFIconButton(
                          //   icon:  Icon(
                          //     TDIcons.location,
                          //     color: Colors.black,
                          //     shadows: [BoxShadow(
                          //       color: Colors.black,
                          //       blurRadius: 15, // Shadow position
                          //     )],
                          //   ),
                          //   onPressed: null,
                          //   type: GFButtonType.transparent,
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                        EdgeInsets.only(left: 15, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              UploadDateList[index]['datejudge'],
                              style: TextStyle(
                                  fontFamily: 'YatraOne',
                                  color: Colors.black,
                                  fontSize: 18,
                                  height: 1.5,
                                  fontWeight: FontWeight.w100
                              ),
                            ),
                          Row(
                            children: [
                              Text(
                                adress,
                            style: TextStyle(
                                fontFamily: 'YatraOne',
                                color: Colors.black,
                                fontSize: 12,
                                height: 1.5,
                                fontWeight: FontWeight.w100
                            ),
                          ),
                              GFIconButton(
                              icon: Icon(
                                TDIcons.location,
                                color: Colors.black,
                                shadows: [BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 15, // Shadow position
                                )
                                ],
                              ),
                              onPressed: null,
                              type: GFButtonType.transparent,
                            ),],
                          )
                          ],
                        )

                    )
                  ],
                );
                }
                return CircularProgressIndicator();
              }
          );
  }
          )
    );
  }
}

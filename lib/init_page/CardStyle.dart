import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../const.dart';
import '../view/Visit_Screen.dart';

class CardStyle {
  static Widget BuildCardStyle({required List<String> ImagesList,required int itemCount}){
    return ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: ((context, index) => Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => VistiScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(0),
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: DecorationImage(
                    image: AssetImage(ImagesList[index]),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(children: [
                  Padding(padding:const EdgeInsets.only(top: 2, left: 0, right:0),
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
                                  backgroundImage: AssetImage(headImageList[index]),
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  CityList[index],
                                  style: const TextStyle(
                                      fontFamily: 'YatraOne',
                                      color: Colors.white,
                                      fontSize: 19,
                                      height: 1.5,
                                      fontWeight: FontWeight.w100
                                  ),
                                ),
                              ],
                            )
                        ),
                        const GFIconButton(
                          icon:  Icon(
                            TDIcons.ellipsis,
                            color: Colors.white,
                            shadows: [BoxShadow(
                              color: Colors.black,
                              blurRadius: 18, // Shadow position
                            )],
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
                            icon:  Icon(
                              TDIcons.heart,
                              color: Colors.black,
                              shadows: [BoxShadow(
                                color: Colors.black,
                                blurRadius: 15, // Shadow position
                              )],
                            ),
                            onPressed: null,
                            type: GFButtonType.transparent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GFIconButton(
                            icon:  Icon(
                              TDIcons.chat,
                              color: Colors.black,
                              shadows: [BoxShadow(
                                color: Colors.black,
                                blurRadius: 15, // Shadow position
                              )],
                            ),
                            onPressed: null,
                            type: GFButtonType.transparent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GFIconButton(
                            icon:  Icon(
                              TDIcons.share,
                              color: Colors.black,
                              shadows: [BoxShadow(
                                color: Colors.black,
                                blurRadius: 15, // Shadow position
                              )],
                            ),
                            onPressed: null,
                            type: GFButtonType.transparent,
                          ),
                        ],
                      )
                  ),
                  const GFIconButton(
                    icon:  Icon(
                      TDIcons.books,
                      color: Colors.black,
                      shadows: [BoxShadow(
                        color: Colors.black,
                        blurRadius: 15, // Shadow position
                      )],
                    ),
                    onPressed: null,
                    type: GFButtonType.transparent,
                  ),
                ],
              ),
            ),
            const Padding(
              padding:
              EdgeInsets.only(left: 15, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '35217次赞',
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
                  Text(
                    'beauty of it all.Is when the sun comes #sunset',
                    style: TextStyle(
                      //fontFamily: 'Finesse',
                        color: Colors.black,
                        fontSize: 19,
                        height: 1.5,
                        fontWeight: FontWeight.w300
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '5分钟前',
                    style: TextStyle(
                        fontFamily: 'YatraOne',
                        color: Colors.black,
                        fontSize: 18,
                        height: 1.5,
                        fontWeight: FontWeight.w100
                    ),
                  ),
                  GFIconButton(
                    icon:  Icon(
                      TDIcons.location,
                      color: Colors.black,
                      shadows: [BoxShadow(
                        color: Colors.black,
                        blurRadius: 15, // Shadow position
                      )],
                    ),
                    onPressed: null,
                    type: GFButtonType.transparent,
                  ),
                ],
              ),
            )
          ],
        )));
  }
}

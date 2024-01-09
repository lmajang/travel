
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:travel/view/Classify_Screen.dart';
import 'package:travel/view/User_Screen.dart';
import 'package:travel/view/memory_Screen.dart';
import 'package:travel/view/recommed_Screen.dart';

import '../view/test.dart';
import '../view/test2.dart';

List<Widget> bottomBarItem = [
  Icon(TDIcons.home,
      color: Colors.black
  ),
  Icon(
    TDIcons.search,
    color: Colors.black,
  ),
  Icon(
    TDIcons.add,
    color: Colors.black,
  ),
  Icon(
    TDIcons.calendar,
    color: Colors.black,
  ),
  Icon(
      TDIcons.user_circle,
      color: Colors.black
  ),
];

List<Widget> pages =[
  RecommedScreen(),
  ClassifyScreen(),
  RecommedScreen(),
  //MemoryScreen(),
  //StoryExamplePage(),
  CollapsingAppbarWithTabsPages(),
  CollapsingAppbarWithTabsPage(),
  //UserScreen(),
];

List<String> TimeChoose = [
  '1天前',
  '3天前',
  '15天前',
  '30天前',
  '60天前',
];

List<String> DistanceChoose = [
  '500m内',
  '1km内',
  '2km内',
  '3km内',
  '5km内',
];

GFAppBar initAppbar(){
  return GFAppBar(
    //primary: true,
    // leading:GFIconButton(
    //   icon: Icon(
    //     Icons.message,
    //     color: Colors.white,
    //   ),
    //   onPressed: () {},
    //   type: GFButtonType.transparent,
    // ),
    automaticallyImplyLeading: false,
    centerTitle: false,
    title: const Text(
      'TravelBy',
      style: TextStyle(
          color: Colors.black,
          fontFamily: 'Finesse',
          fontWeight: FontWeight.w600,
          fontSize: 33),
    ),
    actions: <Widget>[
      GFIconButton(
        icon: const Icon(
          Icons.favorite,
          color: Colors.white,
          shadows: [BoxShadow(
            color: Colors.black,
            blurRadius: 18, // Shadow position
          )],
        ),
        onPressed: () {},
        type: GFButtonType.transparent,
      ),
      GFIconButton(
        icon: const Icon(
          Icons.camera_alt,
          color: Colors.white,
          shadows: [BoxShadow(
            color: Colors.black,
            blurRadius: 18, // Shadow position
          )],
        ),
        onPressed: () {},
        type: GFButtonType.transparent,
      ),
    ],
    backgroundColor: Colors.white,
    bottomOpacity: 0,
    elevation: 0,
  );
}
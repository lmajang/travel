
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:travel/view/Classify_Screen.dart';
import 'package:travel/view/User_Screen.dart';
import 'package:travel/view/memory_Screen.dart';
import 'package:travel/view/recommed_Screen.dart';

import '../view/test.dart';

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
  MemoryScreen(),
  UserScreen(),
];
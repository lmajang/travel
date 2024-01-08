import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel/const.dart';
import 'package:travel/view/Visit_Screen.dart';
import 'package:travel/view/Upload_Screen.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:flukit/flukit.dart';
import 'package:travel/view/test.dart';

import '../init_page/init_item.dart';
import '../widgets/crop_result_view.dart';
import 'Classify_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items:  bottomBarItem,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index){
          if(index == 2) {
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
            return false;
          }
          return true;
        },
      ),
      appBar: GFAppBar(
        //primary: true,
        // leading:GFIconButton(
        //   icon: Icon(
        //     Icons.message,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        //   type: GFButtonType.transparent,
        // ),
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
      ),
      body: IndexedStack(
        index: _page,
        children: pages,
      ),
    );
  }
}

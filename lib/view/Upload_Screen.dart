import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:travel/const.dart';
import 'package:travel/view/Home_Screen.dart';
import 'package:travel/view/Visit_Screen.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:flukit/flukit.dart';
import 'package:image_picker/image_picker.dart';

class SelectFromPhotoAlbumScreen extends StatefulWidget {
  const SelectFromPhotoAlbumScreen({super.key});

  @override
  State<SelectFromPhotoAlbumScreen> createState() => _SelectFromPhotoAlbumScreenState();
}

class _SelectFromPhotoAlbumScreenState extends State<SelectFromPhotoAlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        //primary: false,
        title: const Text(
          '最新项目',
          style: TextStyle(
              fontFamily: 'Finesse',
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        //centerTitle: false,
        actions: <Widget>[
          GFButton(
            onPressed: (){},
            icon: Icon(
              TDIcons.queue,
              color: Colors.white,
            ),
            text: '选择多项',
            color: Colors.black38,
            shape: GFButtonShape.pills,
            //type: GFButtonType.transparent,
          ),
          GFIconButton(
            onPressed: ()async {
              //Navigator.of(context).pop();
              final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
              // if (pickedImage != null) {
              //   _updateSelectedImage(File(pickedImage.path));
              //   _saveImagePath(pickedImage.path);
              // }
            },
            icon: Icon(
              TDIcons.photo,
              color: Colors.white,
            ),
            type: GFButtonType.transparent,
          ),
        ],
        backgroundColor: Colors.red,
        bottomOpacity: 0,
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Row(
              children: [
                Text(
                  '显示',
                  style: TextStyle(
                      fontFamily: 'Finesse',
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        )
    );
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        //primary: false,
        leading:GFIconButton(
          icon: const Icon(
            TDIcons.close,
            color: Colors.white,
          ),
          // onPressed: () {
          //   Navigator.pop(context);
          // },
          onPressed: () {
            Navigator.pop(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return HomeScreen();
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
          },
          type: GFButtonType.transparent,
        ),
        title: const Text(
          '新帖子',
          style: TextStyle(
              fontFamily: 'Finesse',
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: <Widget>[
          GFButton(
            text: '继续',
            textStyle:const TextStyle(
                //color: Colors.black,
                fontFamily: 'Finesse',
                fontWeight: FontWeight.w600,
                fontSize: 17),
            color: Colors.white,
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
        backgroundColor: Colors.black,
        bottomOpacity: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(0),
                height: 500,
                color: Colors.black,
              ),
              Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(0),
                height: 50,
                color: Colors.black,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 6,right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          //height: 45,
                          width: 236,
                          child: const Text(
                            '最近项目',
                            style: TextStyle(
                              //fontFamily: 'YatraOne',
                                color: Colors.white,
                                fontSize: 17,
                                height: 1.3,
                                fontWeight: FontWeight.w100
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.all(0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GFButton(
                                onPressed: (){},
                                icon: Icon(
                                  TDIcons.queue,
                                  color: Colors.white,
                                ),
                                text: '选择多项',
                                color: Colors.black38,
                                shape: GFButtonShape.pills,
                                //type: GFButtonType.transparent,
                              ),
                              GFIconButton(
                                onPressed: ()async {
                                  //Navigator.of(context).pop();
                                  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                                  // if (pickedImage != null) {
                                  //   _updateSelectedImage(File(pickedImage.path));
                                  //   _saveImagePath(pickedImage.path);
                                  // }
                                },
                                icon: Icon(
                                  TDIcons.photo,
                                  color: Colors.white,
                                ),
                                type: GFButtonType.transparent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
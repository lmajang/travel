import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../init_page/init_item.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  final dio = Dio();
  String _imageUrl= "https://t7.baidu.com/it/u=1956604245,3662848045&fm=193&f=GIF";
  Future<void> _repeatedlyRequest() async {
    Future<FormData> createFormData() async {
      return FormData.fromMap({
        'sceneryid': '1',
        'userid': '1',
        //'file': await MultipartFile.fromFile(''),
      });
    }

    final response = await dio.get('http://192.168.29.1:8080/sceneryinformation', data: await createFormData());
    final jsonData = JsonDecoder().convert(response.data);
    final image = jsonData[4]['image'];
    final description = jsonData[0]['description'].toString();
    setState(() {
      _imageUrl = "http://192.168.29.1:8080/images/" + image;
    });
    print('image: $image');
    print('description: $description');
  }
  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: initAppbar(),
        body: Container(
          height: scrSize.height,
          width: scrSize.width,
          decoration:  BoxDecoration(image: DecorationImage(
            image: NetworkImage(_imageUrl),
            //image: AssetImage("assets/images/test.jpg"),
            fit: BoxFit.cover,)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GFButton(
                text: 'Http测试',
                onPressed: () async {
                  await _repeatedlyRequest();
                  // After getting the new image URL, trigger a rebuild
                  setState(() {});
                },
              ),
            ],
          ),
        )
    );
  }
}

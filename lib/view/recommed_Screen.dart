import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:travel/common/Config.dart';
import 'package:travel/entity/avatar_entity.dart';
import 'package:travel/entity/labels_entity.dart';
import 'package:travel/entity/support_entity.dart';
import 'package:travel/entity/upload_date_entity.dart';

import '../const.dart';
import '../entity/pictrues_entity.dart';
import '../entity/vision_screen_data_entity.dart';
import '../init_page/CardStyle.dart';
import '../init_page/init_item.dart';
import 'Visit_Screen.dart';


class RecommedScreen extends StatefulWidget {
  const RecommedScreen({super.key});

  @override
  State<RecommedScreen> createState() => _RecommedScreenState();
}

class _RecommedScreenState extends State<RecommedScreen> {
  Future<dynamic>? _StartData;
  Dio dio =Dio();
  int _count =2;
  int n = 0;
  List<List<dynamic>> showPictureList = [];
  List<List<dynamic>> showLabelList = [];
  List<dynamic> showAvatatList = [];
  List<dynamic> VisionScreenDataList = [];
  List<dynamic> UploadDateList = [];
  List<dynamic> ississupport = [];

  late EasyRefreshController _controller;
  //late Response response ;
  Future<FormData> createFormData() async {
    return FormData.fromMap({
      'userid':'1' ,
      'date': DateTime.now().toIso8601String(),
      //'file': await MultipartFile.fromFile(''),
    });
  }

  Future<dynamic> StartfetchData() async {
     Response response = await dio.post(appConfig.ipconfig+'main',data: await createFormData());
      // Handle the response data as needed
    return response.data;
  }


  @override
  void initState() {
    super.initState();
    _StartData = StartfetchData();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: initAppbar(),
          body: FutureBuilder(
            future: StartfetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                // 当Future发生错误时，显示错误提示的UI
                print('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                print('111111111111111111111');
                print(snapshot.data);

                print('111111111111111111111');
                for (int i = 0; i < snapshot.data.length; i++) {
                  PictruesEntity pictrueList = PictruesEntity.fromJson(
                      snapshot.data[i]['main'][2]);
                  LabelsEntity labelsEntity = LabelsEntity.fromJson(
                      snapshot.data[i]['main'][3]);
                  AvatarEntity avatarEntity = AvatarEntity.fromJson(
                      snapshot.data[i]['main'][1]);
                  VisionScreenDataEntity visionScreenDataEntity = VisionScreenDataEntity.fromJson(
                      snapshot.data[i]['main'][0]);
                  UploadDateEntity uploadDateEntity = UploadDateEntity.fromJson(
                      snapshot.data[i]['main'][5]);
                  SupportEntity supportEntity = SupportEntity.fromJson(
                      snapshot.data[i]['main'][4]);
                  addNonEmptyValueToList(showPictureList, pictrueList.pictrues);
                  addNonEmptyValueToList(showLabelList, labelsEntity.labels);
                  showAvatatList.add(avatarEntity.toJson());
                  VisionScreenDataList.add(visionScreenDataEntity.toJson());
                  UploadDateList.add(uploadDateEntity.toJson());
                  ississupport.add(supportEntity);
                }
                print(showAvatatList);
                print(VisionScreenDataList);
                print(UploadDateList);
                print('111111111111111111111');
                return EasyRefresh(
                  controller: _controller,
                  header: const ClassicHeader(),
                  footer: const ClassicFooter(),
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      _count = 3;
                    });
                    _controller.finishRefresh();
                    _controller.resetFooter();
                  },
                  onLoad: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      _count += 2;
                    });
                    _controller.finishLoad(
                        _count >= showPictureList.length ? IndicatorResult.noMore : IndicatorResult.success);
                  },
                  child: CardStyle.BuildCardStyle(
                      ImagesList:showPictureList,
                      showAvatatList: showAvatatList,
                      VisionScreenDataList: VisionScreenDataList,
                      UploadDateList: UploadDateList,
                      issupport: ississupport,
                      showLabelList: showLabelList,
                      itemCount: _count, ),
                );
              }
              // 当Future还未完成时，显示加载中的UI
              return  Center(
                child: CircularProgressIndicator(),
              );
            }
          ),


        );

  }

  void addNonEmptyValueToList(List<List<dynamic>> myList, List<dynamic> data) {
      myList.add(data);
  }
}


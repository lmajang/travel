import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:travel/aMap_tool/initMapOption.dart';
import 'package:travel/entity/index.dart';
import 'package:travel/view/Upload_Screen.dart';
import 'package:travel/common/Config.dart';

import '../aMap_tool/getLocationPermission.dart';
import '../view/Home_Screen.dart';


class PickerCropResultScreens extends StatefulWidget {
  PickerCropResultScreens({Key? key, required this.cropStream}) : super(key: key);

  final Stream<InstaAssetsExportDetails> cropStream;

  @override
  _PickerCropResultScreenStates createState() => _PickerCropResultScreenStates();
}

class _PickerCropResultScreenStates extends State<PickerCropResultScreens> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _contentController1 = TextEditingController();
  final List<dynamic> image_path=[];
  final List<TDSelectTag> _tags = [
    TDSelectTag("#快来和我一起玩吧", isSelected: true, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
  ];
  final List<String> _text=[
    "#快来和我一起玩吧",
    "#快来和我一起玩吧",
    "#快来和我一起玩吧",
    "#快来和我一起玩吧",
    "#快来和我一起玩吧",
  ];

  void dispose(){
    _contentController.dispose();
    _contentController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '新帖子',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        actions: [
          GFButton(
            onPressed: () {
              final dio = Dio();
              print(DateTime.now().toIso8601String());
              Future<void> _repeatedlyRequest() async {
                Future<FormData> createFormData() async {
                  return FormData.fromMap({
                    'label': _text,
                    'date': DateTime.now().toIso8601String(),
                    'description': _contentController.text,
                    'file': await MultipartFile.fromFile(image_path[0]),
                  });
                }

                await dio.post('${appConfig.ipconfig}upload', data: await createFormData());
              }
              _repeatedlyRequest();
              // Navigator.push(
              //   context,
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation, secondaryAnimation) {
              //       return HomeScreen();
              //     },
              //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //       const begin = Offset(1.0, 0.0);
              //       const end = Offset.zero;
              //       const curve = Curves.easeInOut;
              //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              //       var offsetAnimation = animation.drive(tween);
              //       return SlideTransition(position: offsetAnimation, child: child);
              //     },
              //     transitionDuration: Duration(milliseconds: 500),
              //   ),
              // );
            },
            text: '发布',
            color: Colors.transparent,
            shape: GFButtonShape.pills,
          ),
        ],
      ),
      body: StreamBuilder<InstaAssetsExportDetails>(
        stream: widget.cropStream,
        builder: (context, snapshot) => CropResultViews(
          selectedAssets: snapshot.data?.selectedAssets ?? [],
          croppedFiles: snapshot.data?.croppedFiles ?? [],
          progress: snapshot.data?.progress,
          heightFiles: height / 2,
          heightAssets: height / 4,
          contentController: _contentController,
          titleController: _contentController1,
          image_path: image_path,
          tags: _tags,
        ),
      ),
    );
  }
}


class CropResultViews extends StatefulWidget {

  CropResultViews({
    Key? key,
    required this.selectedAssets,
    required this.croppedFiles,
    this.progress,
    this.heightFiles = 300.0,
    this.heightAssets = 120.0,
    required this.contentController,
    required this.titleController,
    required this.tags,
    required this.image_path,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController contentController;
  final List<AssetEntity> selectedAssets;
  final List<File> croppedFiles;
  final double? progress;
  final double heightFiles;
  final double heightAssets;
  final List<TDSelectTag> tags;
  final List<dynamic> image_path;

  @override
  _CropResultViewState createState() => _CropResultViewState();
}

class _CropResultViewState extends State<CropResultViews> {
  String _latitude = ""; //纬度
  String _longitude = ""; //经度
  String province = ""; // 省份
  String city = ""; // 市
  String district = ""; // 区

  // 实例化
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  // 监听定位
  late StreamSubscription<Map<String, Object>> _locationListener;

  String userLocation ='你在哪里';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 动态申请定位权限
    LocationPermission.requestPermission();

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      MapOption.requestAccuracyAuthorization(_locationPlugin);
    }

    ///设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyShow(true, true);

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      print(result);

      setState(() {
        _latitude = result["latitude"].toString();
        _longitude = result["longitude"].toString();
        province = result['province'].toString();
        city = result['city'].toString();
        district = result['district'].toString();

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    ///移除定位监听
    if (null != _locationListener) {
      _locationListener.cancel();
    }
    if (null != _locationListener) {
      _locationListener.cancel();
    }

    ///销毁定位
    if (null != _locationPlugin) {
      _locationPlugin.destroy();
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTitleInpute(),
          _buildContentInput(),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TDTag("#话题", size: TDTagSize.large,),
                SizedBox(width: 10),
                TDTag("@朋友", size: TDTagSize.large),
              ],
            ),
          ),
          _buildTagSelector(),
          AnimatedContainer(
            duration: kThemeChangeDuration,
            curve: Curves.easeInOut,
            height: widget.croppedFiles.isNotEmpty ? widget.heightFiles : 40.0,
            child: Column(
              children: <Widget>[
                _buildTitle('Cropped Images', widget.croppedFiles.length),
                _buildCroppedImagesListView(context),
              ],
            ),
          ),
          AnimatedContainer(
            duration: kThemeChangeDuration,
            curve: Curves.easeInOut,
            height: widget.selectedAssets.isNotEmpty ? widget.heightAssets : 40.0,
            child: Column(
              children: <Widget>[
                _buildTitle('Selected Assets', widget.selectedAssets.length),
                _buildSelectedAssetsListView(),
              ],
            ),
          ),
          _buildMeaus(),
          SizedBox(
            height: 300,
          ),
        ],
      ),
    );
  }



  Widget _buildContentInput(){
    return Padding(padding: const EdgeInsets.only(left: 15,top: 5,right: 15),
      child:LimitedBox(
        maxHeight: 100,
        child: TextField(
          maxLines: 50,
          maxLength: 300,
          controller:  widget.contentController,
          decoration: const InputDecoration(
            hintText: "添加作品的描述...",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            //counterText: _contentController.text.isEmpty ? "" :null,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInpute(){
    return TDInput(
      leftLabel: '标题',
      required: true,
      controller: widget.titleController,
      backgroundColor: Colors.transparent,
      hintText: '请输入文字',
      onChanged: (text) {
        setState(() {});
      },
      onClearTap: () {
        widget.titleController.clear();
        setState(() {});
      },
    );
  }

  Widget _buildMeaus(){

    final List<MenuItemModel> _menus = [
      MenuItemModel(
          icon:TDIcons.location,
          title: userLocation,
          onTap:() async {
            MapOption.startLocation(_locationPlugin,onceLocation: true);
            // 显示加载指示器
            showLoadingIndicator();
            // 等待一小段时间（如果有回调或事件可用，也可以使用它们）
            await Future.delayed(Duration(seconds: 1));
            // 隐藏加载指示器
            hideLoadingIndicator();
            setState(() {
              // userLocation = _latitude +"--"+_longitude;
              userLocation = province+city+district;
            });
          }
      ),
      MenuItemModel(icon:TDIcons.lock_off,title: "公开·所有人可见"),
      MenuItemModel(icon:TDIcons.calendar,title: "是否创建回忆"),
      MenuItemModel(icon:TDIcons.setting,title: "高级设置"),
    ];

    List<Widget> ws = [];
    ws.add(const Divider());
    for(var menu in _menus) {
      ws.add(ListTile(
        leading: Icon(menu.icon),
        title: Text(menu.title!),
        trailing: Icon(menu.right ?? TDIcons.chevron_right),
        onTap: menu.onTap,
      ));
      ws.add(const Divider());
    }
    return Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 10),
      child: Column(
        children: ws,
      ),
    );
  }

  Widget _buildTagSelector(){
    //ws.add(const Divider());
    return SizedBox(
      height: 60,
      child:ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: widget.tags.length,
          itemBuilder: (BuildContext , int index) {
            TDSelectTag tag = widget.tags.elementAt(index);
            return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: Row(
                    children: [
                          TDSelectTag(
                              tag.text,
                              size: TDTagSize.large,
                              isLight: true,
                              shape: TDTagShape.mark,
                              isOutline: true,
                              needCloseIcon: true,
                              theme: TDTagTheme.primary,
                              isSelected: tag.isSelected,
                              disableSelect: tag.disableSelect,
                        ),
                  ],
                )
            );
          },
        ),
      );
  }

  Widget _buildTitle(String title, int length) {
    return SizedBox(
      height: 20.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurpleAccent,
              //color: Colors.red
            ),
            child: Text(
              length.toString(),
              style: const TextStyle(
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCroppedImagesListView(BuildContext context) {
    if (widget.progress == null) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: widget.croppedFiles.length,
            itemBuilder: (BuildContext _, int index) {
              widget.image_path.add(widget.croppedFiles[index].path);
              final String path = widget.croppedFiles[index].path;
              print(path);
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Image.file(widget.croppedFiles[index]),
                ),
              );
            },
          ),
          if (widget.progress! < 1.0)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                ),
              ),
            ),
          if (widget.progress! < 1.0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: SizedBox(
                  height: 6,
                  child: LinearProgressIndicator(
                    value: widget.progress,
                    semanticsLabel: '${widget.progress! * 100}%',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectedAssetsListView() {
    if (widget.selectedAssets.isEmpty) return const SizedBox.shrink();

    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.selectedAssets.length,
        itemBuilder: (BuildContext _, int index) {
          final AssetEntity asset = widget.selectedAssets.elementAt(index);

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            // TODO : add delete action
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(image: AssetEntityImageProvider(asset)),
              ),
            ),
          );
        },
      ),
    );
  }

  void showLoadingIndicator() {
    // 在这里显示加载指示器，可以使用 showDialog 或其他加载指示器组件
    // 示例：使用 Dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Loading...'),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingIndicator() {
    // 在这里隐藏加载指示器，可以使用 Navigator.pop 或其他适当的方法
    // 示例：使用 Navigator.pop
    Navigator.pop(context);
  }
  }

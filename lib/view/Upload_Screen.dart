import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:travel/entity/index.dart';
import 'package:travel/view/Upload_Screen.dart';

import '../view/Home_Screen.dart';


class PickerCropResultScreens extends StatefulWidget {
  PickerCropResultScreens({Key? key, required this.cropStream}) : super(key: key);

  final Stream<InstaAssetsExportDetails> cropStream;

  @override
  _PickerCropResultScreenStates createState() => _PickerCropResultScreenStates();
}

class _PickerCropResultScreenStates extends State<PickerCropResultScreens> {
  final TextEditingController _contentController = TextEditingController();
  final List<TDSelectTag> _tags = [
    TDSelectTag("#快来和我一起玩吧", isSelected: true, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
    TDSelectTag("#快来和我一起玩吧", isSelected: false, disableSelect: false,),
  ];

  void dispose(){
    _contentController.dispose();
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return HomeScreen();
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
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
    required this.tags,
  }) : super(key: key);

  final TextEditingController contentController;
  final List<AssetEntity> selectedAssets;
  final List<File> croppedFiles;
  final double? progress;
  final double heightFiles;
  final double heightAssets;
  final List<TDSelectTag> tags;


  @override
  _CropResultViewState createState() => _CropResultViewState();
}

class _CropResultViewState extends State<CropResultViews> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildContentInput(),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TDTag("#话题", size: TDTagSize.large),
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

  final List<MenuItemModel> _menus = [
    MenuItemModel(icon:TDIcons.location,title: "你在哪里"),
    MenuItemModel(icon:TDIcons.lock_off,title: "公开·所有人可见"),
    MenuItemModel(icon:TDIcons.calendar,title: "是否创建回忆"),
    MenuItemModel(icon:TDIcons.setting,title: "高级设置"),
  ];

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

  Widget _buildMeaus(){
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
  }

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
import 'package:travel/widgets/insta_picker_interface.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:travel/widgets/crop_result_view.dart';

import '../init_page/init_item.dart';
import '../widgets/crop_result_view.dart';
import 'Classify_Screen.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  PickerDescription get description => const PickerDescription(
    icon: '📸',
    label: 'WeChat Camera Picker',
    description: 'Picker with a camera button.\n'
        'The camera logic is handled by the `wechat_camera_picker` package.',
  );

  /// Needs a [BuildContext] that is coming from the picker
  Future<AssetEntity?> _pickFromWeChatCamera(BuildContext context) =>
      CameraPicker.pickFromCamera(
        context,
        locale: Localizations.maybeLocaleOf(context),
        pickerConfig: CameraPickerConfig(theme: Theme.of(context)),
      );

  ThemeData getPickerTheme(BuildContext context) {
    return InstaAssetPicker.themeData(kDefaultColor).copyWith(
      appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontSize: 16)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          disabledForegroundColor: Colors.grey,
        ),
      ),
    );
  }


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
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) {
            //       return WeChatCameraPicker();
            //     },
            //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
            //       const begin = Offset(-1.0, 0.0);
            //       const end = Offset.zero;
            //       const curve = Curves.easeInOut;
            //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            //       var offsetAnimation = animation.drive(tween);
            //       return SlideTransition(position: offsetAnimation, child: child);
            //     },
            //     transitionDuration: Duration(milliseconds: 500),
            //   ),
            // );
            InstaAssetPicker.pickAssets(
              context,
              //title: description.fullLabel,
              maxAssets: 10,
              pickerTheme: getPickerTheme(context),
              actionsBuilder: (
                  BuildContext context,
                  ThemeData? pickerTheme,
                  double height,
                  VoidCallback unselectAll,
                  ) =>
              [
                InstaPickerCircleIconButton.unselectAll(
                  onTap: unselectAll,
                  theme: pickerTheme,
                  size: height,
                ),
                const SizedBox(width: 8),
                InstaPickerCircleIconButton(
                  onTap: () => _pickFromWeChatCamera(context),
                  theme: pickerTheme,
                  icon: const Icon(Icons.camera_alt),
                  size: height,
                ),
              ],
              specialItemBuilder: (context, _, __) {
                // return a button that open the camera
                return ElevatedButton(
                  onPressed: () async {
                    Feedback.forTap(context);
                    final AssetEntity? entity =
                    await _pickFromWeChatCamera(context);
                    if (entity == null) return;
                    if (context.mounted) {
                      await InstaAssetPicker.refreshAndSelectEntity(
                        context,
                        entity,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      InstaAssetPicker.defaultTextDelegate(context)
                          .sActionUseCameraHint,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              // since the list is revert, use prepend to be at the top
              specialItemPosition: SpecialItemPosition.prepend,
              onCompleted: (cropStream) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PickerCropResultScreens(cropStream: cropStream),
                  ),
                );
              },
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
      ),
      body: IndexedStack(
        index: _page,
        children: pages,
      ),
    );
  }
}

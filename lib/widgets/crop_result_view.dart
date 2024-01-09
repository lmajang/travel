import 'package:flutter/material.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:travel/widgets/crop_result_view.dart';
import 'package:travel/view/Home_Screen.dart';
import 'package:travel/widgets/insta_picker_interface.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../view/Upload_Screen.dart';

class WeChatCameraPicker extends StatelessWidget with InstaPickerInterface {
  const WeChatCameraPicker({super.key});

  @override
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

  // Future<AssetEntity?> _pickFromWeChatCamera(BuildContext context) async {
  //   final pickedImage = await CameraPicker.pickFromCamera(
  //     context,
  //     locale: Localizations.maybeLocaleOf(context),
  //     pickerConfig: CameraPickerConfig(theme: Theme.of(context)),
  //   );
  //
  //   // 处理返回逻辑
  //   if (pickedImage != null) {
  //     // 处理选取的图片逻辑
  //
  //     // 返回到 HomeScreen 页面
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Home_Screen(),  // 替换为你的 HomeScreen 类
  //       ),
  //     );
  //   }
  //
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    // 直接调用 InstaAssetPicker.pickAssets 方法
    InstaAssetPicker.pickAssets(
      context,
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

    // 返回一个空的 Container，因为这个页面不需要额外的 UI 展示
    return Container();
  }
// Widget build(BuildContext context) => buildLayout(
//   context,
//   onPressed: () => InstaAssetPicker.pickAssets(
//         context,
//         title: description.fullLabel,
//         maxAssets: 10,
//         pickerTheme: getPickerTheme(context),
//         actionsBuilder: (
//              BuildContext context,
//              ThemeData? pickerTheme,
//              double height,
//              VoidCallback unselectAll,
//              ) =>
//         [
//           InstaPickerCircleIconButton.unselectAll(
//             onTap: unselectAll,
//             theme: pickerTheme,
//             size: height,
//           ),
//           const SizedBox(width: 8),
//           InstaPickerCircleIconButton(
//             onTap: () => _pickFromWeChatCamera(context),
//             theme: pickerTheme,
//             icon: const Icon(Icons.camera_alt),
//             size: height,
//           ),
//         ],
//     specialItemBuilder: (context, _, __) {
//       // return a button that open the camera
//       return ElevatedButton(
//         onPressed: () async {
//           Feedback.forTap(context);
//           final AssetEntity? entity =
//           await _pickFromWeChatCamera(context);
//           if (entity == null) return;
//
//           if (context.mounted) {
//             await InstaAssetPicker.refreshAndSelectEntity(
//               context,
//               entity,
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.white,
//           backgroundColor: Colors.transparent,
//         ),
//         child: FittedBox(
//           fit: BoxFit.cover,
//           child: Text(
//             InstaAssetPicker.defaultTextDelegate(context)
//                 .sActionUseCameraHint,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     },
//     // since the list is revert, use prepend to be at the top
//     specialItemPosition: SpecialItemPosition.prepend,
//     onCompleted: (cropStream) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               PickerCropResultScreen(cropStream: cropStream),
//         ),
//       );
//    },
//  ),
// );
}

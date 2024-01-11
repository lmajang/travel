import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rive/rive.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';


class MoreTypeStateChangeExample extends StatefulWidget {
  MoreTypeStateChangeExample({Key? key}) : super(key: key);

  @override
  _MoreTypeStateChangeExampleState createState() =>
      _MoreTypeStateChangeExampleState();
}
class _MoreTypeStateChangeExampleState
    extends State<MoreTypeStateChangeExample> {
  StateMachineController? _controller;
  Artboard? _Artboard;
  SMITrigger? nextStepTrigger;
  SMIInput<bool>? jumpRightInput;
  SMIInput<bool>? jumpCenterInput;
  SMIInput<bool>? jumpLeftInput;
  SMITrigger? _NextStep;
  @override
  void initState() {
    rootBundle.load('assets/rives/buddy.riv').then((data) async {
      // Load the RiveFile from the binary data.
      final file = RiveFile.import(data);

      // The artboard is the root of the animation and gets drawn in the
      // Rive widget.
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(
          artboard, 'Main');
      if (controller != null) {
        artboard.addController(controller);
        jumpLeftInput = controller.findInput('Jump Left');
        jumpCenterInput = controller.findInput('Jump Center');
        jumpRightInput = controller.findInput('Jump Right');
        nextStepTrigger = controller.findSMI('Next Step');

        setState(() {
          _Artboard = artboard;
          _controller = controller;
        });
      }
    });
    super.initState();
  }

  BoxDecoration _buildBorderDecoration(Color color) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.all(
        Radius.circular(0),
      ),
      border: Border.fromBorderSide(
        BorderSide(
          color: color,
          width: 3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MoreTypeStateChangeExample'),
      //   // titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
      // ),
      appBar: GFAppBar(
          primary: true,
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
                EvaIcons.plus_square_outline,
                color: Colors.black38,
                shadows: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 18, // Shadow position
                  )
                ],
              ),
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
            GFIconButton(
              icon: const Icon(
                TDIcons.view_list,
                color: Colors.black38,
                shadows: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 18, // Shadow position
                  )
                ],
              ),
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
          ],
          backgroundColor: Colors.white,
          bottomOpacity: 0,
          elevation: 0,
        ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap:  () {
          jumpLeftInput?.value = false;
          jumpCenterInput?.value = false;
          jumpRightInput?.value = true;
          nextStepTrigger?.fire();
        },
        child:Container(
          decoration: _buildBorderDecoration(Colors.black),
          child: Column(
            children: [
            //  Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: ElevatedButton(
            //           onPressed: () {
            //             jumpLeftInput?.value = false;
            //             jumpCenterInput?.value = true;
            //             jumpRightInput?.value = false;
            //             nextStepTrigger?.fire();
            //           },
            //           child: Text('Next Step'),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 10, vertical: 20),
            //         child: ElevatedButton(
            //           onPressed: () {
            //             jumpLeftInput?.value = true;
            //             jumpCenterInput?.value = false;
            //             jumpRightInput?.value = false;
            //             nextStepTrigger?.fire();
            //           },
            //           child: Text('Jump Left'),
            //         ),
            //       ),
            //       Expanded(
            //         child: ElevatedButton(
            //           onPressed: () {
            //             jumpLeftInput?.value = false;
            //             jumpCenterInput?.value = false;
            //             jumpRightInput?.value = true;
            //             nextStepTrigger?.fire();
            //           },
            //           child: Text('Jump Right'),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
              Expanded(
                flex: 2,
                child: _Artboard == null
                  ? SizedBox()
                  : Rive(artboard: _Artboard!),
              ),
            ],
          ),
        ),
      )
    );
  }
}



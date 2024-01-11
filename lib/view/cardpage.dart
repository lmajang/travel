import 'dart:math';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rive/rive.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../const.dart';
import 'memory_Detils.dart';
import 'Upload_Screen.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var currentPage = ImagesList.length - 1.0;
  late PageController controller;

  StateMachineController? _controller;
  Artboard? _Artboard;
  SMITrigger? nextStepTrigger;
  SMIInput<bool>? jumpRightInput;
  SMIInput<bool>? jumpCenterInput;
  SMIInput<bool>? jumpLeftInput;
  SMITrigger? _NextStep;
  final List<String> sceneryId=['1','2','3','4','5','6','7','8','9','10'];

  @override
  void initState() {
    controller = PageController(initialPage: ImagesList.length - 1);
    rootBundle.load('assets/rives/buddy.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, 'Main');
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
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
        jumpLeftInput?.value = false;
        jumpCenterInput?.value = false;
        jumpRightInput?.value = true;
        nextStepTrigger?.fire();
      });
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
      appBar: GFAppBar(
        primary: true,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'Memory',
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
              color: Colors.white,
              shadows: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 18, // Shadow position
                )
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return memoryDetils_Page(
                      title: 'aaaa',
                      id: '1',
                    );
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                  transitionDuration: Duration(milliseconds: 500),
                ),
              );
            },
            type: GFButtonType.transparent,
          ),
        ],
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: _buildBorderDecoration(Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // GestureDetector(
              //   onHorizontalDragUpdate: (details) {
              //     if (details.primaryDelta! > 0) {
              //       // 右滑动
              //       jumpLeftInput?.value = true;
              //       jumpCenterInput?.value = false;
              //       jumpRightInput?.value = false;
              //       nextStepTrigger?.fire();
              //       print(details.primaryDelta);
              //     } else if (details.primaryDelta! < 0) {
              //       // 左滑动
              //       jumpLeftInput?.value = false;
              //       jumpCenterInput?.value = false;
              //       jumpRightInput?.value = true;
              //       nextStepTrigger?.fire();
              //       print(details.primaryDelta);
              //     }
              //   },
              Stack(
                children: <Widget>[
                  // 两者堆叠在一起。通过PageView滑动的Controller来控制当前显示的page
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: ImagesList.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              GFButton(
                icon: Icon(TDIcons.flag),
                text: '点击开启回忆',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                color: Color(0xFF16161D),
                onPressed: () {
                  double? index = controller.page;
                  int i =index!.toInt();
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return memoryDetils_Page(
                          title: CityList[i],
                          id: '1',
                        );
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                      transitionDuration: Duration(milliseconds: 500),
                    ),
                  );
                },
                shape: GFButtonShape.pills,
              ),
              Expanded(
                flex: 2,
                child:
                    _Artboard == null ? SizedBox() : Rive(artboard: _Artboard!),
              ),
            ],
          )),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 5.0;
  var verticalInset = 10.0;
  CardScrollWidget(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: (15.0 / 22.0) * 1.3,
      child: LayoutBuilder(
        builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;
          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;
          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * 12 / 16;
          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;
          List<Widget> cardList = [];
          for (var i = 0; i < ImagesList.length; i++) {
            var leftPage = i - currentPage;
            bool isOnRight = leftPage > 0;
            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -leftPage * (isOnRight ? 15 : 1),
                    0);
            var cardItem = Positioned.directional(
                top: padding + verticalInset * max(-leftPage, 0.0),
                bottom: padding + verticalInset * max(-leftPage, 0.0),
                start: start,
                textDirection: TextDirection.rtl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 10.0)
                    ]),
                    child: AspectRatio(
                        aspectRatio: 12 / 16,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(ImagesList[i], fit: BoxFit.cover),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 设置标题
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: Text(
                                        CityList[i],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // 设置ReaderLater
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                  ),
                ));
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}

class FancyCard extends StatelessWidget {
  const FancyCard({
    super.key,
    required this.image,
    required this.title,
  });

  final Image image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              child: image,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            OutlinedButton(
              child: const Text("Learn more"),
              onPressed: () => print("Button was tapped"),
            ),
          ],
        ),
      ),
    );
  }
}

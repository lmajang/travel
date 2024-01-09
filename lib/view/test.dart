import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';

class StoryExamplePage extends StatefulWidget {
  const StoryExamplePage({super.key});

  @override
  State<StoryExamplePage> createState() => _StoryExamplePageState();
}

class _StoryExamplePageState extends State<StoryExamplePage> {
  Widget _createDummyPage({
    required String text,
    required String imageName,
    bool addBottomBar = true,
  }) {
    return StoryPageScaffold(
      bottomNavigationBar: addBottomBar
          ? SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
          : const SizedBox.shrink(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/$imageName.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonText(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildButtonDecoration(
      String imageName,
      ) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          'assets/images/$imageName.jpg',
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  BoxDecoration _buildBorderDecoration(Color color) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
      border: Border.fromBorderSide(
        BorderSide(
          color: color,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Story Example'),
      ),
      body: Column(
        children: [
          StoryListView(
            pageTransform: const StoryPage3DTransform(),
            buttonDatas: [
              StoryButtonData(
                timelineBackgroundColor: Colors.red,
                buttonDecoration: _buildButtonDecoration('h6'),
                child: _buildButtonText('Want a new car?'),
                borderDecoration: _buildBorderDecoration(Colors.orange),
                storyPages: [
                  _createDummyPage(
                    text:
                    'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: 'car',
                  ),
                  _createDummyPage(
                    text:
                    'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: 'car',
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
              StoryButtonData(
                timelineBackgroundColor: Colors.blue,
                buttonDecoration: _buildButtonDecoration('h1'),
                borderDecoration:
                _buildBorderDecoration(const Color.fromARGB(255, 134, 119, 95)),
                child: _buildButtonText('Travel whereever'),
                storyPages: [
                  _createDummyPage(
                    text: 'Get a loan',
                    imageName: 'h_1',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Select a place where you want to go',
                    imageName: 'h_2',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Dream about the place and pay our interest',
                    imageName: 'h_3',
                    addBottomBar: false,
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
              StoryButtonData(
                timelineBackgroundColor: Colors.orange,
                borderDecoration: _buildBorderDecoration(Colors.orange),
                buttonDecoration: _buildButtonDecoration('h4'),
                child: _buildButtonText('Buy a house anywhere'),
                storyPages: [
                  _createDummyPage(
                    text: 'You cannot buy a house. Live with it',
                    imageName: 'house',
                  ),
                ],
                segmentDuration: const Duration(seconds: 5),
              ),
              StoryButtonData(
                timelineBackgroundColor: Colors.red,
                buttonDecoration: _buildButtonDecoration('h3'),
                child: _buildButtonText('Want a new car?'),
                borderDecoration: _buildBorderDecoration(Colors.red),
                storyPages: [
                  _createDummyPage(
                    text:
                    'Want to buy a new car? Get our loan for the rest of your life!',
                    imageName: 'car',
                  ),
                  _createDummyPage(
                    text:
                    'Can\'t return the loan? Don\'t worry, we\'ll take your soul as a collateral ;-)',
                    imageName: 'car',
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
              StoryButtonData(
                buttonDecoration: _buildButtonDecoration('h1'),
                borderDecoration:
                _buildBorderDecoration(const Color.fromARGB(255, 134, 119, 95)),
                child: _buildButtonText('Travel whereever'),
                storyPages: [
                  _createDummyPage(
                    text: 'Get a loan',
                    imageName: 'h_1',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Select a place where you want to go',
                    imageName: 'h_2',
                    addBottomBar: false,
                  ),
                  _createDummyPage(
                    text: 'Dream about the place and pay our interest',
                    imageName: 'h_3',
                    addBottomBar: false,
                  ),
                ],
                segmentDuration: const Duration(seconds: 3),
              ),
              StoryButtonData(
                timelineBackgroundColor: Colors.orange,
                borderDecoration: _buildBorderDecoration(Colors.orange),
                buttonDecoration: _buildButtonDecoration('h2'),
                child: _buildButtonText('Buy a house anywhere'),
                storyPages: [
                  _createDummyPage(
                    text: 'You cannot buy a house. Live with it',
                    imageName: 'house',
                  ),
                ],
                segmentDuration: const Duration(seconds: 5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
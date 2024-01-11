import 'package:flutter/material.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class memoryDetils_Page extends StatelessWidget {
  memoryDetils_Page({super.key, required this.title,required this.id});
  final String title;
  final String id;

  final List<Widget> fancyCards = <Widget>[
    FancyCard(
      image: Image.asset("assets/profileImages/p5.png"),
      title: "Say hello to planets!",
    ),
    FancyCard(
      image: Image.asset("assets/profileImages/p19.png"),
      title: "Don't be sad!",
    ),
    FancyCard(
      image: Image.asset("assets/profileImages/p11.png"),
      title: "Go for a walk!",
    ),
    FancyCard(
      image: Image.asset("assets/profileImages/p5.png"),
      title: "Try teleportation!",
    ),
    FancyCard(
      image: Image.asset("assets/profileImages/p9.png"),
      title: "Enjoy your coffee!",
    ),
    FancyCard(
      image: Image.asset("assets/profileImages/p16.png"),
      title: "Play with your cat!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StackedCardCarousel(
        items: fancyCards,
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
              child: const Text("查看地图"),
              onPressed: () => print("Button was tapped"),
            ),
          ],
        ),
      ),
    );
  }
}

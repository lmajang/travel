import 'package:flutter/cupertino.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:travel/init_page/CardStyle.dart';

import '../const.dart';
import 'init_item.dart';

class BuildRefreshComponent extends StatefulWidget {
  const BuildRefreshComponent({super.key});

  @override
  State<BuildRefreshComponent> createState() => _BuildRefreshComponentState();
}

class _BuildRefreshComponentState extends State<BuildRefreshComponent> {
  int _count = 2;
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
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
      body: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 4));
          if (!mounted) {
            return;
          }
          setState(() {
            _count = 2;
          });
          _controller.finishRefresh();
          _controller.resetFooter();
        },
        onLoad: () async {
          await Future.delayed(const Duration(seconds: 4));
          setState(() {
            _count += 1;
          });
          _controller.finishLoad(
              _count >= ImagesList.length ? IndicatorResult.noMore : IndicatorResult.success);
        },
        child: CardStyle.BuildCardStyle(ImagesList:ImagesList,itemCount: _count),
      ),
    );
  }
}

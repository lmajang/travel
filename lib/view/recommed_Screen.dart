import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../const.dart';
import '../init_page/CardStyle.dart';
import '../init_page/init_item.dart';
import 'Visit_Screen.dart';

class RecommedScreen extends StatefulWidget {
  const RecommedScreen({super.key});

  @override
  State<RecommedScreen> createState() => _RecommedScreenState();
}

class _RecommedScreenState extends State<RecommedScreen> {


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
          await Future.delayed(const Duration(seconds: 2));
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
          await Future.delayed(const Duration(seconds: 2));
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

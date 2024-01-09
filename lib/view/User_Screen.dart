import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../init_page/init_item.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: initAppbar(),
      body: Text('个人主页'),
    );
  }
}

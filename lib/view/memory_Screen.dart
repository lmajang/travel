import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../init_page/init_item.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: initAppbar(),
      body: Text('回忆录'),
    );
  }
}

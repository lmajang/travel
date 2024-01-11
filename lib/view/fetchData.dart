import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<String>? _fetchData;

  @override
  void initState() {
    _fetchData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchData, // 异步操作的Future对象
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 当Future还未完成时，显示加载中的UI
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 当Future发生错误时，显示错误提示的UI
          return Text('Error: ${snapshot.error}');
        } else {
          // 当Future成功完成时，显示数据
          print('Data: ${snapshot.data}');
          return Text('Data: ${snapshot.data}');
        }
      },
    );
  }

  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 10));
    // 模拟异步操作，延迟2秒后返回数据
    return "Hello, World!";
  }
}

import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController(
      initialPage: 0
    );
    return Scaffold(
      body: Center(
        child: Text('我的'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController(
      initialPage: 0
    );
    return Scaffold(
      body: Center(
        child: Text('旅拍'),
      ),
    );
  }
}

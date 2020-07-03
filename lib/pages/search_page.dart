import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController(
      initialPage: 0
    );
    return Scaffold(
      body: Center(
        child: Text('搜索'),
      ),
    );
  }
}

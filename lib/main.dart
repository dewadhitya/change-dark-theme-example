import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Change Theme Demo');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDark = false;
  bool isAnimationChanging = false;

  _changeTheme(bool value) {
    setState(() {
      this.isDark = value;
      this.isAnimationChanging = true;
    });
    Future.delayed(Duration(seconds: 1, milliseconds: 450), () {
      setState(() {
        this.isAnimationChanging = false;
      });
    });
  }

  Widget iconLight = Icon(
    Icons.wb_sunny,
    color: Colors.yellowAccent,
  );

  Widget iconDark = SvgPicture.asset(
    'assets/nights_stay.svg',
    color: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(
        brightness: this.isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: this.isAnimationChanging 
        ? null 
        : AppBar(
          title: Text(widget.title),
        ),
        body: this.isAnimationChanging 
        ? AnimatedOpacity(
          opacity: this.isAnimationChanging ? 1.0 : 0.0, 
          duration: Duration(milliseconds: 850),
          curve: Curves.easeInOut,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: this.isDark ? this.iconDark : this.iconLight,
                ),
              ],
            ),
          ),
        ) 
        : Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Switch Theme :',
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Switch(
                    value: this.isDark, 
                    onChanged: (value) {
                      _changeTheme(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
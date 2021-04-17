// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Stack(
            children: [
              CustomPaint(
                painter: ClockPainter(),
                size: Size(300, 300),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(alignment: Alignment.topCenter, child: Text("12")),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    Align(alignment: Alignment.bottomCenter, child: Text("6")),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(alignment: Alignment.centerLeft, child: Text("9")),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    Align(alignment: Alignment.centerRight, child: Text("3")),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(canvas, size) {
    Paint paint1 = Paint()
      ..color = Color(0xffEE09EE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(
      Offset(size.width * .5, size.height * .5),
      size.width * .5,
      paint1,
    );

    canvas.drawCircle(
      Offset(
        size.width * .5,
        size.height * .5,
      ),
      size.width * .0155,
      paint1..style = PaintingStyle.fill,
    );
// hour
    canvas.drawLine(
        Offset(
          150,
          142.5,
        ),
        Offset(
          150,
          90,
        ),
        paint1..strokeCap = StrokeCap.round);
// for minutes
    canvas.drawLine(
        Offset(
          158,
          150.5,
        ),
        Offset(
          230,
          150,
        ),
        paint1..strokeCap = StrokeCap.round);
    // seconds
    canvas.drawLine(
        Offset(
          142,
          148.5,
        ),
        Offset(
          40,
          120,
        ),
        paint1..strokeCap = StrokeCap.round);

    // canvas.
    return;
  }

  @override
  bool shouldRepaint(ClockPainter c) => false;
}

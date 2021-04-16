import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_example/photos.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Http example' + text),
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
  List<Photos> lPhotos;

  bool loading;

  @override
  initState() {
    super.initState();
    lPhotos = [];
    loading = true;
    // _getImages().then((value) {
    //   // log("the value gotten is ${value.statusCode}");

    //   // log("images --  ${value.body}");
    //   List a = json.decode(value.body);

    //   if (mounted) {
    //     setState(() => loading = false);
    //   } else {
    //     loading = false;
    //   }
    //   a.forEach((r) {
    //     // log("each photos -- $r");
    //     lPhotos.add(Photos.fromJson(r));
    //   });
    //   // log("our phots --- $lPhotos");
    // }).catchError((e) {
    //   log("error gotten was --- $e");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // titleSpacing: 0.0,
        centerTitle: false,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: _getImages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Text("An error --- ${snapshot.error}");
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  log("snapshot -- ${snapshot.data.body}");
                  var a = json.decode("${snapshot.data.body}");

                  a.forEach((r) {
                    log("each photos -- $r");
                    lPhotos.add(Photos.fromJson(r));
                  });
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, i) => Image.network(lPhotos[i].url),
                    itemCount: lPhotos.length,
                  );
                }
              })
          // This trailing comma makes auto-formatting nicer for build methods.
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
    );
  }

  Future<http.Response> _getImages() async {
    Uri link = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    return http.get(link);
  }
}
//  loading
//               ? Container(
//                   height: 100,
//                   width: 100,
//                   child: Center(child: CircularProgressIndicator()))
//               : GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2),
//                   itemBuilder: (context, i) => Image.network(lPhotos[i].url),
//                   itemCount: lPhotos.length,
//                 )),

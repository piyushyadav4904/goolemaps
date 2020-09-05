
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LatLng> latLnglsit=[];
  // ignore: non_constant_identifier_names
  List<Marker> MyMarker=[];
  @override
  void initState() {

    getpermission();
    super.initState();
  }
  void getpermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print(statuses[Permission.location]);
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: GoogleMap(
          markers: Set.from(latLnglsit),
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(6.843369, 79.874814),
            zoom: 12.99,
          ),
          onTap: _handleTap,




          polygons: Set<Polygon>.of(<Polygon>[
            Polygon(
                polygonId: PolygonId('area'),
                points: latLnglsit,
                geodesic: true,
                strokeColor: Colors.red.withOpacity(0.6),
                strokeWidth: 5,
                fillColor: Colors.redAccent.withOpacity(0.1),
                visible: true),


          ]),)

    );
  }
//direct add the poitn to draw a polygun
  getPoints() {
    return [
      LatLng(6.862462, 79.859482),
      LatLng(6.862258, 79.862325),
      LatLng(6.863121, 79.863644),
      LatLng(6.864538, 79.865039),


    ];
  }


 void _handleTap(LatLng argument) {
    setState(() {

      MyMarker.add(
          Marker(
              markerId: MarkerId(argument.toString()),
              position: argument

          )
      );
      latLnglsit.add(argument);

    });
  }
}


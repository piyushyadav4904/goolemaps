



import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(Health());
}

class Health extends StatelessWidget {
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
        primarySwatch: Colors.amber,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HealthPage(title: 'Health'),
    );
  }
}

class HealthPage extends StatefulWidget {
  HealthPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HealthPageState createState() => _HealthPageState();
}




class _HealthPageState extends State<HealthPage> {
var speedInmps="?";




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Health'),
      ),
      body:
      Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.all(8.0),
                    height: 200,
                    width: 180,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child:
                    Center(child: Text("distance",
                      style: TextStyle(color: Colors.black87, fontSize: 25),))

                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(child: Text("time",
                    style: TextStyle(color: Colors.black87, fontSize: 25),)),
                ),

              ]
          ),
          Container(
              margin: const EdgeInsets.all(8.0),
              height: 150,
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
               child:
              Center(child: Text("speed: $speedInmps",
                style: TextStyle(color: Colors.black87, fontSize: 25),))

          ),
          Center(
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              margin: EdgeInsets.all(20),
              child: Center(
                child: FlatButton(

                  child: Text('start'),
                  textColor: Colors.amber,
                  onPressed: () {
                    setState(() {
                      _getspeed();
                    });

                  },
                ),
              ),
            ),
          ),

        ],

      ),


    );
  }

  void _getspeed() {
      getPositionStream().listen((position) async {
        var speedInMps = position.speed;
       // this is your speedy
        print(speedInMps);

      });



  }
}

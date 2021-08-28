import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SlidingUpPanel(
          borderRadius: BorderRadius.circular(20),
          minHeight: 70,
          collapsed: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(50)),
                ),
                Text(
                  'Status Map',
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18, 40, 18, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Jon',
                            style: TextStyle(fontSize: 41),
                          )
                        ],
                      ),
                      ClipOval(
                        child: Image(
                          image: AssetImage('assets/pic.jpg'),
                          height: 50,
                          width: 50,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 150,
                    width: 0.87 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff051EC5),
                          Color(0xff051EC5).withOpacity(0.5)
                        ]),
                        //color: Color(0xff051EC5),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 12,
                              offset: Offset(10, 10),
                              color: Color(0xff8A99FF))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Systems',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                  Text(
                                    'Nominal',
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '22% minor anomaly',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                  Text(
                                    '3% severe anomaly',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        //Chart
                        pie.PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 6,
                          colorList: [
                            Colors.blue.withOpacity(0.4),
                            Colors.white
                          ],
                          initialAngleInDegree: 180,
                          chartType: pie.ChartType.ring,
                          ringStrokeWidth: 10,
                          legendOptions: pie.LegendOptions(
                            showLegends: false,
                          ),
                          chartValuesOptions: pie.ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: serverStatus()),
                  InkWell(
                    onTap: () {},
                    child: Ink(
                      height: 220,
                      width: 0.87 * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 12,
                                offset: Offset(0, 10))
                          ]),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'BX31',
                                  style: TextStyle(
                                      color: Color(0xff636363), fontSize: 20),
                                ),
                                Text(
                                  'Severe',
                                  style: TextStyle(
                                      color: Color(0xffD44000), fontSize: 18),
                                )
                              ],
                            ),
                            Container(
                              height: 80,
                              width: double.infinity,
                              child: Scrollbar(
                                isAlwaysShown: true,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    reverse: true,
                                    children: [
                                      calCircle(
                                        date: '18',
                                        color: Colors.green,
                                      ),
                                      calCircle(
                                        date: '19',
                                        color: Colors.green,
                                      ),
                                      calCircle(
                                        date: '20',
                                        color: Colors.amber,
                                      ),
                                      calCircle(
                                        date: '21',
                                        color: Colors.amber,
                                      ),
                                      calCircle(
                                        date: '22',
                                        color: Colors.redAccent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on),
                                Text('Mumbai East'),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_sharp,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 210,
                    child: Scrollbar(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          smallStatusCard(
                              code: 'BX32',
                              location: 'Mumbai South',
                              since: '4 Hours',
                              status: 'Minor'),
                          smallStatusCard(
                              code: 'BX33',
                              location: 'Mumbai South',
                              since: '16 Hours',
                              status: 'Minor'),
                          smallStatusCard(
                              code: 'BX34',
                              location: 'Mumbai North',
                              since: '22 Hours',
                              status: 'Minor'),
                          smallStatusCard(
                              code: 'BX35',
                              location: 'Mumbai West',
                              since: '23 Hours',
                              status: 'Minor'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          ),
          panel: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Text(
                      'Status Map',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ],
              ),
              animatedMap(
                height: 300,
                isExp: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, double> dataMap = {
  "rest": 25,
  "optimum": 75,
};

class calCircle extends StatelessWidget {
  String date;
  Color color;
  calCircle({this.date, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: this.color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          this.date,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class smallStatusCard extends StatelessWidget {
  String code;
  String location;
  String status;
  String since;

  smallStatusCard({this.code, this.location, this.status, this.since});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Ink(
            width: MediaQuery.of(context).size.width * (0.87 / 2.1),
            //height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 12,
                      offset: Offset(10, 10))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(this.code,
                          style: TextStyle(color: Colors.grey, fontSize: 17)),
                      Text(
                        this.status,
                        style: TextStyle(color: Colors.amber, fontSize: 17),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Text(
                      'Since',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    this.since,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: 15,
                      ),
                      Text(this.location)
                    ],
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_sharp)
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        )
      ],
    );
  }
}

class serverStatus extends StatefulWidget {
  @override
  _serverStatusState createState() => _serverStatusState();
}

class _serverStatusState extends State<serverStatus> {
  double _height = 120;
  bool _exp = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _height = _exp == true ? 120 : 220;
          _exp = !_exp;
        });
      },
      child: AnimatedContainer(
        height: _height,
        width: double.infinity,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
            //color: Colors.orange,
            gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orange],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.deepOrange.withOpacity(0.4),
                  blurRadius: 12,
                  offset: Offset(10, 10))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('Server',
                      style: TextStyle(fontSize: 28, color: Colors.white)),
                  Text('Monitoring',
                      style: TextStyle(fontSize: 18, color: Colors.white))
                ],
              ),
            ),
            pie.PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 6,
              colorList: [Colors.orange, Colors.white],
              initialAngleInDegree: 180,
              chartType: pie.ChartType.ring,
              ringStrokeWidth: 10,
              legendOptions: pie.LegendOptions(
                showLegends: false,
              ),
              chartValuesOptions: pie.ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: false,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
            pie.PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 6,
              colorList: [Colors.orange, Colors.white],
              initialAngleInDegree: 180,
              chartType: pie.ChartType.ring,
              ringStrokeWidth: 10,
              legendOptions: pie.LegendOptions(
                showLegends: false,
              ),
              chartValuesOptions: pie.ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: false,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class animatedMap extends StatefulWidget {
  double height;
  bool isExp;

  animatedMap({this.height, this.isExp});
  @override
  _animatedMapState createState() => _animatedMapState();
}

class _animatedMapState extends State<animatedMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.87,
      height: widget.height,
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(19.115959, 72.891279),
              zoom: 10.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(19.193146, 72.970930),
                    builder: (ctx) => Container(
                      child: Icon(Icons.location_on),
                    ),
                  ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(19.134124, 72.934538),
                    builder: (ctx) => Container(
                      child: Icon(Icons.location_on),
                    ),
                  ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(19.139509, 72.925071),
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(19.148554, 72.839032),
                    builder: (ctx) => Container(
                      child: Icon(Icons.location_on),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: ElevatedButton(
                  onPressed: () {
                    if (widget.isExp) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => mapPage()));
                    }
                  },
                  child: Text(widget.isExp ? 'Back' : 'Expand')))
        ],
      ),
    );
  }
}

List blueList = [Colors.white, Color(0xff8595ff)];

class mapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return animatedMap(
      height: MediaQuery.of(context).size.height,
      isExp: true,
    );
  }
}

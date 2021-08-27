import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:pie_chart/pie_chart.dart';

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
                        PieChart(
                          dataMap: dataMap,
                          colorList: [Colors.white, Color(0xff8595ff)],
                          chartType: ChartType.ring,
                          chartRadius: 70,
                          ringStrokeWidth: 10,
                          legendOptions: LegendOptions(showLegends: false),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValues: false,
                          ),
                        )
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
          panel: Center(
            child: Text('Status Map'),
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
    return InkWell(
      onTap: () {},
      child: Ink(
        width: MediaQuery.of(context).size.width * (0.87 / 2.1),
        height: 200,
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
          children: [
            Row(
              children: [Text(this.code), Text(this.status)],
            ),
            Text('Since'),
            Text(this.since),
            Row(
              children: [Icon(Icons.location_on_sharp), Text(this.location)],
            ),
            Icon(Icons.keyboard_arrow_right_sharp)
          ],
        ),
      ),
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
        duration: Duration(milliseconds: 500),
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
      ),
    );
  }
}

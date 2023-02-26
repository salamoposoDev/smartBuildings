import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smartbuilding/component/sensors_card_status.dart';
import 'package:smartbuilding/model/status_sensors.dart';
import 'package:smartbuilding/tab_bar/tabbar_cakalang.dart';
import 'package:smartbuilding/tab_bar/tabbar_kakap.dart';
import 'package:smartbuilding/tab_bar/tabbar_rumah.dart';
import 'package:smartbuilding/tab_bar/tabbar_salmon.dart';
import 'package:smartbuilding/tab_bar/tabbar_tik.dart';
import 'package:smartbuilding/tab_bar/tabbar_utama.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int timestamp = 0;
  String? jam;
  String? dayWeek;
  String welcome = '';
  String hour = 'null';
  String dateNow = 'null';
  String statSensor = 'Disconnected';
  int harga = 1444;

  List statusCard = [
    // building, hardwareState, SensorState
    ['Home', 'Online', 'Connected'],
    ['Salmon', 'Offline', 'Disconnected'],
    ['TIK', 'Offline', 'Disconnected'],
    ['Utama', 'Offline', 'Disconnected'],
    ['Kakap', 'Offline', 'Disconnected'],
  ];

  @override
  Widget build(BuildContext context) {
    // DATE TIME
    final DateTime now = DateTime.now();
    final DateFormat dateFormat = DateFormat.H();
    hour = dateFormat.format(now);
    dateNow = DateFormat.yMMMd().format(now);
    var intHour = int.parse(hour);
    if (intHour >= 00 && intHour <= 10) {
      welcome = 'Good Morning';
    } else if (intHour >= 11 && intHour <= 14) {
      welcome = 'Good Afternoon';
    } else if (intHour >= 15 && intHour <= 18) {
      welcome = 'Good Afternoon';
    } else if (intHour >= 19 && intHour <= 23) {
      welcome = 'Good Night';
    }

    // DATABASE REF STATUS SENSOR

    DatabaseReference statusHardwareRef =
        FirebaseDatabase.instance.ref('buildingStat');

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              // USER PROFILE AND DATE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // USER PROFILE
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                            ),
                          ),
                        ),
                        const Text(
                          'Hi, Yopi',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    // DATE TIME
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 20, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset(
                                  'lib/icons/wheather.png',
                                  color: Colors.grey[900],
                                ),
                              ),
                              Text(
                                dateNow,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // WELCOME TEXT
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  welcome,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),

              // TITLE
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Smart Energy Monitoring',
                      style: GoogleFonts.bebasNeue(fontSize: 36),
                    ),
                  ),
                ],
              ),

              // CARD STATUS SENSOR
              StreamBuilder(
                  stream: statusHardwareRef.onValue,
                  builder: (context, snap) {
                    if (snap.hasData &&
                        !snap.hasError &&
                        snap.data?.snapshot.value != null) {
                      String stringData = jsonEncode(snap.data?.snapshot.value);
                      SensorStatus sensorStatus =
                          SensorStatus.fromJson(json.decode(stringData));

                      // timestamp Home
                      var timeH = DateTime.fromMillisecondsSinceEpoch(
                          sensorStatus.hTime! * 1000);
                      String hJam = DateFormat.Hm().format(timeH).toString();
                      String hDate = DateFormat.yMd().format(timeH).toString();

                      // timestamp B1
                      var timeB1 = DateTime.fromMillisecondsSinceEpoch(
                          sensorStatus.b1Time! * 1000);
                      String b1Jam = DateFormat.Hm().format(timeB1).toString();
                      String b1Date =
                          DateFormat.yMd().format(timeB1).toString();

                      // timestamp B2
                      var timeB2 = DateTime.fromMillisecondsSinceEpoch(
                          sensorStatus.b2Time! * 1000);
                      String b2Jam = DateFormat.Hm().format(timeB2).toString();
                      String b2Date =
                          DateFormat.yMd().format(timeB2).toString();

                      // timestamp B3
                      var timeB3 = DateTime.fromMillisecondsSinceEpoch(
                          sensorStatus.b3Time! * 1000);
                      String b3Jam = DateFormat.Hm().format(timeB3).toString();
                      String b3Date =
                          DateFormat.yMd().format(timeB3).toString();

                      // timestamp B4
                      var timeB4 = DateTime.fromMillisecondsSinceEpoch(
                          sensorStatus.b4Time! * 1000);
                      String b4Jam = DateFormat.Hm().format(timeB4).toString();
                      String b4Date =
                          DateFormat.yMd().format(timeB4).toString();

                      // timestamp B5
                      var timeB5 = DateTime.fromMillisecondsSinceEpoch(
                          sensorStatus.b5Time! * 1000);
                      String b5Jam = DateFormat.Hm().format(timeB5).toString();
                      String b5Date =
                          DateFormat.yMd().format(timeB5).toString();

                      List<String> sensorStatList = [
                        '$hJam, $hDate',
                        '$b1Jam, $b1Date',
                        '$b2Jam, $b2Date',
                        '$b3Jam, $b3Date',
                        '$b4Jam, $b4Date',
                        '$b5Jam, $b5Date',
                      ];

                      List<String> pzemStatList = [
                        '${sensorStatus.hSens}',
                        '${sensorStatus.b1Sens}',
                        '${sensorStatus.b2Sens}',
                        '${sensorStatus.b3Sens}',
                        '${sensorStatus.b4Sens}',
                        '${sensorStatus.b5Sens}',
                      ];

                      List totalEnergyList = [
                        (sensorStatus.hTotalEnergy / 100),
                        (sensorStatus.b1TotalEnergy / 100),
                        (sensorStatus.b2TotalEnergy / 100),
                        (sensorStatus.b3TotalEnergy / 100),
                        (sensorStatus.b4TotalEnergy / 100),
                        (sensorStatus.b5TotalEnergy / 100),
                      ];

                      List hargaList = [
                        (sensorStatus.hTotalEnergy / 100) * harga,
                        (sensorStatus.b1TotalEnergy / 100) * harga,
                        (sensorStatus.b2TotalEnergy / 100) * harga,
                        (sensorStatus.b3TotalEnergy / 100) * harga,
                        (sensorStatus.b4TotalEnergy / 100) * harga,
                      ];

                      return SizedBox(
                        height: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: statusCard.length,
                              itemBuilder: (context, index) {
                                return SensorsCardStatus(
                                  buildingsName: 'Device',
                                  hardwareState: statusCard[index][0],
                                  sensorState: pzemStatList[index],
                                  todayEnergy:
                                      totalEnergyList[0].toStringAsFixed(2),
                                  thisMonthEnergy: '0.0',
                                  lastUpdate: sensorStatList[index],
                                  harga: hargaList[index].toStringAsFixed(2),
                                );
                              }),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: statusCard.length,
                              itemBuilder: (context, index) {
                                return SensorsCardStatus(
                                  buildingsName: 'Devices',
                                  hardwareState: statusCard[index][0],
                                  sensorState: 'null',
                                  todayEnergy: 'null',
                                  thisMonthEnergy: 'null',
                                  lastUpdate: 'null',
                                  harga: 'null',
                                );
                              }),
                        ),
                      );
                    }
                  }),
              // SizedBox(
              //   height: 170,
              //   child: Padding(
              //     padding: const EdgeInsets.all(5.0),
              //     child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: statusCard.length,
              //         itemBuilder: (context, index) {
              //           return SensorsCardStatus(
              //             buildingsName: statusCard[index][0],
              //             hardwareState: statusCard[index][1],
              //             sensorState: statSensor,
              //             todayEnergy: '200',
              //             thisMonthEnergy: '1200',
              //             lastUpdate: '$jam, $dayWeek',
              //           );
              //         }),
              //   ),
              // ),

              const SizedBox(
                height: 10,
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'All Buildings',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  thickness: 2,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text('Home'),
                    ),
                    Tab(
                      child: Text('Building 1'),
                    ),
                    Tab(
                      child: Text('Building 2'),
                    ),
                    Tab(
                      child: Text('Building 3'),
                    ),
                    Tab(
                      child: Text('Building 4'),
                    ),
                    Tab(
                      child: Text('Building 5'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  const TabRumah(),
                  TabSalmon(),
                  const TabTik(),
                  const TabUtama(),
                  const TabCakalang(),
                  const TabKakap(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

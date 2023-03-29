import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smartbuilding/component/sensors_card_status.dart';
import 'package:smartbuilding/model/status_sensors.dart';
import 'package:smartbuilding/page/history/history_page.dart';
import 'package:smartbuilding/page/record_data/record_data_page.dart';
import 'package:smartbuilding/tab_bar/tabbar_rumah.dart';
import 'package:smartbuilding/tab_bar/building1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseDatabase.instance;
  int timestamp = 0;
  dynamic timestampB1 = 0;
  String? jam;
  String? dayWeek;
  String welcome = '';
  String hour = 'null';
  String dateNow = 'null';
  String statSensor = 'Disconnected';
  int harga = 1444;
  dynamic kwhTot = 0;
  dynamic waktu = 0;
  dynamic totalkwhB1;
  dynamic b1pzem012 = 0;

  final DateTime now = DateTime.now();
  final DateFormat dateFormat = DateFormat.H();

  List statusCard = [
    // building, hardwareState, SensorState
    ['Home', 'Online', 'Connected'],
    ['Gedung Utama', 'Offline', 'Disconnected'],
    ['TIK', 'Offline', 'Disconnected'],
    ['Utama', 'Offline', 'Disconnected'],
    ['Kakap', 'Offline', 'Disconnected'],
  ];

  @override
  Widget build(BuildContext context) {
    dateNow = DateFormat.yMMMd().format(now);

    // RUN SEKALI SAAT APK DI BUKA
    Timer(const Duration(seconds: 0), () {
      // DATE TIME
      hour = dateFormat.format(now);
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

      // GET DATA TOTAL KWH
      DatabaseReference totalKwh = FirebaseDatabase.instance
          .ref('buildings/rumah/sensors/usage/thisMonth/');
      totalKwh.onValue.listen((event) {
        kwhTot = event.snapshot.value;
        // print('sekali');
      });

      // GET DATA TOTAL KWH
      DatabaseReference totalkwhRef = FirebaseDatabase.instance
          .ref('buildings/building1/sensors/usage/thisMonth/');
      totalkwhRef.onValue.listen((event) {
        totalkwhB1 = event.snapshot.value;
        String stringData = jsonEncode(totalkwhB1);
        Map valuemapb1 = jsonDecode(stringData);
        b1pzem012 =
            valuemapb1['pzem0'] + valuemapb1['pzem1'] + valuemapb1['pzem2'];
        // print(b1pzem012);
      });
    });

    Timer.periodic(const Duration(seconds: 5), (timer) {
      //waktu update home
      DatabaseReference timeRef = FirebaseDatabase.instance
          .ref('buildings/rumah/sensors/realtime/time');
      timeRef.onValue.listen((event) {
        waktu = event.snapshot.value;
      });

      // timestamp b1
      DatabaseReference timeB1ref =
          db.ref('buildings/building1/sensors/realtime/timeR');
      timeB1ref.onValue.listen((event) {
        timestampB1 = event.snapshot.value;
        // print(timestampB1);
      });
    });

    //get data push kwh
    // DatabaseReference dataKwh =
    //     FirebaseDatabase.instance.ref('buildings/rumah/sensors/kwhPush/');
    // dataKwh.onValue.listen((event) {
    //   // print(event.snapshot.value);
    //   print(event.snapshot.children.last.value);
    //   String? newKey = dataKwh.push().key;
    // });
    // print(queryData.orderByKey().equalTo('time'));

    // DATABASE REF STATUS SENSOR
    DatabaseReference statusHardwareRef =
        FirebaseDatabase.instance.ref('buildingStat');

    return DefaultTabController(
      length: 2,
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
                      var timeH =
                          DateTime.fromMillisecondsSinceEpoch(waktu * 1000);
                      String hJam = DateFormat.Hm().format(timeH).toString();
                      String hDate = DateFormat.yMd().format(timeH).toString();

                      // timestamp B1
                      var timeB1 = DateTime.fromMillisecondsSinceEpoch(
                          timestampB1 * 1000);
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
                        (kwhTot),
                        b1pzem012,
                        (sensorStatus.b2TotalEnergy),
                        (sensorStatus.b3TotalEnergy),
                        (sensorStatus.b4TotalEnergy),
                        (sensorStatus.b5TotalEnergy),
                      ];

                      List hargaList = [
                        (kwhTot * harga),
                        (b1pzem012 * harga),
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
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return SensorsCardStatus(
                                  buildingsName: statusCard[index][0],
                                  sensorState: pzemStatList[index],
                                  todayEnergy:
                                      totalEnergyList[index].toStringAsFixed(2),
                                  lastMonth: '0.0',
                                  lastUpdate: sensorStatList[index],
                                  harga: hargaList[index].toStringAsFixed(0),
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
                                  sensorState: 'null',
                                  todayEnergy: 'null',
                                  lastMonth: 'null',
                                  lastUpdate: 'null',
                                  harga: 'null',
                                );
                              }),
                        ),
                      );
                    }
                  }),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RecordDataPage(),
                            ));
                      },
                      child: const Text(
                        'Classification',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Prediction',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Text(
                          'History',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  thickness: 2,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabBar(
                      // indicator: BoxDecoration(
                      //   shape: BoxShape.rectangle,
                      //   color: Colors.white60,
                      //   borderRadius: BorderRadius.circular(8),
                      //   border: Border.all(
                      //     color: Colors.grey.shade400,
                      //     width: 1,
                      //   ),
                      // ),
                      isScrollable: true,
                      labelColor: Colors.grey[900],
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'Home',
                          // child: Text('Home'),
                        ),
                        Tab(
                          text: 'Office',
                          // child: Text('Office'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  TabRumah(),
                  const TabSalmon(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

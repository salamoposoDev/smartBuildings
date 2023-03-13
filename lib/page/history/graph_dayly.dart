import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartbuilding/page/history/bar%20graph%20day/bar_graph.dart';

class DayGraph extends StatefulWidget {
  const DayGraph({super.key});

  @override
  State<DayGraph> createState() => _DayGraphState();
}

class _DayGraphState extends State<DayGraph> {
  DateTime dateTime = DateTime.now();
  String? monthNow;
  String? dateNow;
  final DateTime now = DateTime.now();
  final DateFormat dateFormat = DateFormat.H();
  @override
  Widget build(BuildContext context) {
    dateNow = DateFormat.yMMMd().format(now);
    //get bulan ini
    monthNow = DateTime.now().month.toString();

    Query dbref =
        FirebaseDatabase.instance.ref('buildings/rumah/sensors/history/dayly/');
    Query query =
        FirebaseDatabase.instance.ref('buildings/rumah/sensors/history/dayly/');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoButton(
          child: Row(
            children: [
              Text(
                '${dateTime.year.toString() + '/'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[900],
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[900],
              ),
            ],
          ),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => SizedBox(
                height: 250,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: dateTime,
                    use24hFormat: true,
                    backgroundColor: Colors.white,
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() {
                        dateTime = newTime;
                        print(newTime);
                      });
                    }),
              ),
            );
          },
        ),
        StreamBuilder(
          stream: dbref.orderByChild('waktu').equalTo('11/3/2023').onValue,
          builder: (context, snap) {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data?.snapshot.value != null) {
              String jsonString = jsonEncode(snap.data?.snapshot.value);
              Map<dynamic, dynamic> list = jsonDecode(jsonString);
              List<dynamic> datalist = [];
              datalist = list.values.toList();
              // print(datalist[0]['energy']);
              print(list);

              List<Map<String, dynamic>> datavolt = [];
              List<Map<String, dynamic>>? datavoltReverse = [];

              int waktu;
              dynamic energy;

              String hari, bulan;
              List daylyData = [
                0.0, // Mond 0
                0.0, // selasa 1
                0.0, // rabu 2
                0.0, // kamis 3
                0.0, // jumat 4
                0.0, // sabtu 5
                0.0, // minggu 6
              ];

              for (var i = 0; i < datalist.length; i++) {
                waktu = datalist[i]['timestamp'];
                energy = datalist[i]['energy'];
                var timeH = DateTime.fromMillisecondsSinceEpoch(waktu * 1000);
                hari = DateFormat.d().format(timeH).toString();
                bulan = DateFormat.M().format(timeH).toString();

                datavolt.add({'time': hari, 'energy': energy});
                // cek data di bulan ini
                if (bulan == DateTime.now().month.toString()) {
                  switch (hari) {
                    case '9':
                      // print('Tru');
                      daylyData.insert(3, energy);
                      break;
                    case '10':
                      // print('Fri');
                      daylyData.insert(4, energy);
                      break;
                    case '11':
                      // print('Sat');
                      daylyData.insert(5, energy);
                      break;
                    case '12':
                      // print('Sun');
                      daylyData.insert(6, energy);
                      break;
                    default:
                  }
                }

                // daylyData.add({energy, day});
              }
              print(daylyData);

              return Column(
                children: [
                  Text(dateNow.toString()),
                  BarGraphDay(
                    monAmount: daylyData[0],
                    tuAmount: daylyData[1],
                    wedAmount: daylyData[2],
                    thuAmount: daylyData[3],
                    friAmount: daylyData[4],
                    satAmount: daylyData[5],
                    sunAmount: daylyData[6],
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Text('Energy Per Day'),
        ),
        Expanded(
          child: FirebaseAnimatedList(
            reverse: false,
            query: query,
            itemBuilder: (context, snapshot, animation, index) {
              Map data = snapshot.value as Map;
              // print(data);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        const Text('Energy Usage '),
                        Text("${data['energy']} kWh"),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data['jam'].toString()),
                        Text(data['waktu'].toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

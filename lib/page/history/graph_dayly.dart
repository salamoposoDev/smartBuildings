import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:smartbuilding/page/history/bar%20graph%20day/bar_graph.dart';

class HourGraph extends StatefulWidget {
  const HourGraph({super.key});

  @override
  State<HourGraph> createState() => _HourGraphState();
}

class _HourGraphState extends State<HourGraph> {
  List pilih = [
    '1',
    '2',
    '3',
  ];
  String today = DateTime.now().day.toString();
  String bulanini = DateTime.now().month.toString();
  String tahunini = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    Query dbref =
        FirebaseDatabase.instance.ref('buildings/rumah/sensors/history/hour/');
    Query query =
        FirebaseDatabase.instance.ref('buildings/rumah/sensors/history/hour/');
    // print(query);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
          stream: dbref
              .orderByChild('waktu')
              .equalTo('$today/$bulanini/$tahunini')
              .onValue,
          builder: (context, snap) {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data?.snapshot.value != null) {
              String jsonSring = jsonEncode(snap.data?.snapshot.value);
              Map<dynamic, dynamic> mapData = jsonDecode(jsonSring);
              List<dynamic> list = [];
              list = mapData.values.toList();

              List<Map<String, dynamic>> datavolt = [];
              List enamJamTerakhir = ['0', '1', '2', '3', '4', '5'];
              List valueJamTerakhir = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0];

              String waktu;
              dynamic energy;
              list.reversed;
              // print(list);
              if (list.length > 6) {
                for (var i = 0; i <= 5; i++) {
                  waktu = list[i]['jam'];
                  energy = list[i]['energy'];
                  datavolt.add({'time': waktu, 'energy': energy});
                  valueJamTerakhir.insert(i, energy);
                  enamJamTerakhir.insert(i, waktu);
                }
                // print(datavolt.reversed);
              }

              List<Map<String, dynamic>> datachart = [];
              if (datavolt.length > 6) {
                // datavolt.reversed;

                for (var a = 0; a <= 6; a++) {
                  String t = datavolt[a]['time'];
                  dynamic en = datavolt[a]['energy'];
                  datachart.add({'time': t, 'energy': en});
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton(
                      hint: const Text(
                        'Pilih Jam',
                        style: TextStyle(fontSize: 14),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      items: const [
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text('1'),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text('2'),
                        ),
                        DropdownMenuItem<String>(
                          value: '3',
                          child: Text('3'),
                        ),
                      ],
                      onChanged: (String? newValue) {},
                    ),
                  ),
                  BarGraphDay(
                    jam0: enamJamTerakhir[0],
                    jam1: enamJamTerakhir[1],
                    jam2: enamJamTerakhir[2],
                    jam3: enamJamTerakhir[3],
                    jam4: enamJamTerakhir[4],
                    jam5: enamJamTerakhir[5],
                    monAmount: valueJamTerakhir[0],
                    tuAmount: valueJamTerakhir[1],
                    wedAmount: valueJamTerakhir[2],
                    thuAmount: valueJamTerakhir[3],
                    friAmount: valueJamTerakhir[4],
                    satAmount: valueJamTerakhir[5],
                  ),
                  // AspectRatio(
                  //   aspectRatio: 16 / 9,
                  //   child: DChartBar(
                  //     animationDuration: const Duration(seconds: 1),
                  //     yAxisTitle: 'kWh',
                  //     data: [
                  //       {
                  //         'id': 'Bar',
                  //         'data': datavolt.map((e) {
                  //           return {
                  //             'domain': e['time'],
                  //             'measure': e['energy']
                  //           };
                  //         }).toList(),
                  //       },
                  //     ],
                  //     domainLabelPaddingToAxisLine: 16,
                  //     axisLineTick: 2,
                  //     axisLinePointTick: 2,
                  //     axisLinePointWidth: 10,
                  //     axisLineColor: Colors.grey[700],
                  //     measureLabelPaddingToAxisLine: 16,
                  //     barColor: (barData, index, id) => Colors.grey.shade800,
                  //     showBarValue: true,
                  //   ),
                  // ),
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Energy'),
              DropdownButton(
                hint: const Text(
                  'Pilih Jam',
                  style: TextStyle(fontSize: 14),
                ),
                borderRadius: BorderRadius.circular(10),
                items: const [
                  DropdownMenuItem<String>(
                    value: 'sala',
                    child: Text('sala'),
                  ),
                ],
                onChanged: (String? newValue) {},
              )
            ],
          ),
        ),
        Expanded(
          child: FirebaseAnimatedList(
            reverse: true,
            query: query
                .orderByChild('waktu')
                .equalTo('$today/$bulanini/$tahunini'),
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

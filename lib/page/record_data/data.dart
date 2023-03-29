import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class DataSreen extends StatefulWidget {
  const DataSreen({super.key});

  @override
  State<DataSreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DataSreen> {
  final _myBox = Hive.box('myBox');

  final ScrollController _controller = ScrollController();

  final database = FirebaseDatabase.instance; //firebase
  @override
  Widget build(BuildContext context) {
    // print("data = " + _myBox.get(1));
    String child = _myBox.get(1);
    // ======
    final dataPushRef = database.ref('buildings/recordData/data');

    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[700],
        title: Text(
          'Result',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              // reverse: true,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              query: dataPushRef.orderByKey().equalTo(child),
              itemBuilder: (context, snapshot, animation, index) {
                Map data = snapshot.value as Map;
                // buat list untuk arus, cosphi, daya, dan tegangan
                List<dynamic> arusList = [];
                List<dynamic> cosphiList = [];
                List<dynamic> powerList = [];
                List<dynamic> voltageList = [];
                // list untuk semua data
                List<dynamic> list = [];
                list = data.values.toList();

                // tampung data arus ke dalam list
                for (var i = 0; i < list.length; i++) {
                  arusList.add(list[i]['current']);
                  cosphiList.add(list[i]['cosphi']);
                  voltageList.add(list[i]['voltage']);
                  powerList.add(list[i]['power']);
                }

                // menghitung rata" arus dan cosphi
                dynamic rataArus =
                    arusList.reduce((a, b) => a + b) / arusList.length;
                dynamic arusTerendah = arusList.reduce((a, b) => a < b ? a : b);
                dynamic arusTertinggi =
                    arusList.reduce((a, b) => a > b ? a : b);
                // cosphi
                dynamic rataCosphi =
                    cosphiList.reduce((a, b) => a + b) / cosphiList.length;
                dynamic pfTertinggi =
                    cosphiList.reduce((a, b) => a > b ? a : b);
                dynamic pfTerendah = cosphiList.reduce((a, b) => a < b ? a : b);

                // VOLTAGE
                var rataVolt =
                    voltageList.reduce((a, b) => a + b) / voltageList.length;
                var voltTertinggi = voltageList.reduce((a, b) => a > b ? a : b);
                var voltTerendah = voltageList.reduce((a, b) => a < b ? a : b);

                // POWER
                dynamic rataPower =
                    powerList.reduce((a, b) => a + b) / powerList.length;
                dynamic powerTertinggi =
                    powerList.reduce((a, b) => a > b ? a : b);
                dynamic powerTerendah =
                    powerList.reduce((a, b) => a < b ? a : b);

                // print('tertinggi $arusTertinggi, Terendah $arusTerendah');

                // print(list.length);
                if (data.isNotEmpty) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // RATA-RATA
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Average',
                                            style: GoogleFonts.bebasNeue(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),

                                          // voltage , current, power cosphi
                                          Text(
                                            rataVolt.toStringAsFixed(0) + ' V',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${rataArus.toStringAsFixed(2)} A',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${rataPower.toStringAsFixed(2)} W',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            rataCosphi.toStringAsFixed(1),
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // MAX VALAUE
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Max Value',
                                            style: GoogleFonts.bebasNeue(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          // voltage , current, power cosphi Max Value
                                          Text(
                                            voltTertinggi.toStringAsFixed(0) +
                                                ' V',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${arusTertinggi.toStringAsFixed(2)} A',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${powerTertinggi.toStringAsFixed(2)} W',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            pfTertinggi.toStringAsFixed(1),
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // MIN VALUE
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Min Value',
                                            style: GoogleFonts.bebasNeue(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          // voltage , current, power cosphi Min Value
                                          Text(
                                            voltTerendah.toStringAsFixed(0) +
                                                ' V',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${arusTerendah.toStringAsFixed(2)} A',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${powerTerendah.toStringAsFixed(2)} W',
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            pfTerendah.toStringAsFixed(1),
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Voltage  ${list[index]['voltage']} V',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Current  ${list[index]['current']} A',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Power ${list[index]['power'].toStringAsFixed(2)} W',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Cosphi ${list[index]['cosphi']}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 2,
                                    thickness: 1,
                                  )
                                ],
                              ),
                            );
                          }),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[700],
        title: Text(
          'All Data',
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
                // buat list untuk arus dan cosphi
                List<double> arusList = [];
                List<double> cosphiList = [];
                // list untuk data arus dan cosphi
                List<dynamic> list = [];
                list = data.values.toList();

                // tampung data arus ke dalam list
                for (var i = 0; i < list.length; i++) {
                  arusList.add(list[i]['current']);
                  cosphiList.add(list[i]['cosphi']);
                }

                // menghitung rata" arus dan cosphi

                double rataArus =
                    arusList.reduce((a, b) => a + b) / arusList.length;
                double arusTerendah = arusList.reduce((a, b) => a < b ? a : b);
                double arusTertinggi = arusList.reduce((a, b) => a > b ? a : b);
                double rataCosphi =
                    cosphiList.reduce((a, b) => a + b) / cosphiList.length;
                double pfTertinggi = cosphiList.reduce((a, b) => a > b ? a : b);
                double pfTerendah = cosphiList.reduce((a, b) => a < b ? a : b);

                print('tertinggi $arusTertinggi, Terendah $arusTerendah');

                // print(list.length);
                if (data.isNotEmpty) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Current Av= ${rataArus.toStringAsFixed(2)} A',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: Colors.grey[900],
                                  ),
                                ),
                                Text(
                                  'Cosphi Av= ${rataCosphi.toStringAsFixed(2)}',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            // tertinggi dan terendah
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Max I= ${arusTertinggi.toStringAsFixed(2)} A',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: Colors.grey[900],
                                  ),
                                ),
                                Text(
                                  'Max pf= ${pfTertinggi.toStringAsFixed(2)}',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
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
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Current  ${list[index]['current']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Cosphi ${list[index]['cosphi']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
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

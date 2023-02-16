import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  @override
  Widget build(BuildContext context) {
    int timestamp;
    String? waktu;
    // firebase ref
    DatabaseReference timestampRef =
        FirebaseDatabase.instance.ref('buildings/rumah/sensors/').child('time');
    timestampRef.onValue.listen((event) {
      timestamp = event.snapshot.value as int;

      var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

      waktu = DateFormat('HH:mm:ss').format(date);
    });

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
                          'Hi, There',
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
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.cloud,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              Text(waktu ?? '-',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // WELCOME TEXT
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Welcome Back,',
                  style: TextStyle(
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
                      'Energy Monitoring',
                      style: GoogleFonts.bebasNeue(fontSize: 42),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image.asset(
                      'lib/icons/smartbuilding.png',
                      color: Colors.grey[800],
                      height: 60,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 70,
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

              const Divider(
                thickness: 2,
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
                      child: Text('Rumah'),
                    ),
                    Tab(
                      child: Text('G.Salmon'),
                    ),
                    Tab(
                      child: Text('G.TIK'),
                    ),
                    Tab(
                      child: Text('G.Utama'),
                    ),
                    Tab(
                      child: Text('G.Kakap'),
                    ),
                    Tab(
                      child: Text('G.Cakalang'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  TabRumah(),
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

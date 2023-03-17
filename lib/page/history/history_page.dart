import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartbuilding/page/history/grap_year.dart';
import 'package:smartbuilding/page/history/graph_weekly.dart';
import 'package:smartbuilding/page/history/graph_dayly.dart';
import 'package:smartbuilding/page/history/graph_monthly.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[700],
          title: const Text('History'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              labelColor: Colors.grey[800],
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                color: Colors.white70,
                border: Border.all(color: Colors.grey),
              ),
              tabs: [
                Tab(
                  child: Text(
                    'Day',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Week',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Month',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Year',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  HourGraph(),
                  DayGraph(),
                  MonthGraph(),
                  YearGraph(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

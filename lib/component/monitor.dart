import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Monitor extends StatefulWidget {
  String sensorName;
  String sensorIcon;
  String sensorValue;
  Monitor({
    super.key,
    required this.sensorName,
    required this.sensorIcon,
    required this.sensorValue,
  });

  @override
  State<Monitor> createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.sensorValue,
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.sensorName,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  widget.sensorIcon,
                  height: 40,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

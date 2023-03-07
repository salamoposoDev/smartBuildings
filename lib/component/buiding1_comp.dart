import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class B1Comp extends StatelessWidget {
  String sensorName;
  String sensorValueR;
  String sensorValueS;
  String sensorValueT;
  String sensorIcon;
  String satuanSens;

  B1Comp({
    required this.sensorName,
    required this.sensorIcon,
    required this.sensorValueR,
    required this.sensorValueS,
    required this.sensorValueT,
    required this.satuanSens,
    super.key,
  });

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SENSOR VALUE
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'R  ',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '$sensorValueR $satuanSens',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.white38,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'S  ',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '$sensorValueS $satuanSens',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.white38,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'T  ',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '$sensorValueT  $satuanSens',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
            // SENSOR NAME
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  sensorName,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  sensorIcon,
                  height: 40,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

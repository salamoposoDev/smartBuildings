import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class BarGraphDay extends StatelessWidget {
  double monAmount;
  double tuAmount;
  double wedAmount;
  double thuAmount;
  double friAmount;
  double satAmount;
  double sunAmount;

  BarGraphDay({
    super.key,
    required this.monAmount,
    required this.tuAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  @override
  Widget build(BuildContext context) {
    // list of data
    List<Map<String, dynamic>> datasaya = [
      {'time': 'Mon', 'energy': 4.3},
      {'time': 'Tu', 'energy': 3.2},
      {'time': 'Wed', 'energy': 4.2},
      {'time': 'Tru', 'energy': 7.2},
      {'time': 'Fri', 'energy': 8.2},
      {'time': 'Sat', 'energy': 7.2},
      {'time': 'Sun', 'energy': 4.2},
    ];

    double senAmount = 3.2;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBar(
        yAxisTitle: 'kWh',
        // data: [
        //   {
        //     'id': 'Bar',
        //     'data': datasaya.map((e) {
        //       return {'domain': e['time'], 'measure': e['energy']};
        //     }).toList(),
        //   },
        // ],
        data: [
          {
            'id': 'Bar',
            'data': [
              {'domain': 'Mon', 'measure': monAmount},
              {'domain': 'Tu', 'measure': tuAmount},
              {'domain': 'Wed', 'measure': wedAmount},
              {'domain': 'Thu', 'measure': thuAmount},
              {'domain': 'Fri', 'measure': friAmount},
              {'domain': 'Sat', 'measure': satAmount},
              {'domain': 'Sun', 'measure': sunAmount},
            ],
          },
        ],
        domainLabelPaddingToAxisLine: 16,
        axisLineTick: 2,
        axisLinePointTick: 2,
        axisLinePointWidth: 10,
        axisLineColor: Colors.grey[700],
        measureLabelPaddingToAxisLine: 16,
        barColor: (barData, index, id) => Colors.grey.shade800,
        showBarValue: true,
        showDomainLine: true,
      ),
    );
  }
}

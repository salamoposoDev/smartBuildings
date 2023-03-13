class ChartData {
  ChartData({required this.xValue, required this.yValue});
  ChartData.fromMap(Map<String, dynamic> dataMap)
      : xValue = dataMap['serverms'],
        yValue = dataMap['ldr1'];
  final double xValue;
  final int yValue;
}

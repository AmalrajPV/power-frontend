import 'package:flutter/material.dart';

class TimeSeriesData {
  final DateTime time;
  final double value;

  TimeSeriesData(this.time, this.value);
}

class ChartInfo {
  final String name;
  final Widget chart;

  ChartInfo({
    required this.name,
    required this.chart,
  });
}

class LiveData {
  final String voltage;
  final String power;
  final String current;
  final String frequency;
  final String energy;

  LiveData(
      {required this.voltage,
      required this.power,
      required this.current,
      required this.frequency,
      required this.energy});
}

class PowerData {
  PowerData(this.day, this.consumption);
  final String day;
  final double consumption;
  static Color getColorForDay(String day) {
    switch (day) {
      case 'Sun':
        return Colors.red.withOpacity(0.7);
      case 'Mon':
        return Colors.blue.withOpacity(0.7);
      case 'Tue':
        return Colors.green.withOpacity(0.7);
      case 'Wed':
        return Colors.orange.withOpacity(0.7);
      case 'Thu':
        return Colors.purple.withOpacity(0.7);
      case 'Fri':
        return Colors.yellow.withOpacity(0.7);
      case 'Sat':
        return Colors.indigo.withOpacity(0.7);
      default:
        return Colors.grey.withOpacity(0.7);
    }
  }
}

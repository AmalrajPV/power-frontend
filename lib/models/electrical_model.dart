class ElectricalData {
  double energy;
  double power;
  double voltage;
  double current;
  double frequency;

  ElectricalData({
    required this.energy,
    required this.power,
    required this.voltage,
    required this.current,
    required this.frequency,
  });

  factory ElectricalData.fromJson(Map<String, dynamic> json) {
    return ElectricalData(
      energy: (json['energy'] as num?)?.toDouble() ?? 0.0,
      voltage: (json['voltage'] as num?)?.toDouble() ?? 0.0,
      power: (json['power'] as num?)?.toDouble() ?? 0.0,
      current: (json['current'] as num?)?.toDouble() ?? 0.0,
      frequency: (json['frequency'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

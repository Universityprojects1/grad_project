class SensorData {
  final SoilData soilData;
  final NpkData npkData;

  SensorData({required this.soilData, required this.npkData});

  // Convert SensorData to JSON
  Map<String, dynamic> toJson() {
    return {
      'soil_data': soilData.toJson(),
      'npk_data': npkData.toJson(),
    };
  }

  // Create SensorData from JSON
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      soilData: SoilData.fromJson(json['soil_data']),
      npkData: NpkData.fromJson(json['npk_data']),
    );
  }
}

class SoilData {
  final SensorDetail moisture;
  final SensorDetail temperature;
  final SensorDetail pH;
  final SensorDetail ec;

  SoilData({
    required this.moisture,
    required this.temperature,
    required this.pH,
    required this.ec,
  });

  // Convert SoilData to JSON
  Map<String, dynamic> toJson() {
    return {
      'moisture': moisture.toJson(),
      'temperature': temperature.toJson(),
      'pH': pH.toJson(),
      'EC': ec.toJson(),
    };
  }

  // Create SoilData from JSON
  factory SoilData.fromJson(Map<String, dynamic> json) {
    return SoilData(
      moisture: SensorDetail.fromJson(json['moisture']),
      temperature: SensorDetail.fromJson(json['temperature']),
      pH: SensorDetail.fromJson(json['pH']),
      ec: SensorDetail.fromJson(json['EC']),
    );
  }
}

class SensorDetail {
  final int value;
  final double voltage;
  final double percentage;

  SensorDetail({
    required this.value,
    required this.voltage,
    required this.percentage,
  });

  // Convert SensorDetail to JSON
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'voltage': voltage,
      'percentage': percentage,
    };
  }

  // Create SensorDetail from JSON
  factory SensorDetail.fromJson(Map<String, dynamic> json) {
    return SensorDetail(
      value: json['value'],
      voltage: json['voltage'].toDouble(),
      percentage: json['percentage'].toDouble(),
    );
  }
}

class NpkData {
  final double nitrogen;
  final double phosphorus;
  final double potassium;

  NpkData(
      {required this.nitrogen,
      required this.phosphorus,
      required this.potassium});

  // Convert NpkData to JSON
  Map<String, dynamic> toJson() {
    return {
      'nitrogen': nitrogen,
      'phosphorus': phosphorus,
      'potassium': potassium,
    };
  }

  // Create NpkData from JSON
  factory NpkData.fromJson(Map<String, dynamic> json) {
    return NpkData(
      nitrogen: json['nitrogen'].toDouble(),
      phosphorus: json['phosphorus'].toDouble(),
      potassium: json['potassium'].toDouble(),
    );
  }
}

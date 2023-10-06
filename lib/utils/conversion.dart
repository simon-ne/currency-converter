class Conversion {
  String fromCurrency;
  String toCurrency;
  String valueFrom;
  double valueTo;
  DateTime dateTime;


  Conversion({
    required this.fromCurrency,
    required this.toCurrency,
    required this.valueFrom,
    required this.valueTo,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'valueFrom': valueFrom,
      'valueTo': valueTo,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory Conversion.fromJson(Map<String, dynamic> json) {
    return Conversion(
      fromCurrency: json['fromCurrency'],
      toCurrency: json['toCurrency'],
      valueFrom: json['valueFrom'].toString(),
      valueTo: json['valueTo'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
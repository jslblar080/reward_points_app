class Customer {
  final String id;
  final String phoneNumber;
  final int points;
  final int saveCount;
  final List<PointHistory> pointHistories;

  Customer({
    required this.id,
    required this.phoneNumber,
    required this.points,
    required this.saveCount,
    required this.pointHistories,
  });

  factory Customer.fromJson(String id, Map<String, dynamic> json) {
    return Customer(
      id: id,
      phoneNumber: json["phoneNumber"],
      points: json["points"],
      saveCount: json["saveCount"],
      pointHistories:
          (json["pointHistories"] as List<dynamic>)
              .map((e) => PointHistory.fromJson(e))
              .toList(),
    );
  }
}

class PointHistory {
  final DateTime dateTime;
  final int pointChange;

  PointHistory({required this.dateTime, required this.pointChange});

  Map<String, dynamic> toJson() {
    return {'dateTime': dateTime.toIso8601String(), 'pointChange': pointChange};
  }

  factory PointHistory.fromJson(Map<String, dynamic> json) {
    return PointHistory(
      dateTime: DateTime.parse(json['dateTime']),
      pointChange: json['pointChange'],
    );
  }
}

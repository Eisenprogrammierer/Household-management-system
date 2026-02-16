class Budget extends BaseModel {
  final double amount;
  final DateTime period;

  Budget({required String id, required this.amount, required this.period})
    : super(id: id);

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'period': period.toIso8601String(),
  };

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
    id: json['id'],
    amount: json['amount'],
    period: DateTime.parse(json['period']),
  );
}

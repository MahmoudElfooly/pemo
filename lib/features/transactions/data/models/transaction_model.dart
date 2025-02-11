import 'package:hive/hive.dart';

part 'transaction_model.g.dart'; // Generated file

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String cardName;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String owner;

  TransactionModel({
    required this.id,
    required this.cardName,
    required this.amount,
    required this.date,
    required this.owner,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      cardName: json['cardName'],
      amount: json['amount'].toDouble(), // Ensure amount is parsed as double
      date: DateTime.parse(json['date']), // Parse ISO 8601 date string
      owner: json['owner'],
    );
  }
}

List<TransactionModel> transactionModelResponseFromJson(dynamic json) {
  return (json as List).map((e) => TransactionModel.fromJson(e)).toList();
}

TransactionModel singleTransactionModelFromJson(Map<String, dynamic> json) {
  return TransactionModel.fromJson(json);
}

import 'package:hive/hive.dart';

part 'card_model.g.dart';

// Unique ID for the model should make it automatically in real apps
@HiveType(typeId: 1)
class CardModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String cardholder;

  @HiveField(3)
  final int balance;

  @HiveField(4)
  final String color;

  @HiveField(5)
  final String owner;

  CardModel({
    required this.id,
    required this.name,
    required this.cardholder,
    required this.balance,
    required this.color,
    required this.owner,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      cardholder: json['cardholder'],
      balance: json['balance'],
      color: json['color'],
      owner: json['owner'],
    );
  }
}

List<CardModel> cardModelResponseFromJson(dynamic json) {
  return (json as List).map((e) => CardModel.fromJson(e)).toList();
}

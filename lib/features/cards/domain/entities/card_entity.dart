import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String id;
  final String name;
  final String cardholder;
  final int balance;
  final String color;
  final String owner;

  const CardEntity({
    required this.id,
    required this.name,
    required this.cardholder,
    required this.balance,
    required this.color,
    required this.owner,
  });

  @override
  List<Object?> get props => [id, name, cardholder, balance, color, owner];
}

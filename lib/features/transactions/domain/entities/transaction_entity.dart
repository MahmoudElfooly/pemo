import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String cardName;
  final double amount;
  final DateTime date;
  final String owner;
  const TransactionEntity(
      {required this.id,
      required this.cardName,
      required this.amount,
      required this.date,
      required this.owner});

  @override
  List<Object?> get props => [id, cardName, amount, date, owner];
}

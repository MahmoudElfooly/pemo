class TransactionEntity {
  final String id;
  final String cardName;
  final double amount;
  final DateTime date;
  TransactionEntity({
    required this.id,
    required this.cardName,
    required this.amount,
    required this.date,
  });
}

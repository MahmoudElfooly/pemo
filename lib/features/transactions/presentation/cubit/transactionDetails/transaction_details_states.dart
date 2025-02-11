import '../../../domain/entities/transaction_entity.dart';

abstract class TransactionDetailsState {
  const TransactionDetailsState();
}

class TransactionDetailsInitial extends TransactionDetailsState {}

class TransactionDetailsLoading extends TransactionDetailsState {}

class TransactionDetailsLoaded extends TransactionDetailsState {
  final TransactionEntity transactions;

  const TransactionDetailsLoaded(this.transactions);
}

class TransactionDetailsError extends TransactionDetailsState {
  final String message;

  const TransactionDetailsError(this.message);
}

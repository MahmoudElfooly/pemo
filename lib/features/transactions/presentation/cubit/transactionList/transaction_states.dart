import 'package:equatable/equatable.dart';
import 'package:pemo/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class TransactionEmpty extends TransactionState {}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pemo/features/transactions/presentation/cubit/transactionList/transaction_states.dart';

import '../../../domain/useCase/transaction_use_case.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionUseCase _transactionUseCase;

  TransactionCubit(this._transactionUseCase) : super(TransactionInitial());

  Future<void> loadTransactions() async {
    emit(TransactionLoading());
    final transactions = await _transactionUseCase.getTransactions();
    if (transactions.isEmpty) {
      emit(TransactionEmpty());
    } else {
      emit(TransactionLoaded(transactions));
    }
  }
}

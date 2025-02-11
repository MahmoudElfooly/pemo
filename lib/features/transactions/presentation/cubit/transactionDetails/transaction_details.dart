import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pemo/features/transactions/presentation/cubit/transactionDetails/transaction_details_states.dart';

import '../../../domain/useCase/transaction_use_case.dart';

class TransactionDetailsCubit extends Cubit<TransactionDetailsState> {
  final TransactionUseCase _transactionUseCase;

  TransactionDetailsCubit(this._transactionUseCase)
      : super(TransactionDetailsInitial());

  Future<void> getTransactionById(String id) async {
    emit(TransactionDetailsLoading());
    final transaction = await _transactionUseCase.getTransactionById(id);
    if (transaction != null) {
      emit(TransactionDetailsLoaded(transaction));
    } else {
      emit(TransactionDetailsError("No Data"));
    }
  }
}

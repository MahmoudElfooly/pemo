import 'package:pemo/features/transactions/domain/repository/transaction_repository.dart';

import '../entities/transaction_entity.dart';
import '../mapper/transaction_mapper.dart';

abstract class TransactionUseCase {
  Future<List<TransactionEntity>> getTransactions();
  Future<TransactionEntity?> getTransactionById(String id);
}

class TransactionUseCaseImp implements TransactionUseCase {
  final TransactionRepository _repository;
  final TransactionMapper _transactionMapper;

  TransactionUseCaseImp(this._repository, this._transactionMapper);

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final result = await _repository.getTransactions();

    return result.fold(
      (failure) => [], // Directly return Empty List if there's an error
      (transactions) => _transactionMapper.transactionModelListToEntityList(
          transactions), // Return the list of transactions
    );
  }

  @override
  Future<TransactionEntity?> getTransactionById(String id) async {
    final result = await _repository.getTransactionById(id);

    return result.fold(
      (failure) => null, // Directly return Empty List if there's an error
      (transactions) => _transactionMapper.transactionModelToEntity(
          transactions), // Return the list of transactions
    );
  }
}

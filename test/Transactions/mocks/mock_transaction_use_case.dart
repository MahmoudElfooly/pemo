import 'package:pemo/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pemo/features/transactions/domain/useCase/transaction_use_case.dart';

class MockTransactionUseCase implements TransactionUseCase {
  bool shouldSucceed = true;
  bool shouldThrowError = false;
  List<TransactionEntity> transactionEntityList = [];

  @override
  Future<TransactionEntity?> getTransactionById(String id) async {
    if (shouldThrowError) {
      return Future.error(Exception("Error fetching transaction by ID"));
    }
    return Future.value(transactionEntityList.firstWhere(
      (transaction) => transaction.id == id,
      orElse: () => throw Exception("Transaction not found"),
    ));
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    if (shouldThrowError) {
      return Future.error(Exception("Error fetching transactions"));
    }
    return Future.value(shouldSucceed ? transactionEntityList : []);
  }

  void setMockData({
    bool success = true,
    bool throwError = false,
    List<TransactionEntity>? transactions,
  }) {
    shouldSucceed = success;
    shouldThrowError = throwError;
    if (transactions != null) {
      transactionEntityList = transactions;
    }
  }
}

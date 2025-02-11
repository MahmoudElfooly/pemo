import 'package:dartz/dartz.dart';
import 'package:pemo/core/localStorageManager/local_storage_manager.dart';
import 'package:pemo/features/transactions/data/models/transaction_model.dart';
import 'package:pemo/features/transactions/domain/repository/transaction_repository.dart';

import '../../../../core/localStorageManager/local_storage_keys.dart';
import '../../../../core/networkService/connectivity.dart';
import '../../../../core/networkService/models/api_request_failur.dart';
import '../dataSource/localData/transaction_local_data.dart';
import '../dataSource/remoteData/transactions_remote_services.dart';

class TransactionRepositoryImp implements TransactionRepository {
  final TransactionsRemoteServices _transactionsRemoteServices =
      TransactionsRemoteServices();
  final TransactionLocalData _transactionLocalData = TransactionLocalData();

  @override
  Future<Either<ApiRequestFailure, List<TransactionModel>>>
      getTransactions() async {
    bool isConnected = await connectedToNetwork();

    if (isConnected) {
      final response = await _transactionsRemoteServices.getMyTransactions();
      return response.fold((error) {
        return left(ApiRequestFailure(failureMsg: error.failureMsg));
      }, (data) async {
        LocalStorageManager.saveList(DefaultsKeys.transactionList, data);
        return right(data);
      });
    } else {
      final data = _transactionLocalData.getLocalTransaction();
      return right(data);
    }
  }

  @override
  Future<Either<ApiRequestFailure, TransactionModel>> getTransactionById(
      String id) async {
    final response = await _transactionsRemoteServices.getMyTransactionById(id);
    return response.fold((error) {
      return left(ApiRequestFailure(failureMsg: error.failureMsg));
    }, (data) async {
      return right(data);
    });
  }
}

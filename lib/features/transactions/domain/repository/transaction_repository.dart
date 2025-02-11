import 'package:dartz/dartz.dart';

import '../../../../core/networkService/models/api_request_failur.dart';
import '../../data/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<Either<ApiRequestFailure, List<TransactionModel>>> getTransactions();
  Future<Either<ApiRequestFailure, TransactionModel>> getTransactionById(
      String id);
}

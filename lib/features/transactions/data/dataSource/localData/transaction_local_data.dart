import 'package:pemo/features/transactions/data/models/transaction_model.dart';

import '../../../../../core/localStorageManager/local_storage_keys.dart';
import '../../../../../core/localStorageManager/local_storage_manager.dart';

abstract class TransactionLocalData {
  List<TransactionModel> getLocalTransaction();
}

class TransactionLocalDataImp implements TransactionLocalData {
  @override
  List<TransactionModel> getLocalTransaction() {
    return LocalStorageManager.getList<TransactionModel>(
            DefaultsKeys.transactionList) ??
        [];
  }
}

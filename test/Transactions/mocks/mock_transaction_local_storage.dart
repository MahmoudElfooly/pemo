import 'package:pemo/features/transactions/data/dataSource/localData/transaction_local_data.dart';
import 'package:pemo/features/transactions/data/models/transaction_model.dart';

class MockTransactionLocalData implements TransactionLocalData {
  // Mock transactions list
  bool shouldReturnData = true;
  List<TransactionModel> mockTransactions = [];

  @override
  List<TransactionModel> getLocalTransaction() {
    return shouldReturnData ? mockTransactions : [];
  }
}

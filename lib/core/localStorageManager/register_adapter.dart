import 'package:hive_flutter/adapters.dart';

import '../../features/cards/data/models/card_model.dart';
import '../../features/transactions/data/models/transaction_model.dart';

class HiveRegisterAdapter {
  static void registerAdapters() {
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(CardModelAdapter());
  }
}

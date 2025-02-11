import '../../data/models/transaction_model.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionMapper {
  TransactionEntity transactionModelToEntity(TransactionModel model);
  List<TransactionEntity> transactionModelListToEntityList(
      List<TransactionModel> models);
}

class TransactionMapperImp implements TransactionMapper {
  @override
  TransactionEntity transactionModelToEntity(TransactionModel model) {
    return TransactionEntity(
        id: model.id,
        cardName: model.cardName,
        amount: model.amount,
        date: model.date,
        owner: model.owner);
  }

  @override
  List<TransactionEntity> transactionModelListToEntityList(
      List<TransactionModel> models) {
    return models.map(transactionModelToEntity).toList();
  }
}

import 'package:pemo/features/cards/data/models/card_model.dart';
import 'package:pemo/features/cards/domain/entities/card_entity.dart';

abstract class CardMapper {
  CardEntity cardModelToEntity(CardModel model);
  List<CardEntity> cardModelListToEntityList(List<CardModel> models);
}

class CardMapperMapperImp implements CardMapper {
  @override
  CardEntity cardModelToEntity(CardModel model) {
    return CardEntity(
      id: model.id,
      owner: model.owner,
      name: model.name,
      cardholder: model.cardholder,
      balance: model.balance,
      color: model.color,
    );
  }

  @override
  List<CardEntity> cardModelListToEntityList(List<CardModel> models) {
    return models.map(cardModelToEntity).toList();
  }
}

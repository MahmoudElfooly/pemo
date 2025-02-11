import 'package:pemo/core/networkService/models/success_model.dart';
import 'package:pemo/features/cards/domain/entities/card_entity.dart';
import 'package:pemo/features/cards/domain/mapper/card_mapper.dart';
import 'package:pemo/features/cards/domain/repository/card_repository.dart';

import '../entities/add_card_payload.dart';

abstract class CardUseCase {
  Future<SuccessModelResponse?> createCard(AddCardPayload card);
  Future<List<CardEntity>> getCards();
}

class CardUseCaseImp implements CardUseCase {
  final CardRepository _repository;
  final CardMapper _mapper;

  CardUseCaseImp(this._repository, this._mapper);
  @override
  Future<SuccessModelResponse?> createCard(AddCardPayload card) async {
    final result = await _repository.createCard(card);

    return result.fold(
      (failure) => null,
      (result) => result,
    );
  }

  @override
  Future<List<CardEntity>> getCards() async {
    final result = await _repository.getCards();

    return result.fold(
      (failure) => [],
      (cards) => _mapper.cardModelListToEntityList(cards),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pemo/features/cards/domain/useCase/card_use_case.dart';

import '../../domain/entities/add_card_payload.dart';
import 'card_states.dart';

class CardCubit extends Cubit<CardStates> {
  final CardUseCase _cardUseCase;

  CardCubit(this._cardUseCase) : super(CardInitial());

  Future<void> createCard(AddCardPayload card) async {
    emit(AddCardLoading());
    final result = await _cardUseCase.createCard(card);
    if (result != null && result.status == 1) {
      emit(CardAddedSuccessfully(result.message));
    } else {
      emit(AddCardError(result?.message ?? "Failed"));
    }
  }

  Future<void> loadCards() async {
    emit(CardLoading());
    final cards = await _cardUseCase.getCards();
    if (cards.isEmpty) {
      emit(CardEmpty());
    } else {
      emit(CardLoaded(cards));
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:pemo/features/cards/domain/entities/card_entity.dart';

abstract class CardStates extends Equatable {
  const CardStates();

  @override
  List<Object?> get props => [];
}

class CardInitial extends CardStates {}

class CardLoading extends CardStates {}

class AddCardLoading extends CardStates {}

class CardAddedSuccessfully extends CardStates {
  final String message;

  const CardAddedSuccessfully(this.message);

  @override
  List<Object?> get props => [message];
}

class CardLoaded extends CardStates {
  final List<CardEntity> Cards;

  const CardLoaded(this.Cards);

  @override
  List<Object?> get props => [Cards];
}

class CardEmpty extends CardStates {}

class CardError extends CardStates {
  final String message;

  const CardError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddCardError extends CardStates {
  final String message;

  const AddCardError(this.message);

  @override
  List<Object?> get props => [message];
}

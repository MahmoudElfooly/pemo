import 'package:dartz/dartz.dart';

import '../../../../core/networkService/models/api_request_failur.dart';
import '../../../../core/networkService/models/success_model.dart';
import '../../data/models/card_model.dart';
import '../entities/add_card_payload.dart';

abstract class CardRepository {
  Future<Either<ApiRequestFailure, SuccessModelResponse>> createCard(
      AddCardPayload card);
  Future<Either<ApiRequestFailure, List<CardModel>>> getCards();
}

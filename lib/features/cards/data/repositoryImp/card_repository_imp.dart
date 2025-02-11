import 'package:dartz/dartz.dart';
import 'package:pemo/features/cards/data/dataSource/remoteData/card_remote_service.dart';

import '../../../../core/localStorageManager/local_storage_keys.dart';
import '../../../../core/localStorageManager/local_storage_manager.dart';
import '../../../../core/networkService/connectivity.dart';
import '../../../../core/networkService/models/api_request_failur.dart';
import '../../../../core/networkService/models/success_model.dart';
import '../../domain/entities/add_card_payload.dart';
import '../../domain/repository/card_repository.dart';
import '../dataSource/localData/card_local_services.dart';
import '../models/card_model.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteServices _cardRemoteServices = CardRemoteServices();
  final CardLocalServices _cardLocalServices = CardLocalServices();

  @override
  Future<Either<ApiRequestFailure, SuccessModelResponse>> createCard(
      AddCardPayload card) async {
    final response = await _cardRemoteServices.addCard(card);
    return response.fold((error) {
      return left(ApiRequestFailure(failureMsg: error.failureMsg));
    }, (data) async {
      return right(data);
    });
  }

  @override
  Future<Either<ApiRequestFailure, List<CardModel>>> getCards() async {
    bool isConnected = await connectedToNetwork();

    if (isConnected) {
      final response = await _cardRemoteServices.getMyCards();
      return response.fold((error) {
        return left(ApiRequestFailure(failureMsg: error.failureMsg));
      }, (data) async {
        LocalStorageManager.saveList(DefaultsKeys.cardsList, data);
        return right(data);
      });
    } else {
      final data = _cardLocalServices.getLocalCards();
      return right(data);
    }
  }
}

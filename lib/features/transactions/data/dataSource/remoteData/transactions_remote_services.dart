import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pemo/core/networkService/dio/network_service.dart';
import 'package:pemo/features/transactions/data/models/transaction_model.dart';

import '../../../../../core/networkService/base_service.dart';
import '../../../../../core/networkService/dio/network_exceptions.dart';
import '../../../../../core/networkService/header.dart';
import '../../../../../core/networkService/models/api_request_failur.dart';
import '../../../../../utils/constant_keywords.dart';
import '../../../../../utils/urls.dart';

class TransactionsRemoteServices extends BaseService {
  final NetworkService networkService = NetworkService();

  Future<Either<ApiRequestFailure, List<TransactionModel>>>
      getMyTransactions() async {
    String url = Urls.getTransactions;
    try {
      final result = await networkService.get(
        url,
        headers: HeaderData.getHeader(),
        query: null,
      );

      return result.fold(
        (failure) {
          return Left(ApiRequestFailure(failureMsg: failure.message));
        },
        (response) {
          // Check if the response is successful
          if (response.statusCode == ConstantKeys.successfullyApi200 ||
              response.statusCode == ConstantKeys.successfullyApi201) {
            // Parse the response body
            dynamic result;
            if (response.data is List) {
              result = response.data;
            } else {
              // Handle unexpected response type
              return Left(
                  ApiRequestFailure(failureMsg: 'Invalid response type'));
            }
            final transactions = transactionModelResponseFromJson(result);
            return Right(transactions);
          } else {
            // Handle non-200/201 responses
            final result = json.decode(response.toString());
            return Left(ApiRequestFailure(
                failureMsg: result['message'] ?? 'Unknown error'));
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
          ApiRequestFailure(failureMsg: NetworkExceptions.getDioException(e)));
    }
  }

  Future<Either<ApiRequestFailure, TransactionModel>> getMyTransactionById(
      String id) async {
    String url = "${Urls.getTransactions}/$id";
    try {
      final result = await networkService.get(
        url,
        headers: HeaderData.getHeader(),
        query: null,
      );

      return result.fold(
        (failure) {
          return Left(ApiRequestFailure(failureMsg: failure.message));
        },
        (response) {
          // Check if the response is successful
          if (response.statusCode == ConstantKeys.successfullyApi200 ||
              response.statusCode == ConstantKeys.successfullyApi201) {
            // Parse the response body
            dynamic result;
            if (response.data is Map<String, dynamic>) {
              result = response.data;
            } else {
              return Left(
                  ApiRequestFailure(failureMsg: 'Invalid response type'));
            }
            final transactions = singleTransactionModelFromJson(result);
            return Right(transactions);
          } else {
            // Handle non-200/201 responses
            final result = json.decode(response.toString());
            return Left(ApiRequestFailure(
                failureMsg: result['message'] ?? 'Unknown error'));
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      return Left(
          ApiRequestFailure(failureMsg: NetworkExceptions.getDioException(e)));
    }
  }
}

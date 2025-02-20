import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pemo/core/networkService/models/api_request_failur.dart';
import 'package:pemo/features/transactions/data/models/transaction_model.dart'
    as model;
import 'package:pemo/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pemo/features/transactions/domain/mapper/transaction_mapper.dart';
import 'package:pemo/features/transactions/domain/repository/transaction_repository.dart';
import 'package:pemo/features/transactions/domain/useCase/transaction_use_case.dart';

import 'transaction_use_case_test.mocks.dart';

@GenerateMocks([TransactionRepository, TransactionMapper])
void main() {
  late TransactionUseCase useCase;
  late MockTransactionRepository mockRepository;
  late MockTransactionMapper mockMapper;

  setUp(() {
    mockRepository = MockTransactionRepository();
    mockMapper = MockTransactionMapper();
    useCase = TransactionUseCaseImp(mockRepository, mockMapper);
  });

  group('getTransactions', () {
    test(
        'should return a list of TransactionEntity when repository returns data',
        () async {
      // Arrange
      final mockTransactions = [
        model.TransactionModel(
            id: "1", amount: 100, cardName: '', date: DateTime.now(), owner: '')
      ];
      final mockEntities = [
        TransactionEntity(
            id: "1", amount: 100, cardName: '', date: DateTime.now(), owner: '')
      ];

      when(mockRepository.getTransactions())
          .thenAnswer((_) async => Right(mockTransactions));

      when(mockMapper.transactionModelListToEntityList(mockTransactions))
          .thenReturn(mockEntities);

      // Act
      final result = await useCase.getTransactions();

      // Assert
      expect(result, mockEntities);
      verify(mockRepository.getTransactions()).called(1);
      verify(mockMapper.transactionModelListToEntityList(mockTransactions))
          .called(1);
    });

    test('should return an empty list when repository returns failure',
        () async {
      // Arrange
      when(mockRepository.getTransactions()).thenAnswer((_) async =>
          Left(ApiRequestFailure(failureMsg: 'Error fetching transactions')));

      // Act
      final result = await useCase.getTransactions();

      // Assert
      expect(result, []);
      verify(mockRepository.getTransactions()).called(1);
      verifyNever(mockMapper.transactionModelListToEntityList(any));
    });
  });

  group('getTransactionById', () {
    test('should return a TransactionEntity when repository returns data',
        () async {
      // Arrange
      const transactionId = "1";
      final mockTransaction = model.TransactionModel(
          id: transactionId,
          amount: 100,
          cardName: '',
          date: DateTime.now(),
          owner: '');
      final mockEntity = TransactionEntity(
          id: transactionId,
          amount: 100,
          cardName: '',
          date: DateTime.now(),
          owner: '');

      when(mockRepository.getTransactionById(transactionId))
          .thenAnswer((_) async => Right(mockTransaction));

      when(mockMapper.transactionModelToEntity(mockTransaction))
          .thenReturn(mockEntity);

      // Act
      final result = await useCase.getTransactionById(transactionId);

      // Assert
      expect(result, mockEntity);
      verify(mockRepository.getTransactionById(transactionId)).called(1);
      verify(mockMapper.transactionModelToEntity(mockTransaction)).called(1);
    });

    test('should return null when repository returns failure', () async {
      // Arrange
      const transactionId = "1";

      when(mockRepository.getTransactionById(transactionId)).thenAnswer(
          (_) async =>
              Left(ApiRequestFailure(failureMsg: 'Transaction not found')));

      // Act
      final result = await useCase.getTransactionById(transactionId);

      // Assert
      expect(result, null);
      verify(mockRepository.getTransactionById(transactionId)).called(1);
      verifyNever(mockMapper.transactionModelToEntity(any));
    });
  });
}

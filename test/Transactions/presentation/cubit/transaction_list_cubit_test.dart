import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pemo/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pemo/features/transactions/presentation/cubit/transactionList/transaction_cubit.dart';
import 'package:pemo/features/transactions/presentation/cubit/transactionList/transaction_states.dart';

import '../../mocks/mock_transaction_use_case.dart';

void main() {
  late TransactionCubit transactionCubit;
  late MockTransactionUseCase mockTransactionUseCase;

  setUp(() {
    mockTransactionUseCase = MockTransactionUseCase();
    transactionCubit = TransactionCubit(mockTransactionUseCase);
  });

  tearDown(() {
    transactionCubit.close();
  });

  test('Initial state should be TransactionInitial', () {
    expect(transactionCubit.state, TransactionInitial());
  });

  blocTest<TransactionCubit, TransactionState>(
    'Emits [TransactionLoading, TransactionLoaded] when transactions are successfully loaded',
    build: () {
      mockTransactionUseCase.setMockData(
        success: true,
        transactions: [
          TransactionEntity(
            id: '1',
            cardName: 'Visa Gold',
            amount: 200.0,
            date: DateTime(2024, 2, 11),
            owner: 'user1',
          ),
        ],
      );

      return transactionCubit;
    },
    act: (cubit) => cubit.loadTransactions(),
    expect: () => [
      TransactionLoading(),
      TransactionLoaded([
        TransactionEntity(
          id: '1',
          cardName: 'Visa Gold',
          amount: 200.0,
          date: DateTime(2024, 2, 11),
          owner: 'user1',
        ),
      ]),
    ],
  );

  blocTest<TransactionCubit, TransactionState>(
    'Emits [TransactionLoading, TransactionEmpty] when no transactions are found',
    build: () {
      mockTransactionUseCase.setMockData(success: false);
      return transactionCubit;
    },
    act: (cubit) => cubit.loadTransactions(),
    expect: () => [
      TransactionLoading(),
      TransactionEmpty(),
    ],
  );
}

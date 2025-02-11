import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pemo/core/servicesLocator/services_locator.dart';
import 'package:pemo/features/transactions/domain/useCase/transaction_use_case.dart';

import '../../cubit/transactionList/transaction_cubit.dart';
import '../../cubit/transactionList/transaction_states.dart';
import '../../widgets/transaction_card.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionCubit(locator<TransactionUseCase>())..loadTransactions(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transactions')),
        body: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionEmpty) {
              return const Center(child: Text('No transactions found.'));
            } else if (state is TransactionError) {
              return Center(child: Text(state.message));
            } else if (state is TransactionLoaded) {
              final transactions = state.transactions;
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return TransactionCard(transaction: transaction);
                },
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pemo/core/servicesLocator/services_locator.dart';
import 'package:pemo/extension/string_extensions.dart';
import 'package:pemo/features/transactions/domain/useCase/transaction_use_case.dart';

import '../../cubit/transactionDetails/transaction_details.dart';
import '../../cubit/transactionDetails/transaction_details_states.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String transactionId;
  const TransactionDetailsScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransactionDetailsCubit(locator<TransactionUseCase>())
            ..getTransactionById(transactionId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaction Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<TransactionDetailsCubit, TransactionDetailsState>(
          builder: (context, state) {
            if (state is TransactionDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is TransactionDetailsLoaded) {
              final transaction = state.transactions;
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    transaction.cardName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "\$${transaction.amount.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    transaction.date.toString().toFormattedDate(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}

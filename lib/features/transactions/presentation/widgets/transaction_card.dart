import 'package:flutter/material.dart';

import '../../domain/entities/transaction_entity.dart';
import '../screens/transaction_details/transaction_details.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add margin
      elevation: 4, // Add shadow
      child: ListTile(
        title: Text(
          transaction.cardName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "\$${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward_ios), // Add a trailing icon
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailsScreen(transactionId: transaction.id),
            ),
          );
        },
      ),
    );
  }
}

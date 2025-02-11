import 'package:flutter/material.dart';

import '../../../../uiHelper/color_parser.dart';
import '../../domain/entities/card_entity.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.card,
  });

  final CardEntity card;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: parseColor(card.color), // Set card background color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Cardholder: ${card.cardholder}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Balance: \$${card.balance.toString()}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Owner: ${card.owner}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

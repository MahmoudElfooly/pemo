import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

// ----------------- MODELS -----------------
class CardModel {
  final String id;
  final String name;
  final String cardholder;
  final int balance;
  final String color;
  final String owner;

  const CardModel({
    required this.id,
    required this.name,
    required this.cardholder,
    required this.balance,
    required this.color,
    required this.owner,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cardholder': cardholder,
        'balance': balance,
        'color': color,
        'owner': owner,
      };

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      cardholder: json['cardholder'],
      balance: json['balance'],
      color: json['color'],
      owner: json['owner'],
    );
  }
}

class TransactionModel {
  final String id;
  final String cardName;
  final double amount;
  final DateTime date;
  final String owner; // User who owns the transaction

  TransactionModel({
    required this.id,
    required this.cardName,
    required this.amount,
    required this.date,
    required this.owner,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'cardName': cardName,
        'amount': amount,
        'date': date.toIso8601String(),
        'owner': owner,
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      cardName: json['cardName'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      owner: json['owner'],
    );
  }
}

// ----------------- MOCK DATA -----------------
final List<CardModel> cards = [
  CardModel(
      id: "1",
      name: "Visa Gold",
      cardholder: "John Doe",
      balance: 5000,
      color: "#FF0000",
      owner: "user1"),
  CardModel(
      id: "2",
      name: "Mastercard Platinum",
      cardholder: "Jane Smith",
      balance: 10000,
      color: "#00FF00",
      owner: "user2"),
  CardModel(
      id: "3",
      name: "Amex Blue",
      cardholder: "John Doe",
      balance: 7500,
      color: "#0000FF",
      owner: "user1"),
];

final List<TransactionModel> transactions = [
  TransactionModel(
      id: "101",
      cardName: "Visa Gold",
      amount: 200.0,
      date: DateTime.now(),
      owner: "user1"),
  TransactionModel(
      id: "102",
      cardName: "Mastercard Platinum",
      amount: 150.5,
      date: DateTime.now(),
      owner: "user2"),
];

// ----------------- API ROUTES -----------------
final app = Router()
// Get user cards
  ..get('/cards', (Request request) {
    final username = request.headers['Authorization'];
    if (username == null || username.isEmpty) {
      return Response.forbidden(
          jsonEncode({'error': 'Missing Authorization token'}));
    }

    final userCards = cards.where((card) => card.owner == username).toList();
    return Response.ok(jsonEncode(userCards.map((c) => c.toJson()).toList()),
        headers: {'Content-Type': 'application/json'});
  })

// Add a new card
  ..post('/cards', (Request request) async {
    final username = request.headers['Authorization'];
    if (username == null || username.isEmpty) {
      return Response.forbidden(
          jsonEncode({'status': 0, 'message': 'Missing Authorization token'}));
    }

    final body = await request.readAsString();
    final jsonData = jsonDecode(body);
    final newCard = CardModel.fromJson(jsonData);

    if (newCard.owner != username) {
      return Response.forbidden(jsonEncode(
          {'status': 0, 'message': 'You can only add cards for yourself'}));
    }

    cards.add(newCard);
    return Response.ok(
        jsonEncode({'status': 1, 'message': 'Card added successfully'}),
        headers: {'Content-Type': 'application/json'});
  })

// Get user transactions
  ..get('/transactions', (Request request) {
    final username = request.headers['Authorization'];
    if (username == null || username.isEmpty) {
      return Response.forbidden(
          jsonEncode({'error': 'Missing Authorization token'}));
    }

    final userTransactions =
        transactions.where((txn) => txn.owner == username).toList();
    return Response.ok(
        jsonEncode(userTransactions.map((t) => t.toJson()).toList()),
        headers: {'Content-Type': 'application/json'});
  })

// Get transaction by ID
  ..get('/transactions/<id>', (Request request, String id) {
    final username = request.headers['Authorization'];
    if (username == null || username.isEmpty) {
      return Response.forbidden(
          jsonEncode({'error': 'Missing Authorization token'}));
    }

    final transaction = transactions.firstWhere(
      (txn) => txn.id == id && txn.owner == username,
      orElse: () => TransactionModel(
          id: "", cardName: "", amount: 0, date: DateTime(1970), owner: ""),
    );

    if (transaction.id.isEmpty) {
      return Response.notFound(jsonEncode({"error": "Transaction not found"}));
    }

    return Response.ok(jsonEncode(transaction.toJson()),
        headers: {'Content-Type': 'application/json'});
  });

// ----------------- START SERVER -----------------
void main() async {
  final server = await io.serve(app, 'localhost', 8080);
  print('Mock API running on http://${server.address.host}:${server.port}');
}

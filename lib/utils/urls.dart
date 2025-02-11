import '../core/environment/environment.dart';

class Urls {
  static final String baseUrl = Environment.apiUrl;
  static final String getCards = "${Environment.apiUrl}cards";
  static final String addCard = "${Environment.apiUrl}cards";
  static final String getTransactions = "${Environment.apiUrl}transactions";
}

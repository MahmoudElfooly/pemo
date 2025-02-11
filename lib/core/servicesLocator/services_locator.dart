import 'package:get_it/get_it.dart';
import 'package:pemo/features/cards/domain/mapper/card_mapper.dart';
import 'package:pemo/features/cards/domain/useCase/card_use_case.dart';
import 'package:pemo/features/transactions/domain/mapper/transaction_mapper.dart';
import 'package:pemo/features/transactions/domain/useCase/transaction_use_case.dart';

import '../../features/cards/data/repositoryImp/card_repository_imp.dart';
import '../../features/cards/domain/repository/card_repository.dart';
import '../../features/transactions/data/repositoryImp/transaction_repository_imp.dart';
import '../../features/transactions/domain/repository/transaction_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  //Transactions
  locator.registerSingleton<TransactionMapper>(TransactionMapperImp());
  locator.registerSingleton<TransactionRepository>(TransactionRepositoryImp());
  locator.registerSingleton<TransactionUseCase>(TransactionUseCaseImp(
      locator<TransactionRepository>(), locator<TransactionMapper>()));
  //Cards
  locator.registerSingleton<CardMapper>(CardMapperMapperImp());
  locator.registerSingleton<CardRepository>(CardRepositoryImpl());
  locator.registerSingleton<CardUseCase>(
      CardUseCaseImp(locator<CardRepository>(), locator<CardMapper>()));
}

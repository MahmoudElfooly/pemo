import 'package:pemo/features/cards/data/models/card_model.dart';

import '../../../../../core/localStorageManager/local_storage_keys.dart';
import '../../../../../core/localStorageManager/local_storage_manager.dart';

class CardLocalServices {
  List<CardModel> getLocalCards() {
    return LocalStorageManager.getList<CardModel>(DefaultsKeys.cardsList) ?? [];
  }
}

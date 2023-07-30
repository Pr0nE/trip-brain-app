import 'package:trip_brain_domain/src/payment/suggestion_price.dart';

abstract class PaymentManager {
  Future<bool> buyBalance(int amount);
  Future<List<SuggestionPrice>> getSuggestionPrices();
}

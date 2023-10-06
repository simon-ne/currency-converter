import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterService {
  final String _apiKey = dotenv.env['API_KEY']!; // Replace with your actual API key
  final String _apiUrl = dotenv.env['API_URL']!;

  Future<double?> convertCurrencies({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
  }) async {
    try {
      if (amount == 0.0) {
        return Future.value(0.0);
      }

      final response = await http.get(
        Uri.parse('${_apiUrl}latest?base_currency=$fromCurrency&currencies=$toCurrency&apikey=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final conversionRate = data['data'][toCurrency];

        if (conversionRate != null) {
          final convertedAmount = conversionRate * amount;
          return convertedAmount;
        }
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}
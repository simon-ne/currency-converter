import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final fetchCurrenciesProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final String apiUrl = dotenv.env['API_URL']!;
  final String apiKey = dotenv.env['API_KEY']!;

  try {
    final response = await http.get(
      Uri.parse('$apiUrl/currencies?apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final Map<String, dynamic> currenciesJson = data['data'];

      if (currenciesJson.containsKey('CZK')) {
        currenciesJson.remove('CZK');
      }
      
      return currenciesJson.keys.toList();
    }
  } catch (e) {
    return [];
  }

  return [];
});

import 'dart:convert';
import 'package:currency_converter/utils/conversion.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversionHistoryService {
  final String _key = 'conversionHistory';

  Future<void> saveConversion(Conversion conversion) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final history = await loadConversionHistory();

    history.add(conversion);

    final jsonString = jsonEncode(history.map((conversion) => conversion.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<List<Conversion>> loadConversionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    final List<Conversion> history = jsonList.map((json) {
      return Conversion.fromJson(json);
    }).toList();
    return history;
  }

  Future<void> deleteConversionHistory() async {
    var history = await loadConversionHistory();

    if (history.isEmpty) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

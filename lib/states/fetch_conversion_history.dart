import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/services/conversion_history_service.dart';
import 'package:currency_converter/utils/conversion.dart';

final fetchConversionHistoryProvider = FutureProvider.autoDispose<List<Conversion>>((ref) async {
  ConversionHistoryService conversionHistoryService = ConversionHistoryService();
  return await conversionHistoryService.loadConversionHistory();
});
import 'package:currency_converter/states/fetch_conversion_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/services/conversion_history_service.dart';

final deleteConversionHistoryProvider = FutureProvider.autoDispose<void>((ref) async {
  ConversionHistoryService conversionHistoryService = ConversionHistoryService();
  await conversionHistoryService.deleteConversionHistory();
  ref.invalidate(fetchConversionHistoryProvider);
});

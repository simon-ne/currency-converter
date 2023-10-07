import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/services/conversion_history_service.dart';
import 'package:currency_converter/states/fetch_conversion_history.dart';
import 'package:currency_converter/utils/conversion.dart';

final saveConversionProvider = FutureProvider.autoDispose.family<void, Conversion>((
  ref,
  Conversion conversion,
) async {
  ConversionHistoryService conversionHistoryService = ConversionHistoryService();
  await conversionHistoryService.saveConversion(conversion);
  ref.invalidate(fetchConversionHistoryProvider);
});

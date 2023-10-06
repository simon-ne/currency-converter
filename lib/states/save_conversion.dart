import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/services/conversion_history_service.dart';
import 'package:my_app/states/fetch_conversion_history.dart';
import 'package:my_app/utils/conversion.dart';

final saveConversionProvider = FutureProvider.autoDispose.family<void, Conversion>((
  ref,
  Conversion conversion,
) async {
  ConversionHistoryService conversionHistoryService = ConversionHistoryService();
  await conversionHistoryService.saveConversion(conversion);
  ref.invalidate(fetchConversionHistoryProvider);
});

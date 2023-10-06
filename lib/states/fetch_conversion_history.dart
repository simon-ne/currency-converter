import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/services/conversion_history_service.dart';
import 'package:my_app/utils/conversion.dart';

final fetchConversionHistoryProvider = FutureProvider.autoDispose<List<Conversion>>((ref) async {
  ConversionHistoryService conversionHistoryService = ConversionHistoryService();
  return await conversionHistoryService.loadConversionHistory();
});
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/states/conversion_controller/conversion_controller.dart';
import 'package:currency_converter/utils/conversion.dart';

// final conversionControllerProvider = Provider<ConversionController>((ref) {
//   return ConversionController();
// });

final conversionControllerProvider =
    StateNotifierProvider.autoDispose<ConversionController, Conversion>(
  (ref) {
    return ConversionController();
  },
);
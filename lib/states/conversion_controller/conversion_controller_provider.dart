import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/states/conversion_controller/conversion_controller.dart';
import 'package:my_app/utils/conversion.dart';

// final conversionControllerProvider = Provider<ConversionController>((ref) {
//   return ConversionController();
// });

final conversionControllerProvider =
    StateNotifierProvider.autoDispose<ConversionController, Conversion>(
  (ref) {
    return ConversionController();
  },
);
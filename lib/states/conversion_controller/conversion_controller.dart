import 'package:currency_converter/services/conversion_history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/services/currency_converter_service.dart';
import 'package:currency_converter/utils/conversion.dart';

class ConversionController extends StateNotifier<Conversion> {
  final CurrencyConverterService currencyConverterService =
      CurrencyConverterService();
  final ConversionHistoryService conversionHistoryService =
      ConversionHistoryService();

  ConversionController()
      : super(
          Conversion(
            fromCurrency: 'CZK',
            toCurrency: 'EUR',
            valueFrom: '',
            valueTo: 0.0,
            dateTime: DateTime.now(),
          ),
        );

  void updateConversionState({
    String? fromCurrency,
    String? toCurrency,
    String? valueFrom,
    double? valueTo,
    DateTime? dateTime,
  }) {
    state = Conversion(
      fromCurrency: fromCurrency ?? state.fromCurrency,
      toCurrency: toCurrency ?? state.toCurrency,
      valueFrom: valueFrom ?? state.valueFrom,
      valueTo: valueTo ?? state.valueTo,
      dateTime: dateTime ?? state.dateTime,
    );
  }

  Future<void> performConversion({
    required VoidCallback onError,
    required VoidCallback onSuccess,
  }) async {
    if (state.valueTo != 0.0) {
      return;
    }

    if (state.valueFrom == '') {
      return;
    }

    var result = await currencyConverterService.convertCurrencies(
      fromCurrency: state.fromCurrency,
      toCurrency: state.toCurrency,
      amount: double.tryParse(state.valueFrom)!,
    );

    if (result == null) {
      onError();
      return;
    }

    updateConversionState(
      valueTo: result,
      dateTime: DateTime.now(),
    );

    onSuccess();
  }
}

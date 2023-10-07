import 'package:currency_converter/states/delete_conversion_history.dart';
import 'package:currency_converter/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currency_converter/screens/home_screen/conversion_input_from.dart';
import 'package:currency_converter/screens/home_screen/conversion_input_to.dart';
import 'package:currency_converter/services/conversion_history_service.dart';
import 'package:currency_converter/services/currency_converter_service.dart';
import 'package:currency_converter/states/conversion_controller/conversion_controller_provider.dart';
import 'package:currency_converter/states/fetch_currencies.dart';
import 'package:currency_converter/states/save_conversion.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final CurrencyConverterService currencyConverterService = CurrencyConverterService();
  final ConversionHistoryService conversionHistoryService = ConversionHistoryService();

  @override
  Widget build(BuildContext context) {
    var conversionController = ref.watch(conversionControllerProvider.notifier);
    var currentCovnersion = ref.watch(conversionControllerProvider);
    var fetchCurrencyProvider = ref.watch(fetchCurrenciesProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 24,
              left: 24,
              bottom: 32,
            ),
            child: fetchCurrencyProvider.when(
              data: (currencies) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Conversion",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConversionInputFrom(currencies: currencies),
                    const SizedBox(height: 16),
                    ConversionInputTo(currencies: currencies),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              currentCovnersion.valueTo == 0.0 && currentCovnersion.valueFrom != '' ? Colors.black : Colors.black38,
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => conversionController.performConversion(
                          onError: () => const AlertDialog(
                            title: Text('AlertDialog Title'),
                            content: Text('There was an error while converting the currency.'),
                          ),
                          // },
                          onSuccess: () async {
                            var currentConversion = ref.read(conversionControllerProvider);
                            await ref.read(saveConversionProvider(currentConversion).future);
                          },
                        ),
                        child: const Text(
                          'Make conversion',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          var error = await ref.read(deleteConversionHistoryProvider.future);
                          var backgroundColor = error == '' ? Colors.black : Colors.red;
                          var message = error == '' ? 'History has been deleted' : error;
                          if (context.mounted) {
                            Helper.displaySnackMessage(context, backgroundColor, message);
                          }
                        },
                        child: const Text(
                          'Delete history',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Container(),
            ),
          ),
        ),
      ),
    );
  }
}
